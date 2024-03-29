data "cloudinit_config" "cloudinit_server" {
  part {
    filename     = "cloudinit"
    content_type = "text/cloud-config"
    content = file(
      "${path.module}/templates/cloudinit.yaml"
    )
  }
}

resource "aws_instance" "server" {
  ami           = data.aws_ami.server.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.ssh.key_name

  subnet_id              = data.aws_subnet.subnet.id
  vpc_security_group_ids = [aws_security_group.default.id]

  user_data                   = data.cloudinit_config.cloudinit_server.rendered
  user_data_replace_on_change = true

  tags = {
    Name       = "${var.app_prefix}-server"
    host_alias = "server"
  }
}
