output "server_ssh_command" {
  value = local.ssh_command
}

output "server_username_and_host" {
  value = local.server_username_and_host
}

output "server_ssh_args" {
  value = local.ssh_args
}

output "deployer_ssh_command" {
  value       = local.deployer_ssh_command
  description = "Debug: An ssh command to access the deployer"
}

resource "local_file" "deployer_user_data_rendered" {
  content  = base64decode(data.cloudinit_config.deployer_user_data.rendered)
  filename = "${path.module}/logs/deployer_user_data_rendered"
}
