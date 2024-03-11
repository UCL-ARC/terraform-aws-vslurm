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
  app_prefix         = var.app_prefix
  node_name          = each.value
  key_name           = aws_key_pair.ssh.key_name
  subnet_id          = data.aws_subnet.subnet.id
  security_group_ids = [aws_security_group.default.id, aws_security_group.node.id]
  node_instance_type = var.instance_type
  ami                = data.aws_ami.rhel9.id
  user_data_rendered = data.cloudinit_config.cloudinit_compute_node.rendered
}

data "cloudinit_config" "cloudinit_compute_node" {
  part {
    filename     = "cloudinit"
    content_type = "text/cloud-config"
    content = file(
      "${path.module}/templates/cloudinit.yaml"
    )
  }

}
