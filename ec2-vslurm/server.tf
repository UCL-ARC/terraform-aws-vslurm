resource "aws_instance" "server" {
  ami           = var.rhel9_ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.ssh.key_name

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.default.id]

  tags = {
    Name = "${var.aws_prefix}-server"
  }

  user_data = templatefile(
    "${path.module}/scripts/server_user_data",
    {
      nickname = "${var.aws_prefix}-server"
    }
  )

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
      # "echo '${tls_private_key.global_key.private_key_pem}' > /home/${local.ec2_username}/.ssh/id_rsa",
      "chmod 400 /home/${local.ec2_username}/.ssh/id_rsa",
      # "sudo sh -c 'echo ${self.private_ip} ${self.private_dns} server >> /etc/hosts'",
      # "sudo sh -c 'echo ${aws_instance.login.private_ip} ${aws_instance.login.private_dns} login >> /etc/hosts'",
      # "sudo sh -c 'echo ${module.node[0].private_ip} ${module.node[0].private_dns} c1 >> /etc/hosts'",
      # "sudo sh -c 'echo ${module.node[1].private_ip} ${module.node[1].private_dns} c2 >> /etc/hosts'",
      "ssh-keyscan server login c1 c2 >> /home/${local.ec2_username}/.ssh/known_hosts",
      "sudo sh -c 'echo [s] >> /etc/ansible/hosts'",
      "sudo sh -c 'echo server ansible_ssh_host=${self.private_ip} >> /etc/ansible/hosts'",
      "sudo sh -c 'echo [l] >> /etc/ansible/hosts'",
      "sudo sh -c 'echo login ansible_ssh_host=${aws_instance.login.private_ip} >> /etc/ansible/hosts'",
      "sudo sh -c 'echo [c] >> /etc/ansible/hosts'",
      "sudo sh -c 'echo c1 ansible_ssh_host=${module.node[0].private_ip} >> /etc/ansible/hosts'",
      "sudo sh -c 'echo c2 ansible_ssh_host=${module.node[1].private_ip} >> /etc/ansible/hosts'"
    ]
  }

  provisioner "file" {
    source      = "${path.module}/../ansible"
    destination = "/home/${local.ec2_username}"
  }

  provisioner "file" {
    content     = tls_private_key.global_key.private_key_pem
    destination = "/home/${local.ec2_username}/.ssh/id_rsa"
  }

  provisioner "file" {
    content = templatefile(
      "${path.module}/scripts/server_hosts",
      {
        server_ip  = self.private_ip
        server_dns = self.private_dns
        login_ip   = aws_instance.login.private_ip
        login_dns  = aws_instance.login.private_dns
        c1_ip      = module.node[0].private_ip
        c1_dns     = module.node[0].private_dns
        c2_ip      = module.node[1].private_ip
        c2_dns     = module.node[1].private_dns
      }
    )
    destination = "hosts"
  }

  provisioner "file" {
    content = templatefile(
      "${path.module}/scripts/server_ansible_hosts",
      {
        server_ip = self.private_ip
        login_ip  = aws_instance.login.private_ip
        c1_ip     = module.node[0].private_ip
        c2_ip     = module.node[1].private_ip
      }
    )
    destination = "ansible_hosts"
  }

}
