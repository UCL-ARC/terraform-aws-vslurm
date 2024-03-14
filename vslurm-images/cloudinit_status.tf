resource "terraform_data" "cloudinit_status" {
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = aws_instance.server.public_ip
      user        = var.username
      private_key = tls_private_key.global_key.private_key_pem
    }

    inline = [
      "echo 'Waiting for cloud-init to complete for server...'",
      "sudo cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'",
    ]
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = aws_instance.database.public_ip
      user        = var.username
      private_key = tls_private_key.global_key.private_key_pem
    }

    inline = [
      "echo 'Waiting for cloud-init to complete for database...'",
      "sudo cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'",
    ]
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = aws_instance.nfs_server.public_ip
      user        = var.username
      private_key = tls_private_key.global_key.private_key_pem
    }

    inline = [
      "echo 'Waiting for cloud-init to complete for nfs-server...'",
      "sudo cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'",
    ]
  }

}
