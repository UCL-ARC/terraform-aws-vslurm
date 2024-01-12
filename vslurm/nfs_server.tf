data "cloudinit_config" "cloud_init_nfs_server" {
  part {
    filename     = "cloud_init"
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}/templates/cloud_init",
      {
        nickname = "${var.aws_prefix}-nfs-server"
      }
    )
  }

  part {
    filename     = "cloud_init.yaml"
    content_type = "text/cloud-config"
    content      = file("${path.module}/templates/cloud_init.yaml")
  }
}

resource "aws_instance" "nfs_server" {
  ami           = var.rhel9_ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.ssh.key_name

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.default.id]

  user_data                   = data.cloudinit_config.cloud_init_nfs_server.rendered
  user_data_replace_on_change = true

  tags = {
    Name       = "${var.aws_prefix}-nfs-server"
    host_alias = "nfs-server"
  }
}
