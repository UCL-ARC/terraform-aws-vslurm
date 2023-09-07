data "cloudinit_config" "server_user_data" {
  # Renders a multipart MIME file which:
  # - improves the prompt
  # - updates and installs packages
  # - schedules shutdown for +5 hours
  # - enables root login
  # - writes the private key for root

  part {
    filename     = "server_user_data"
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}/scripts/server_user_data",
      {
        nickname = "${var.aws_prefix}-server"
      }
    )
  }

  # part {
  #   filename     = "server_cloud_init.yaml"
  #   content_type = "text/cloud-config"
  #   content = templatefile(
  #     "${path.module}/scripts/server_cloud_init.yaml",
  #     {
  #       private_key  = tls_private_key.global_key.private_key_pem
  #       ec2_username = local.ec2_username
  #     }
  #   )
  # }
}


resource "aws_instance" "server" {
  ami           = var.rhel9_ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.ssh.key_name

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.default.id]

  tags = {
    Name       = "${var.aws_prefix}-server"
    host_alias = "server"
  }

  user_data                   = data.cloudinit_config.server_user_data.rendered
  user_data_replace_on_change = true
}
