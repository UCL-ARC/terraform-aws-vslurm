locals {
  management_node = {
    server     = aws_instance.server,
    database   = aws_instance.database,
    login      = aws_instance.login,
    nfs_server = aws_instance.nfs_server
  }
}

resource "terraform_data" "configure_slurm" {

  triggers_replace = concat(
    local.management_node[*],
    aws_instance.compute_node[*]
  )

  connection {
    type        = "ssh"
    host        = aws_instance.configurer.public_ip
    user        = var.username
    private_key = tls_private_key.global_key.private_key_pem
  }

  provisioner "file" {
    content = templatefile(
      "${module.path}/templates/cluster_hosts",
      {
        nodes = concat(
          [for key, value in local.management_node : value],
          [for key, value in module.compute_node : value]
        )
      }
    )
    destination = "/etc/hosts"
  }

  provisioner "file" {
    content = templatefile(
      "${module.path}/templates/ansible_inventory",
      {
        management_nodes = local.management_node
        compute_nodes    = [for key, value in module.compute_node : value]
      }
    )
    destination = "${var.rhel9_root_home}/ansible_inventory"
  }

  provisioner "file" {
    content = templatefile(
      "${module.path}/templates/ansible_variables.yaml",
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
    destination = "${var.rhel9_root_home}/ansible_variables"
  }

  provisioner "file" {
    content     = tls_private_key.global_key.private_key_pem
    destination = "${var.rhel9_root_home}/.ssh/id_rsa"
  }

}
