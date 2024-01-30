# Create a default security group that:
# - permits all egress
# - permits ingress ssh from the local deployer
# - permits all ingress from resources inside the default sg

resource "aws_security_group" "default" {
  name        = "${var.app_prefix}-default"
  description = "Default security group"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "all_egress" {
  description = "Allow all egress by default"
  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"

  security_group_id = aws_security_group.default.id
}

resource "aws_vpc_security_group_ingress_rule" "ssh_from_local" {
  description = "TLS"
  from_port   = 22
  to_port     = 22
  ip_protocol = 6 # TCP
  cidr_ipv4   = "${data.http.local_ip.response_body}/32"

  security_group_id = aws_security_group.default.id
}

resource "aws_vpc_security_group_ingress_rule" "ingress_self" {
  ip_protocol                  = "-1"
  referenced_security_group_id = aws_security_group.default.id

  security_group_id = aws_security_group.default.id
}

# Create a security group for the nodes that permits all ingress and egress
# for traffic inside the VPC
# right now the nodes are in a public subnet
# but they should probably go to a private instead
resource "aws_security_group" "node" {
  name        = "${var.app_prefix}-node"
  description = "Security group for node networking"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "ingress_internal" {
  ip_protocol = "-1"
  cidr_ipv4   = data.aws_vpc.vpc.cidr_block

  security_group_id = aws_security_group.node.id
}

resource "aws_vpc_security_group_egress_rule" "egress_internal" {
  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"

  security_group_id = aws_security_group.node.id
}
