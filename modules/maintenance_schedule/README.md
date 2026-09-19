# maintenance_schedule

Submodule for creating Uptime.com account-level maintenance schedules, either recurring (`RRULE`) or one-off (`ONE_OFF`), targeting checks by ID or by tag ID. This is the replacement for the per-check `uptime_check_maintenance` resource that provider 3.0.0 removed; see [UPGRADE-3.0.md](../../UPGRADE-3.0.md).

## Usage

```hcl
module "maintenance_schedule" {
  source = "path/to/terraform-uptime/modules/maintenance_schedule"

  name                            = "weekly-patching"
  schedule_type                   = "RRULE"
  starts_at                       = "2026-10-03T02:00:00Z"
  rrule                           = "FREQ=WEEKLY;BYDAY=SA"
  duration_minutes                = 120
  pause_checks_during_maintenance = true
  services                        = [12345]
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
| [uptime_maintenance_schedule.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/maintenance_schedule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Create | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Maintenance schedule name | `string` | n/a | yes |
| <a name="input_schedule_type"></a> [schedule\_type](#input\_schedule\_type) | Recurrence type. RRULE requires rrule and duration\_minutes; ONE\_OFF requires duration\_minutes or ends\_at | `string` | n/a | yes |
| <a name="input_starts_at"></a> [starts\_at](#input\_starts\_at) | Start time in RFC 3339 format | `string` | n/a | yes |
| <a name="input_duration_minutes"></a> [duration\_minutes](#input\_duration\_minutes) | Maintenance window length in minutes | `number` | `null` | no |
| <a name="input_ends_at"></a> [ends\_at](#input\_ends\_at) | End time in RFC 3339 format | `string` | `null` | no |
| <a name="input_is_active"></a> [is\_active](#input\_is\_active) | Whether the maintenance schedule is active | `bool` | `null` | no |
| <a name="input_pause_checks_during_maintenance"></a> [pause\_checks\_during\_maintenance](#input\_pause\_checks\_during\_maintenance) | Pause checks during the maintenance window | `bool` | `null` | no |
| <a name="input_rrule"></a> [rrule](#input\_rrule) | RFC 5545 recurrence rule (e.g. FREQ=WEEKLY;BYDAY=SA) | `string` | `null` | no |
| <a name="input_services"></a> [services](#input\_services) | Service (check) IDs covered by the maintenance window | `list(number)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Service tag IDs covered by the maintenance window | `list(number)` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the maintenance schedule |
| <a name="output_name"></a> [name](#output\_name) | The name of the maintenance schedule |
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | Creation timestamp of the maintenance schedule |
| <a name="output_modified_at"></a> [modified\_at](#output\_modified\_at) | Last modification timestamp of the maintenance schedule |
<!-- END_TF_DOCS -->
