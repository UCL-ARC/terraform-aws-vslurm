
data "cloudinit_config" "cloudinit_configurer" {
  gzip = false

  part {
    filename     = "cloudinit"
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}/templates/cloudinit",
      {
        nickname = "${var.app_prefix}-configurer"
      }
    )
  }
}

resource "aws_instance" "configurer" {
  ami           = data.aws_ami.rhel9.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.ssh.key_name

  subnet_id              = data.aws_subnet.subnet.id
  vpc_security_group_ids = [aws_security_group.default.id]

  tags = {
    Name = "${var.app_prefix}-configurer"
  }

  user_data                   = data.cloudinit_config.cloudinit_configurer.rendered
  user_data_replace_on_change = true

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = var.username
      private_key = tls_private_key.global_key.private_key_pem
    }

    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "sudo cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'",
    ]
  }

  provisioner "local-exec" {
    command    = "scp ${local.ssh_args} ${var.username}@${self.public_ip}:${var.rhel9_log_dir}/cloud-init-output.log ${var.username}@${self.public_ip}:${var.rhel9_log_dir}/cloud-init.log ${path.module}/logs"
    on_failure = continue
  }
}
