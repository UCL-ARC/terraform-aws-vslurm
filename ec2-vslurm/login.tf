data "cloudinit_config" "login_user_data" {
  part {
    filename     = "login_user_data"
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}/scripts/login_user_data",
      {
        nickname = "${var.aws_prefix}-login"
      }
    )
  }

  part {
    filename     = "login_cloud_init.yaml"
    content_type = "text/cloud-config"
    content = templatefile(
      "${path.module}/scripts/login_cloud_init.yaml",
      {}
    )
  }
}

resource "aws_instance" "login" {
  ami           = var.rhel9_ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.ssh.key_name

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.default.id]

  tags = {
    Name = "${var.aws_prefix}-login"
  }
}
