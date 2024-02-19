
data "cloudinit_config" "cloudinit_configurer" {
  gzip = false

  part {
    filename     = "cloudinit_configurer"
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}/templates/cloudinit_configurer",
      {
        git_args            = var.git_args
        git_repo            = var.git_repo_ansible
        git_dir             = "${var.rhel9_root_home}/ansible-vslurm"
        ansible_dir         = "${var.rhel9_root_home}/ansible-vslurm"
        ansible_playbook    = "cluster.yaml"
        ansible_inventory   = "${var.rhel9_root_home}/ansible_hosts"
        ansible_remote_user = var.username
        nodes = concat(
          [
            aws_instance.server,
            aws_instance.database,
            aws_instance.login,
            aws_instance.nfs_server
          ],
          [for key, value in module.compute_node : value]
        )
      }
    )
  }

  part {
    filename     = "cloudinit_configurer.yaml"
    content_type = "text/cloud-config"
    content = templatefile(
      "${path.module}/templates/cloudinit_configurer.yaml",
      {
        root_home = var.rhel9_root_home
        ansible_hosts = templatefile(
          "${path.module}/templates/ansible_hosts",
          {
            server        = aws_instance.server,
            database      = aws_instance.database,
            login         = aws_instance.login,
            nfs_server    = aws_instance.nfs_server,
            compute_nodes = [for key, value in module.compute_node : value]
          }
        )
        ansible_variables = templatefile(
          "${path.module}/templates/ansible_variables.yaml",
          {
            cluster_name      = var.app_prefix,
            mysql_socket      = local.mysql_socket,
            log_dir           = var.rhel9_log_dir,
            slurm_dir         = local.slurm_dir,
            munge_dir         = local.munge_dir,
            epel9_gpg_key_url = var.epel9_gpg_key_url,
            epel9_rpm_url     = var.epel9_rpm_url,
            username          = var.username,
            user_home         = local.user_home,
            root_home         = var.rhel9_root_home
          }
        )
        private_key_base64 = base64encode(tls_private_key.global_key.private_key_pem)
      }
    )
  }
}


resource "aws_instance" "configurer" {
  ami           = var.rhel9_ami_id
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
