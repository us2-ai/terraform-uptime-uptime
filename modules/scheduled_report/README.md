# scheduled_report

Submodule for scheduling recurring email delivery of an Uptime.com SLA report.

## Usage

```hcl
module "scheduled_report" {
  source = "path/to/terraform-uptime/modules/scheduled_report"

  name             = "weekly-sla"
  sla_report       = "monthly"
  recurrence       = "WEEKLY"
  on_weekday       = 1
  at_time          = 9
  file_type        = "PDF"
  recipient_emails = ["devops@example.com"]
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
| [uptime_scheduled_report.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/scheduled_report) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Create | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Report name | `string` | n/a | yes |
| <a name="input_sla_report"></a> [sla\_report](#input\_sla\_report) | SLA report to send on this schedule | `string` | n/a | yes |
| <a name="input_recurrence"></a> [recurrence](#input\_recurrence) | Delivery frequency: DAILY, WEEKLY, MONTHLY, QUARTERLY, YEARLY | `string` | `null` | no |
| <a name="input_at_time"></a> [at\_time](#input\_at\_time) | Hour of day to send report (0-23) | `number` | `null` | no |
| <a name="input_on_weekday"></a> [on\_weekday](#input\_on\_weekday) | Day of week for weekly reports | `number` | `null` | no |
| <a name="input_file_type"></a> [file\_type](#input\_file\_type) | Report file type: PDF or XLS | `string` | `null` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Enable scheduled report | `bool` | `null` | no |
| <a name="input_recipient_emails"></a> [recipient\_emails](#input\_recipient\_emails) | Email addresses to receive the report | `set(string)` | `null` | no |
| <a name="input_recipient_users"></a> [recipient\_users](#input\_recipient\_users) | Users to receive the report | `set(string)` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the scheduled report |
| <a name="output_name"></a> [name](#output\_name) | The scheduled report name |
| <a name="output_url"></a> [url](#output\_url) | The API URL of the scheduled report |
<!-- END_TF_DOCS -->
