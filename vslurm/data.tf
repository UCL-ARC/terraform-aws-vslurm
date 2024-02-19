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

# Identify the latest suitable RHEL image
data "aws_ami" "rhel9" {
  most_recent = true

  # This filters for RHEL 9+ images
  filter {
    name   = "name"
    values = [var.rhel9_ami_name_pattern]
  }

  # This filters for images which will work with the t2.micro type
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["309956199498"] # Red Hat
}

# Get the local deployer's IP address
# to permit incoming ssh traffic
data "http" "local_ip" {
  url = "https://api.ipify.org"
}
