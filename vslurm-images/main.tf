provider "aws" {
  region = var.aws_region
}

# Provide some local variables to construct the ssh command
locals {
  ssh_args                 = "-i ${local_sensitive_file.ssh_private_key_pem.filename} -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
  ssh_key_name             = "${var.app_prefix}_id_rsa"
  server_ssh_user_host     = "${var.username}@${aws_instance.server.public_ip}"
  configurer_ssh_user_host = "${var.username}@${aws_instance.configurer.public_ip}"
  server_ssh_command       = "ssh ${local.ssh_args} ${local.server_ssh_user_host}"
  configurer_ssh_command   = "ssh ${local.ssh_args} ${local.configurer_ssh_user_host}"
  user_home                = "/home/${var.username}"
  mysql_socket             = "/var/lib/mysql/mysql.sock"
  slurm_dir                = "/etc/slurm"
  munge_dir                = "/etc/munge"
}
