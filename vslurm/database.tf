data "cloudinit_config" "cloudinit_database" {
  part {
    filename     = "cloudinit"
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}/templates/cloudinit",
      {
        nickname = "${var.app_prefix}-database"
      }
    )
  }

  part {
    filename     = "cloudinit-cluster"
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}/templates/cloudinit.cluster",
      {
        epel9_rpm_url = var.epel9_rpm_url
        munge_dir     = local.munge_dir
        slurm_dir     = local.slurm_dir
        log_dir       = var.rhel9_log_dir
      }
    )
  }

  part {
    filename     = "cloudinit-cluster-database"
    content_type = "text/x-shellscript"
    content      = file("${path.module}/templates/cloudinit.cluster.database")
  }
}

resource "aws_instance" "database" {
  ami           = data.aws_ami.rhel9.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.ssh.key_name

  subnet_id              = data.aws_subnet.subnet.id
  vpc_security_group_ids = [aws_security_group.default.id]

  user_data                   = data.cloudinit_config.cloudinit_database.rendered
  user_data_replace_on_change = true

  tags = {
    Name       = "${var.app_prefix}-database"
    host_alias = "database"
  }
}
