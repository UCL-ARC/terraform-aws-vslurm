variable "aws_prefix" {
  type        = string
  description = "Prefix for the compute node AWS resources"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID of the subnet that the compute node instance will be deployed in"
}

variable "ami" {
  type        = string
  description = "AMI ID of the base image for the compute node"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security Group IDs to be applied to the compute node instance"
}

variable "index" {
  type        = number
  description = "Index of this node in the set. Integer"
}

variable "key_name" {
  type        = string
  description = "Name of the key pair that AWS will provide to the compute node instances"
}

variable "node_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Name of the instance type for the compute node instances"
}
