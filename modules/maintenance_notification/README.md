# maintenance_notification

Submodule for creating Uptime.com maintenance notifications, which alert a contact group a set number of seconds before or after a maintenance schedule starts or ends.

## Usage

```hcl
module "maintenance_notification" {
  source = "path/to/terraform-uptime/modules/maintenance_notification"

  schedule_id    = 12345
  event          = "START"
  offset         = -1800 # 30 minutes before the window starts
  contact_groups = [678]
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
| [uptime_maintenance_notification.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/maintenance_notification) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Create | `bool` | `true` | no |
| <a name="input_schedule_id"></a> [schedule\_id](#input\_schedule\_id) | The ID of the maintenance schedule this notification belongs to | `number` | n/a | yes |
| <a name="input_event"></a> [event](#input\_event) | Event type the notification fires on (START or END) | `string` | n/a | yes |
| <a name="input_offset"></a> [offset](#input\_offset) | Offset in seconds relative to the event; negative means before the event | `number` | n/a | yes |
| <a name="input_contact_groups"></a> [contact\_groups](#input\_contact\_groups) | Contact group IDs to notify | `list(number)` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the maintenance notification |
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | Creation timestamp of the maintenance notification |
| <a name="output_modified_at"></a> [modified\_at](#output\_modified\_at) | Last modification timestamp of the maintenance notification |
<!-- END_TF_DOCS -->
