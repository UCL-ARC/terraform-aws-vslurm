terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.31.0"
    }
  }
}

resource "aws_instance" "node" {
  ami           = var.ami
  instance_type = var.node_instance_type
  key_name      = var.key_name

  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  user_data                   = var.user_data_rendered
  user_data_replace_on_change = true

  tags = {
    Name       = "${var.app_prefix}-${var.node_name}"
    host_alias = var.node_name
  }
}
