module "compute_node" {
  count = var.node_count

  source             = "./compute_node"
  ami                = var.rhel9_ami_id
  aws_prefix         = var.aws_prefix
  security_group_ids = [aws_security_group.default.id, aws_security_group.node.id]
  subnet_id          = var.subnet_id
  index              = count.index
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
        nickname = "${var.aws_prefix}-c" # this can be fixed when i switch from count to foreach
      }
    )
  }

  part {
    filename     = "cloudinit.yaml"
    content_type = "text/cloud-config"
    content      = file("${path.module}/templates/cloudinit.yaml")
  }
}
