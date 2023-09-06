# terraform-aws-vslurm/ec2-vslurm/node

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [cloudinit_config.node_user_data](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami"></a> [ami](#input\_ami) | AMI ID of the base image for the compute node | `string` | n/a | yes |
| <a name="input_aws_prefix"></a> [aws\_prefix](#input\_aws\_prefix) | Prefix for the compute node AWS resources | `string` | n/a | yes |
| <a name="input_index"></a> [index](#input\_index) | Index of this node in the set. Integer | `number` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Name of the key pair that AWS will provide to the compute node instances | `string` | n/a | yes |
| <a name="input_node_instance_type"></a> [node\_instance\_type](#input\_node\_instance\_type) | Name of the instance type for the compute node instances | `string` | `"t2.micro"` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Security Group IDs to be applied to the compute node instance | `list(string)` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID of the subnet that the compute node instance will be deployed in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_dns"></a> [private\_dns](#output\_private\_dns) | Private DNS address of the compute node |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | Private IP address of the compute node |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | Tags assigned to the compute node |

---
<!-- END_TF_DOCS -->
