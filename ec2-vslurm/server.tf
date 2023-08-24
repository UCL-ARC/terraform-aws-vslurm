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

  part {
    filename     = "server_cloud_init.yaml"
    content_type = "text/cloud-config"
    content = templatefile(
      "${path.module}/scripts/server_cloud_init.yaml",
      {
        private_key  = tls_private_key.global_key.private_key_pem
        ec2_username = local.ec2_username
      }
    )
  }
}


resource "aws_instance" "server" {
  ami           = var.rhel9_ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.ssh.key_name

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.default.id]

  tags = {
    Name = "${var.aws_prefix}-server"
  }

  user_data = data.cloudinit_config.server_user_data.rendered
  user_data_replace_on_change = true

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = local.ec2_username
    private_key = tls_private_key.global_key.private_key_pem
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "sudo cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'",
    ]
  }

  # copies the ansible dir onto the server (in lieu of cloud-init:ansible-pull)
  provisioner "file" {
    source      = "${path.module}/../ansible"
    destination = "/home/${local.ec2_username}"
  }

  # writes a hosts file onto the server to be appended to /etc/hosts
  provisioner "file" {
    content = templatefile(
      "${path.module}/scripts/server_hosts",
      {
        server_ip  = self.private_ip
        server_dns = self.private_dns
        login_ip   = aws_instance.login.private_ip
        login_dns  = aws_instance.login.private_dns
        nodes      = module.node[*]
      }
    )
    destination = "hosts"
  }

  # writes an ansible inventory onto the server to be moved to /etc/ansible/hosts
  provisioner "file" {
    content = templatefile(
      "${path.module}/scripts/server_ansible_hosts",
      {
        server_ip = self.private_ip
        login_ip  = aws_instance.login.private_ip
        nodes     = module.node[*]
      }
    )
    destination = "ansible_hosts"
  }

  # moves the hosts files and keyscans
  provisioner "remote-exec" {
    inline = [
      "set -x",
      "sudo sh -c 'cat /home/${local.ec2_username}/hosts >> /etc/hosts'",
      "sudo sh -c 'cat /home/${local.ec2_username}/ansible_hosts >> /etc/ansible/hosts'",
      "ssh-keyscan server login c1 c2 >> /home/${local.ec2_username}/.ssh/known_hosts"
    ]
  }
}
