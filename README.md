# terraform-template

## ARC Terraform template

⚠️ This repository is still under construction! ⚠️

A Terraform template for new ARC Terraform projects or modules. It has a
suggested skeleton structure and GitHub Actions workflows.

## Usage

1. Fork this repo. If creating a self-contained module, name your repo
   according to the [module naming convention](https://developer.hashicorp.com/terraform/registry/modules/publish)
   of `terraform-<PROVIDER>-<NAME>`.
2. Change [CODEOWNERS](.github/CODEOWNERS) to you / your Team.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.4 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.4.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [random_id.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_prefix"></a> [prefix](#input\_prefix) | A dummy prefix. | `string` | `"my-test"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_random_val"></a> [random\_val](#output\_random\_val) | List your outputs here. |

---
<!-- END_TF_DOCS -->
