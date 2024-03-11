# terraform-aws-vslurm/vslurm/node

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.31.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.31.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami"></a> [ami](#input\_ami) | AMI ID of the base image for the compute node | `string` | n/a | yes |
| <a name="input_app_prefix"></a> [app\_prefix](#input\_app\_prefix) | Prefix for the compute node AWS resources | `string` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Name of the key pair that AWS will provide to the compute node instance | `string` | n/a | yes |
| <a name="input_node_instance_type"></a> [node\_instance\_type](#input\_node\_instance\_type) | AWS instance type for the compute node instance | `string` | `"t2.micro"` | no |
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | Unique identifier of this node in the cluster | `string` | n/a | yes |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Security Group IDs to be applied to the compute node instance | `list(string)` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID of the subnet that the compute node instance will be deployed in | `string` | n/a | yes |
| <a name="input_user_data_rendered"></a> [user\_data\_rendered](#input\_user\_data\_rendered) | Cloud init user data for the compute node instance | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_dns"></a> [private\_dns](#output\_private\_dns) | Private DNS address of the compute node |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | Private IP address of the compute node |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | Tags assigned to the compute node |

---
<!-- END_TF_DOCS -->
