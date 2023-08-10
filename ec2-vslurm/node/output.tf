output "private_ip" {
  value = aws_instance.node.private_ip
}

output "private_dns" {
  value = aws_instance.node.private_dns
}
