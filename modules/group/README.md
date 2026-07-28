# group

Submodule for creating Uptime.com check groups with shared alerting and SLA configuration.

## Usage

```hcl
module "group" {
  source = "path/to/terraform-uptime/modules/group"

  name           = "production-checks"
  contact_groups = ["DevOps"]
  tags           = ["production"]

  config = {
    down_condition             = "ANY"
    uptime_percent_calculation = "AVERAGE"
  }
}
```

<!-- BEGIN_TF_DOCS -->


## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_uptime"></a> [uptime](#requirement\_uptime) | >= 2.31 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_uptime"></a> [uptime](#provider\_uptime) | >= 2.31 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [uptime_check_group.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/check_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | A conditional indicator to enable checks | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the event rule | `string` | n/a | yes |
| <a name="input_contact_groups"></a> [contact\_groups](#input\_contact\_groups) | The personal team to create the send alerts to | `list(string)` | `[]` | no |
| <a name="input_is_paused"></a> [is\_paused](#input\_is\_paused) | Is paused? | `bool` | `false` | no |
| <a name="input_notes"></a> [notes](#input\_notes) | Is notes | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for which this resource belongs to | `list(string)` | `[]` | no |
| <a name="input_include_in_global_metrics"></a> [include\_in\_global\_metrics](#input\_include\_in\_global\_metrics) | Include in global metrics | `bool` | `false` | no |
| <a name="input_sla"></a> [sla](#input\_sla) | SLA | `any` | `{}` | no |
| <a name="input_config"></a> [config](#input\_config) | Group config | `any` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the check group |
| <a name="output_name"></a> [name](#output\_name) | The name of the check group |
<!-- END_TF_DOCS -->
