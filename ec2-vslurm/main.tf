provider "aws" {
  region = var.aws_region
}

# Provide some local variables to construct the ssh command
locals {
  ec2_username                 = "ec2-user"
  ssh_key_name                 = "ec2_id_rsa"
  server_username_and_host     = "${local.ec2_username}@${aws_instance.server.public_ip}"
  configurer_username_and_host = "${local.ec2_username}@${aws_instance.configurer.public_ip}"
  ssh_args                     = "-i ${local_sensitive_file.ssh_private_key_pem.filename} -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
  server_ssh_command           = "ssh ${local.ssh_args} ${local.server_username_and_host}"
  configurer_ssh_command       = "ssh ${local.ssh_args} ${local.configurer_username_and_host}"
}
