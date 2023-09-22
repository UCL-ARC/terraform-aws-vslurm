data "cloudinit_config" "node_user_data" {
  part {
    filename     = "node_user_data"
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}/scripts/node_user_data",
      {
        nickname = "${var.aws_prefix}-c${var.index + 1}"
      }
    )
  }

  part {
    filename     = "node_cloud_init.yaml"
    content_type = "text/cloud-config"
    content      = file("${path.module}/scripts/node_cloud_init.yaml")
  }
}

resource "aws_instance" "node" {
  ami           = var.ami
  instance_type = var.node_instance_type
  key_name      = var.key_name

  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  user_data                   = data.cloudinit_config.node_user_data.rendered
  user_data_replace_on_change = true

  tags = {
    Name       = "${var.aws_prefix}-c${var.index + 1}"
    host_alias = "c${var.index + 1}"
  }
}
