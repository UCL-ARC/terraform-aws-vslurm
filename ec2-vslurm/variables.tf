variable "aws_prefix" {
  type        = string
  default     = "vslurm"
  description = "Prefix to use when naming AWS resources"
}

variable "aws_region" {
  type        = string
  description = "AWS region to deploy the instances in"
}

variable "rhel9_ami_id" {
  type        = string
  description = "RHEL9 AMI ID for the instances"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "AWS instance type for the instances"
}

variable "node_count" {
  type        = number
  default     = 2
  description = "Number of compute nodes to initialize the cluster with"
}

variable "subnet_id" {
  type        = string
  description = "AWS subnet ID for the subnet to deploy the instances in"
}

variable "vpc_id" {
  type        = string
  description = "AWS VPC ID for the VPC that the subnet is deployed in"
}
