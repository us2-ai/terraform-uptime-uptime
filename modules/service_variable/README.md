# service_variable

Submodule for creating Uptime.com service variables, which inject one property of a stored credential into a check's configuration so the value never appears in the check itself.

## Usage

```hcl
module "service_variable" {
  source = "path/to/terraform-uptime/modules/service_variable"

  service_id    = 12345
  credential_id = 678
  variable_name = "API_TOKEN"
  property_name = "secret"
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
| [uptime_service_variable.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/service_variable) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Create | `bool` | `true` | no |
| <a name="input_service_id"></a> [service\_id](#input\_service\_id) | The ID of the check/service this variable belongs to | `number` | n/a | yes |
| <a name="input_credential_id"></a> [credential\_id](#input\_credential\_id) | The ID of the credential containing the sensitive value | `number` | n/a | yes |
| <a name="input_variable_name"></a> [variable\_name](#input\_variable\_name) | The variable name as referenced in the check configuration | `string` | n/a | yes |
| <a name="input_property_name"></a> [property\_name](#input\_property\_name) | The property name from the credential to use | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the service variable |
| <a name="output_variable_name"></a> [variable\_name](#output\_variable\_name) | The variable name |
<!-- END_TF_DOCS -->
