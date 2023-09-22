data "cloudinit_config" "database_user_data" {
  part {
    filename     = "database_user_data"
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}/scripts/database_user_data",
      {
        nickname = "${var.aws_prefix}-database"
      }
    )
  }

  part {
    filename     = "database_cloud_init.yaml"
    content_type = "text/cloud-config"
    content      = file("${path.module}/scripts/database_cloud_init.yaml")
  }
}

resource "aws_instance" "database" {
  ami           = var.rhel9_ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.ssh.key_name

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.default.id]

  user_data                   = data.cloudinit_config.database_user_data.rendered
  user_data_replace_on_change = true

  tags = {
    Name       = "${var.aws_prefix}-database"
    host_alias = "database"
  }
}
