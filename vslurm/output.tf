output "server_ssh_command" {
  value       = local.server_ssh_command
  description = "An ssh command to access the server"
}

output "server_username_and_host" {
  value       = local.server_username_and_host
  description = "The server username and public IP address"
}

output "ssh_args" {
  value       = local.ssh_args
  description = "Flags for the SSH command"
}

output "configurer_username_and_host" {
  value       = local.configurer_username_and_host
  description = "The configurer username and public IP address"
}

output "configurer_ssh_command" {
  value       = local.configurer_ssh_command
  description = "An SSH command to access the configurer"
}

resource "local_file" "configurer_user_data_rendered" {
  content  = base64decode(data.cloudinit_config.configurer_user_data.rendered)
  filename = "${path.module}/logs/configurer_user_data_rendered"
}
