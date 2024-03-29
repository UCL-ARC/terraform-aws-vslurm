locals {
  management_node = {
    server     = aws_instance.server,
    database   = aws_instance.database,
    login      = aws_instance.login,
    nfs_server = aws_instance.nfs_server
  }

  timestamp     = formatdate("YYYYMMDDhhmm", timestamp())
  git_repo_path = "/home/${var.username}/ansible-vslurm_${local.timestamp}"
}

resource "terraform_data" "configure_slurm" {

  depends_on = [terraform_data.cloudinit_status]

  triggers_replace = concat(
    [for key, value in local.management_node : value.private_ip],
    [for key, value in module.compute_node : value.private_ip]
  )

  connection {
    type        = "ssh"
    host        = aws_instance.configurer.public_ip
    user        = var.username
    private_key = tls_private_key.global_key.private_key_pem
  }

  provisioner "file" {
    content = templatefile(
      "${path.module}/templates/cluster_hosts",
      {
        nodes = concat(
          [for key, value in local.management_node : value],
          [for key, value in module.compute_node : value]
        )
      }
    )
    destination = "/home/${var.username}/hosts"
  }

  provisioner "file" {
    content = templatefile(
      "${path.module}/templates/ansible_inventory",
      {
        management_nodes  = local.management_node
        compute_nodes     = [for key, value in module.compute_node : value]
        cluster_name      = var.app_prefix
        mysql_socket      = local.mysql_socket
        log_dir           = var.rhel9_log_dir
        slurm_dir         = local.slurm_dir
        munge_dir         = local.munge_dir
        epel9_gpg_key_url = var.epel9_gpg_key_url
        epel9_rpm_url     = var.epel9_rpm_url
        username          = var.username
        user_home         = local.user_home
        root_home         = var.rhel9_root_home
        ssh_rsa_key_path  = "${local.user_home}/.ssh/id_rsa"
      }
    )
    destination = "/home/${var.username}/ansible_inventory"
  }

  provisioner "file" {
    content     = tls_private_key.global_key.private_key_pem
    destination = "/home/${var.username}/.ssh/id_rsa"
  }

  provisioner "remote-exec" {
    inline = [
      "set -e -x",
      "sudo bash ./hosts",
      "chmod 0700 /home/${var.username}/.ssh/id_rsa",
      "git clone ${var.git_args} ${var.git_repo_ansible} ${local.git_repo_path}",
      "cd ${local.git_repo_path}",
      "ansible-playbook cluster.yaml --tags common_init",
      "ansible-playbook cluster.yaml --tags slurm_common",
      "ansible-playbook cluster.yaml --tags slurm_database",
      "ansible-playbook cluster.yaml --tags slurm_server",
      "ansible-playbook cluster.yaml --tags slurm_login",
      "ansible-playbook cluster.yaml --tags slurm_compute",
      "ansible all -m ansible.builtin.reboot",
      "ansible-playbook cluster.yaml"
    ]
  }
}
