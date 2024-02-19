variable "app_prefix" {
  type        = string
  default     = "vslurm"
  description = "Prefix to use when naming AWS resources"
}

variable "username" {
  type        = string
  default     = "ec2-user"
  description = "Username for ssh connections"
}

variable "node_count" {
  type        = number
  default     = 2
  description = "Number of compute nodes to initialize the cluster with"
}

variable "epel9_gpg_key_url" {
  type        = string
  default     = "https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-9"
  description = "URL for the EPEL9 GPG key"
}

variable "epel9_rpm_url" {
  type        = string
  default     = "https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm"
  description = "URL for the EPEL9 RPM repository"
}

variable "rhel9_root_home" {
  type        = string
  default     = "/root"
  description = "Path on the RHEL9 instance to the root home directory"
}

variable "rhel9_log_dir" {
  type        = string
  default     = "/var/log"
  description = "Path on the RHEL9 instance to the log directory used by cloud-init"
}

variable "git_repo_ansible" {
  type        = string
  default     = "https://github.com/UCL-ARC/ansible-vslurm-config.git"
  description = "Github repository URL"
}

variable "git_args" {
  type        = string
  default     = "-b main --depth 1"
  description = "Options provided to git clone"
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
  default     = "t2.medium"
  description = "AWS instance type for the instances"
}

variable "subnet_id" {
  type        = string
  description = "AWS subnet ID for the subnet to deploy the instances in"
}

variable "vpc_name" {
  type        = string
  description = "Name of the AWS VPC that the instances will be deployed in"
}
