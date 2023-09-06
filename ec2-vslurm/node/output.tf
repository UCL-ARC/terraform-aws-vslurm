output "node_id" {
  value       = "c${var.index + 1}"
  description = "Unique identifier for the compute node"
}

output "private_ip" {
  value       = aws_instance.node.private_ip
  description = "Private IP address of the compute node"
}

output "private_dns" {
  value       = aws_instance.node.private_dns
  description = "Private DNS address of the compute node"
}

output "tags_all" {
  value       = aws_instance.node.tags_all
  description = "Tags assigned to the compute node"
}
