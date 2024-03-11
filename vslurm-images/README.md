# terraform-aws-vslurm/vslurm-images

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.31.0 |
| <a name="requirement_cloudinit"></a> [cloudinit](#requirement\_cloudinit) | >= 2.3.2 |
| <a name="requirement_http"></a> [http](#requirement\_http) | >= 3.4.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.4.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 4.0.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.31.0 |
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | >= 2.3.2 |
| <a name="provider_http"></a> [http](#provider\_http) | >= 3.4.0 |
| <a name="provider_local"></a> [local](#provider\_local) | >= 2.4.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | >= 4.0.4 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_compute_node"></a> [compute\_node](#module\_compute\_node) | ./compute_node | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_instance.configurer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.login](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.nfs_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.ssh](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.all_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_egress_rule.egress_internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.ingress_internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.ingress_self](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.ssh_from_local](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [local_file.cloudinit_configurer_rendered](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.ssh_public_key_openssh](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_sensitive_file.ssh_private_key_pem](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [terraform_data.cloudinit_status](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [terraform_data.configure_slurm](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [tls_private_key.global_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_ami.rhel9](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_subnet.subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [cloudinit_config.cloudinit_compute_node](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |
| [cloudinit_config.cloudinit_configurer](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |
| [cloudinit_config.cloudinit_database](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |
| [cloudinit_config.cloudinit_login](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |
| [cloudinit_config.cloudinit_nfs_server](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |
| [cloudinit_config.cloudinit_server](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |
| [http_http.local_ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_prefix"></a> [app\_prefix](#input\_app\_prefix) | Prefix to use when naming AWS resources | `string` | `"vslurm"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the instances in | `string` | n/a | yes |
| <a name="input_epel9_gpg_key_url"></a> [epel9\_gpg\_key\_url](#input\_epel9\_gpg\_key\_url) | URL for the EPEL9 GPG key | `string` | `"https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-9"` | no |
| <a name="input_epel9_rpm_url"></a> [epel9\_rpm\_url](#input\_epel9\_rpm\_url) | URL for the EPEL9 RPM repository | `string` | `"https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm"` | no |
| <a name="input_git_args"></a> [git\_args](#input\_git\_args) | Options provided to git clone | `string` | `"-b v1.0.1 --depth 1 -q"` | no |
| <a name="input_git_repo_ansible"></a> [git\_repo\_ansible](#input\_git\_repo\_ansible) | Github repository URL | `string` | `"https://github.com/UCL-ARC/ansible-vslurm-config.git"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | AWS instance type for the instances | `string` | `"t2.medium"` | no |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | Number of compute nodes to initialize the cluster with | `number` | `2` | no |
| <a name="input_rhel9_ami_name_pattern"></a> [rhel9\_ami\_name\_pattern](#input\_rhel9\_ami\_name\_pattern) | RHEL9 AMI name pattern to match on for the instances | `string` | `"RHEL-9.2.0*"` | no |
| <a name="input_rhel9_log_dir"></a> [rhel9\_log\_dir](#input\_rhel9\_log\_dir) | Path on the RHEL9 instance to the log directory used by cloud-init | `string` | `"/var/log"` | no |
| <a name="input_rhel9_root_home"></a> [rhel9\_root\_home](#input\_rhel9\_root\_home) | Path on the RHEL9 instance to the root home directory | `string` | `"/root"` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | Name of the AWS subnet to deploy the instances in | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | Username for ssh connections | `string` | `"ec2-user"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the AWS VPC that the instances will be deployed in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_configurer_ssh_command"></a> [configurer\_ssh\_command](#output\_configurer\_ssh\_command) | An SSH command to access the configurer EC2 instance |
| <a name="output_server_ssh_command"></a> [server\_ssh\_command](#output\_server\_ssh\_command) | An ssh command to connect from the local deployer to the server EC2 instance |

---
<!-- END_TF_DOCS -->
