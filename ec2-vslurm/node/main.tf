resource "aws_instance" "node" {
  ami           = var.ami
  instance_type = var.node_instance_type
  key_name      = var.key_name

  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = "${var.aws_prefix}-c${var.index + 1}"
  }

  user_data = templatefile(
    "${path.module}/scripts/node_user_data",
    {
      nickname = "${var.aws_prefix}-c${var.index + 1}"
    }
  )
}
