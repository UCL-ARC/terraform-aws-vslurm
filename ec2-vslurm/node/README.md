<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami"></a> [ami](#input\_ami) | n/a | `string` | n/a | yes |
| <a name="input_aws_prefix"></a> [aws\_prefix](#input\_aws\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_index"></a> [index](#input\_index) | Index of this node in the set. Integer | `number` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | n/a | `string` | n/a | yes |
| <a name="input_node_instance_type"></a> [node\_instance\_type](#input\_node\_instance\_type) | n/a | `string` | `"t2.micro"` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | n/a | `list(string)` | n/a | yes |
| <a name="input_server_private_ip"></a> [server\_private\_ip](#input\_server\_private\_ip) | n/a | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_dns"></a> [private\_dns](#output\_private\_dns) | n/a |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | n/a |

---
<!-- END_TF_DOCS -->