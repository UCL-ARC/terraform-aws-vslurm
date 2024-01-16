
data "cloudinit_config" "cloudinit_configurer" {
  gzip = false

  part {
    filename     = "cloudinit_configurer"
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}/templates/cloudinit_configurer",
      {
        git_args            = "-b main --depth=1"
        git_repo            = "https://github.com/UCL-ARC/terraform-aws-vslurm.git"
        git_dir             = "${var.rhel9_root_home}/terraform-aws-vslurm"
        ansible_dir         = "${var.rhel9_root_home}/terraform-aws-vslurm/ansible"
        ansible_playbook    = "cluster.yaml"
        ansible_inventory   = "${var.rhel9_root_home}/ansible_hosts"
        ansible_remote_user = local.ec2_username
        nodes = concat(
          [
            aws_instance.server,
            aws_instance.database,
            aws_instance.login,
            aws_instance.nfs_server
          ],
          module.compute_node[*]
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
            compute_nodes = module.compute_node[*]
          }
        )
        ansible_variables = templatefile(
          "${path.module}/templates/ansible_variables.yaml",
          {
            cluster_name      = var.aws_prefix,
            mysql_socket      = local.mysql_socket,
            log_dir           = var.rhel9_log_dir,
            slurm_dir         = local.slurm_dir,
            munge_dir         = local.munge_dir,
            epel9_gpg_key_url = local.epel9_gpg_key_url,
            epel9_rpm_url     = local.epel9_rpm_url,
            username          = local.ec2_username,
            user_home         = local.ec2_user_home,
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

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.default.id]

  tags = {
    Name = "${var.aws_prefix}-configurer"
  }

  user_data                   = data.cloudinit_config.cloudinit_configurer.rendered
  user_data_replace_on_change = true

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = local.ec2_username
      private_key = tls_private_key.global_key.private_key_pem
    }

    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "sudo cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'",
    ]
  }

  provisioner "local-exec" {
    command    = "scp ${local.ssh_args} ${local.ec2_username}@${self.public_ip}:${var.rhel9_log_dir}/cloud-init-output.log ${local.ec2_username}@${self.public_ip}:${var.rhel9_log_dir}/cloud-init.log ${path.module}/logs"
    on_failure = continue
  }
}
