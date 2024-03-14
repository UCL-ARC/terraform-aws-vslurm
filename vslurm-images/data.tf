# Get data about the VPC
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

# Get data about the subnet
data "aws_subnet" "subnet" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = [var.subnet_name]
  }
}

data "aws_ami" "configurer" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_name_pattern_configurer]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = [var.ami_owner]
}

data "aws_ami" "server" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_name_pattern_server]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = [var.ami_owner]
}

data "aws_ami" "database" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_name_pattern_database]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = [var.ami_owner]
}

data "aws_ami" "login" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_name_pattern_login]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = [var.ami_owner]
}

data "aws_ami" "nfs_server" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_name_pattern_nfs_server]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = [var.ami_owner]
}

data "aws_ami" "compute_node" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_name_pattern_compute_node]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = [var.ami_owner]
}

# Get the local deployer's IP address
# to permit incoming ssh traffic
data "http" "local_ip" {
  url = "https://api.ipify.org"
}
