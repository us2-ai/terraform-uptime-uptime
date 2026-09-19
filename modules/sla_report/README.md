# sla_report

Submodule for creating Uptime.com SLA reports. The `services_selected` and `reporting_groups` blocks pass straight through to the provider, which type-checks them.

## Usage

```hcl
module "sla_report" {
  source = "path/to/terraform-uptime/modules/sla_report"

  name                       = "monthly"
  show_uptime_section        = true
  show_uptime_sla            = true
  show_response_time_section = true
  services_tags              = ["production"]
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
| [uptime_sla_report.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/sla_report) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Create | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | SLA report name | `string` | n/a | yes |
| <a name="input_default_date_range"></a> [default\_date\_range](#input\_default\_date\_range) | Default date range | `string` | `null` | no |
| <a name="input_show_uptime_section"></a> [show\_uptime\_section](#input\_show\_uptime\_section) | Show uptime section | `bool` | `null` | no |
| <a name="input_show_uptime_sla"></a> [show\_uptime\_sla](#input\_show\_uptime\_sla) | Show uptime SLA | `bool` | `null` | no |
| <a name="input_uptime_section_sort"></a> [uptime\_section\_sort](#input\_uptime\_section\_sort) | Uptime section sort order | `string` | `null` | no |
| <a name="input_filter_uptime_sla_violations"></a> [filter\_uptime\_sla\_violations](#input\_filter\_uptime\_sla\_violations) | Filter uptime SLA violations | `bool` | `null` | no |
| <a name="input_filter_with_downtime"></a> [filter\_with\_downtime](#input\_filter\_with\_downtime) | Filter services with downtime | `bool` | `null` | no |
| <a name="input_show_response_time_section"></a> [show\_response\_time\_section](#input\_show\_response\_time\_section) | Show response time section | `bool` | `null` | no |
| <a name="input_show_response_time_sla"></a> [show\_response\_time\_sla](#input\_show\_response\_time\_sla) | Show response time SLA | `bool` | `null` | no |
| <a name="input_response_time_section_sort"></a> [response\_time\_section\_sort](#input\_response\_time\_section\_sort) | Response time section sort order | `string` | `null` | no |
| <a name="input_filter_response_time_sla_violations"></a> [filter\_response\_time\_sla\_violations](#input\_filter\_response\_time\_sla\_violations) | Filter response time SLA violations | `bool` | `null` | no |
| <a name="input_filter_slowest"></a> [filter\_slowest](#input\_filter\_slowest) | Filter slowest services | `bool` | `null` | no |
| <a name="input_services_tags"></a> [services\_tags](#input\_services\_tags) | Tags to filter services | `set(string)` | `null` | no |
| <a name="input_services_selected"></a> [services\_selected](#input\_services\_selected) | Selected services for the report | `any` | `null` | no |
| <a name="input_reporting_groups"></a> [reporting\_groups](#input\_reporting\_groups) | Reporting groups | `any` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the SLA report |
| <a name="output_name"></a> [name](#output\_name) | The SLA report name |
| <a name="output_url"></a> [url](#output\_url) | The API URL of the SLA report |
<!-- END_TF_DOCS -->
