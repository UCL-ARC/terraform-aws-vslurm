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

output "deployer_username_and_host" {
  value       = local.deployer_username_and_host
  description = "The deployer username and public IP address"
}

output "deployer_ssh_command" {
  value       = local.deployer_ssh_command
  description = "An SSH command to access the deployer"
}

resource "local_file" "deployer_user_data_rendered" {
  content  = base64decode(data.cloudinit_config.deployer_user_data.rendered)
  filename = "${path.module}/logs/deployer_user_data_rendered"
}
