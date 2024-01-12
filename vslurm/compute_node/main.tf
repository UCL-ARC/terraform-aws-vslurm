resource "aws_instance" "node" {
  ami           = var.ami
  instance_type = var.node_instance_type
  key_name      = var.key_name

  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  user_data                   = var.user_data_rendered
  user_data_replace_on_change = true

  tags = {
    Name       = "${var.aws_prefix}-c${var.index + 1}"
    host_alias = "c${var.index + 1}"
  }
}
