
data "cloudinit_config" "deployer_user_data" {
  # Renders a multipart MIME file which:
  # - updates packages
  # - sets up for ansible
  # - clones the git repo
  # - runs ansible
  # - dies
  gzip = false

  part {
    filename     = "deployer_user_data"
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}/scripts/deployer_user_data",
      {
        git_args         = "-b 8-configure-the-deployer-instance --depth=1"
        git_repo         = "https://github.com/UCL-ARC/terraform-aws-vslurm.git"
        git_dir          = "/root/terraform-aws-vslurm"
        ansible_dir      = "/root/terraform-aws-vslurm/ansible"
        ansible_playbook = "test.yaml"
      }
    )
  }

  part {
    filename     = "deployer_cloud_init.yaml"
    content_type = "text/cloud-config"
    content = templatefile(
      "${path.module}/scripts/deployer_cloud_init.yaml",
      {
        cluster_hosts = templatefile(
          "${path.module}/scripts/cluster_hosts",
          {
            nodes = concat(
              [
                aws_instance.server,
                aws_instance.login
              ],
              module.node[*]
            )
          }
        )
        ansible_hosts = templatefile(
          "${path.module}/scripts/ansible_hosts",
          {
            server        = aws_instance.server,
            login         = aws_instance.login,
            compute_nodes = module.node[*]
          }
        )
        private_key_base64 = base64encode(tls_private_key.global_key.private_key_pem)
      }
    )
  }
}


resource "aws_instance" "deployer" {
  ami           = var.rhel9_ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.ssh.key_name

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.default.id]

  tags = {
    Name = "${var.aws_prefix}-deployer"
  }

  user_data                   = data.cloudinit_config.deployer_user_data.rendered
  user_data_replace_on_change = true

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = local.ec2_username
      private_key = tls_private_key.global_key.private_key_pem
    }

    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "sudo cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'",
    ]
  }

  provisioner "local-exec" {
    command    = "scp ${local.ssh_args} ${local.ec2_username}@${self.public_ip}:/var/log/cloud-init-output.log ${local.ec2_username}@${self.public_ip}:/var/log/cloud-init.log ${path.module}/logs"
    on_failure = continue
  }
}
