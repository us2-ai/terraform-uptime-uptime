# subaccount

Submodule for creating Uptime.com subaccounts.

## Usage

```hcl
module "subaccount" {
  source = "path/to/terraform-uptime/modules/subaccount"

  name = "staging"
}
```

<!-- BEGIN_TF_DOCS -->


## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_uptime"></a> [uptime](#requirement\_uptime) | >= 3.1 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_uptime"></a> [uptime](#provider\_uptime) | >= 3.1 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [uptime_subaccount.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/subaccount) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Create | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Subaccount name | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the subaccount |
| <a name="output_name"></a> [name](#output\_name) | The subaccount name |
| <a name="output_url"></a> [url](#output\_url) | The API URL of the subaccount |
<!-- END_TF_DOCS -->
