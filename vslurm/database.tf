data "cloudinit_config" "cloudinit_database" {
  part {
    filename     = "cloudinit"
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}/templates/cloudinit",
      {
        nickname = "${var.app_prefix}-database"
      }
    )
  }

  part {
    filename     = "cloudinit.yaml"
    content_type = "text/cloud-config"
    content      = file("${path.module}/templates/cloudinit.yaml")
  }
}

resource "aws_instance" "database" {
  ami           = data.aws_ami.rhel9.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.ssh.key_name

  subnet_id              = data.aws_subnet.subnet.id
  vpc_security_group_ids = [aws_security_group.default.id]

  user_data                   = data.cloudinit_config.cloudinit_database.rendered
  user_data_replace_on_change = true

  tags = {
    Name       = "${var.app_prefix}-database"
    host_alias = "database"
  }
}
