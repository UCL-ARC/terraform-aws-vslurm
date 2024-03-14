output "server_ssh_command" {
  value       = local.server_ssh_command
  description = "An ssh command to connect from the local deployer to the server EC2 instance"
}

output "configurer_ssh_command" {
  value       = local.configurer_ssh_command
  description = "An SSH command to access the configurer EC2 instance"
}

resource "local_file" "cloudinit_configurer_rendered" {
  content  = base64decode(data.cloudinit_config.cloudinit_configurer.rendered)
  filename = "${path.module}/logs/cloudinit_configurer_rendered"
}
