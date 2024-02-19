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

# Get the local deployer's IP address
# to permit incoming ssh traffic
data "http" "local_ip" {
  url = "https://api.ipify.org"
}
