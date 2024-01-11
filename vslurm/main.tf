provider "aws" {
  region = var.aws_region
}

# Provide some local variables to construct the ssh command
locals {
  ec2_username                 = "ec2-user"
  ec2_user_home                = "/home/${local.ec2_username}"
  ssh_key_name                 = "${var.aws_prefix}_id_rsa"
  server_username_and_host     = "${local.ec2_username}@${aws_instance.server.public_ip}"
  configurer_username_and_host = "${local.ec2_username}@${aws_instance.configurer.public_ip}"
  ssh_args                     = "-i ${local_sensitive_file.ssh_private_key_pem.filename} -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
  server_ssh_command           = "ssh ${local.ssh_args} ${local.server_username_and_host}"
  configurer_ssh_command       = "ssh ${local.ssh_args} ${local.configurer_username_and_host}"
  mysql_socket                 = "/var/lib/mysql/mysql.sock"
  slurm_dir                    = "/etc/slurm"
  munge_dir                    = "/etc/munge"
  epel9_gpg_key_url            = "https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-9"
  epel9_rpm_url                = "https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm"
}
