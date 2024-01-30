variable "app_prefix" {
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

variable "node_name" {
  type        = string
  description = "Unique identifier of this node in the cluster"
}

variable "key_name" {
  type        = string
  description = "Name of the key pair that AWS will provide to the compute node instance"
}

variable "node_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "AWS instance type for the compute node instance"
}

variable "user_data_rendered" {
  type        = string
  description = "Cloud init user data for the compute node instance"
}
