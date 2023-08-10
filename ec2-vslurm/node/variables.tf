variable "aws_prefix" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "ami" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "server_private_ip" {
  type = string
}

variable "index" {
  type        = number
  description = "Index of this node in the set. Integer"
}

variable "key_name" {
  type = string
}

variable "node_instance_type" {
  type    = string
  default = "t2.micro"
}
