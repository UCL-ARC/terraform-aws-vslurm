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
    "${path.module}/cloud_init.server.sh",
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
      "echo '${tls_private_key.global_key.private_key_pem}' > /home/${local.ec2_username}/.ssh/id_rsa",
      "chmod 400 /home/${local.ec2_username}/.ssh/id_rsa",
      "sudo sh -c 'echo ${self.private_ip} ${self.private_dns} server >> /etc/hosts'",
      "sudo sh -c 'echo ${aws_instance.login.private_ip} ${aws_instance.login.private_dns} login >> /etc/hosts'",
      "sudo sh -c 'echo ${module.node[0].private_ip} ${module.node[0].private_dns} node0 >> /etc/hosts'",
      "sudo sh -c 'echo ${module.node[1].private_ip} ${module.node[1].private_dns} node1 >> /etc/hosts'",
      "ssh-keyscan server login node0 node1 >> /home/${local.ec2_username}/.ssh/known_hosts",
      "sudo sh -c 'echo [s] >> /etc/ansible/hosts'",
      "sudo sh -c 'echo server ansible_ssh_host=${self.private_ip} >> /etc/ansible/hosts'",
      "sudo sh -c 'echo [l] >> /etc/ansible/hosts'",
      "sudo sh -c 'echo login ansible_ssh_host=${aws_instance.login.private_ip} >> /etc/ansible/hosts'",
      "sudo sh -c 'echo [c] >> /etc/ansible/hosts'",
      "sudo sh -c 'echo c1 ansible_ssh_host=${module.node[0].private_ip} >> /etc/ansible/hosts'",
      "sudo sh -c 'echo c2 ansible_ssh_host=${module.node[1].private_ip} >> /etc/ansible/hosts'"
    ]
  }
}
