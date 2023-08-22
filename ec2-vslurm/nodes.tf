module "node" {
  count = var.node_count

  source             = "./node"
  ami                = var.rhel9_ami_id
  aws_prefix         = var.aws_prefix
  security_group_ids = [aws_security_group.default.id, aws_security_group.node.id]
  subnet_id          = var.subnet_id
  index              = count.index
  key_name           = aws_key_pair.ssh.key_name
  node_instance_type = var.instance_type
}
