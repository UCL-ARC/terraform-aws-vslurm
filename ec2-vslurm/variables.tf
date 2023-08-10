variable "aws_prefix" {
  type        = string
  default     = "vslurm"
  description = "Prefix to use when naming AWS resources"
}

variable "aws_region" {
  type    = string
}

variable "rhel9_ami_id" {
  type    = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "node_count" {
  type    = number
  default = 2
}

variable "subnet_id" {
  type    = string
}

variable "vpc_id" {
  type    = string
}
