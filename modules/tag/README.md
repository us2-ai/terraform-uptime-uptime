# tag

Submodule for creating Uptime.com tags with optional color.

## Usage

```hcl
module "tag" {
  source = "path/to/terraform-uptime/modules/tag"

  tag       = "production"
  color_hex = "#FF0000"
}
```

<!-- BEGIN_TF_DOCS -->


## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_uptime"></a> [uptime](#requirement\_uptime) | >= 3.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_uptime"></a> [uptime](#provider\_uptime) | >= 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [uptime_tag.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/tag) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Create | `bool` | `true` | no |
| <a name="input_tag"></a> [tag](#input\_tag) | Tag | `string` | n/a | yes |
| <a name="input_color_hex"></a> [color\_hex](#input\_color\_hex) | Tag color as a hex code (e.g. "#cccccc"). Required by the provider; defaults to "#cccccc" when unset. | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the tag |
| <a name="output_tag"></a> [tag](#output\_tag) | The tag name |
<!-- END_TF_DOCS -->
