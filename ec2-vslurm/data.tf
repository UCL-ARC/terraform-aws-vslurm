# Get data about the VPC
data "aws_vpc" "vpc" {
  id = var.vpc_id
}

# Get the deployer's IP address (that's you)
# to permit incoming ssh traffic
data "http" "local_ip" {
  url = "https://api.ipify.org"
}
