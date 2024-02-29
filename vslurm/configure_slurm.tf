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

}
