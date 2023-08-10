resource "aws_instance" "login" {
  ami           = var.rhel9_ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.ssh.key_name

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.default.id]

  tags = {
    Name = "${var.aws_prefix}-login"
  }

  user_data = templatefile(
    "${path.module}/cloud_init.login.sh",
    {
      nickname = "${var.aws_prefix}-login"
    }
  )
}
