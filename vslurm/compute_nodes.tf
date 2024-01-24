locals {
  node_counts = {
    "basic" = var.node_count
  }
  compute_nodes = {
    for name, count in local.node_counts : name => [
      for i in range(1, count + 1) : format("node-%s-%02d", name, i)
    ]
  }
}

module "compute_node" {
  for_each = toset(local.compute_nodes["basic"])

  source             = "./compute_node"
  ami                = var.rhel9_ami_id
  aws_prefix         = var.aws_prefix
  security_group_ids = [aws_security_group.default.id, aws_security_group.node.id]
  subnet_id          = var.subnet_id
  node_name          = each.value
  key_name           = aws_key_pair.ssh.key_name
  node_instance_type = var.instance_type
  user_data_rendered = data.cloudinit_config.cloudinit_compute_node.rendered
}

data "cloudinit_config" "cloudinit_compute_node" {
  part {
    filename     = "cloudinit"
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}/templates/cloudinit",
      {
        nickname = "${var.aws_prefix}-node-basic" # todo: this can be fixed when i switch from count to foreach
      }
    )
  }

  part {
    filename     = "cloudinit.yaml"
    content_type = "text/cloud-config"
    content      = file("${path.module}/templates/cloudinit.yaml")
  }
}
