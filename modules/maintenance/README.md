# maintenance

Submodule for creating Uptime.com check maintenance windows. Maintenance windows pause alerting during scheduled periods.

## Usage

```hcl
module "maintenance" {
  source = "path/to/terraform-uptime/modules/maintenance"

  check_id = 12345

  state = "ACTIVE"

  schedule = [
    {
      type     = "WEEKLY"
      weekdays = ["MON", "WED", "FRI"]
      from_time = "02:00"
      to_time   = "04:00"
    }
  ]
}
```

<!-- BEGIN_TF_DOCS -->


## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_uptime"></a> [uptime](#requirement\_uptime) | >= 2.34 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_uptime"></a> [uptime](#provider\_uptime) | >= 2.34 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [uptime_check_maintenance.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/check_maintenance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Create | `bool` | `true` | no |
| <a name="input_check_id"></a> [check\_id](#input\_check\_id) | The ID of the check to attach maintenance to | `number` | n/a | yes |
| <a name="input_schedule"></a> [schedule](#input\_schedule) | Maintenance schedule | `any` | `null` | no |
| <a name="input_state"></a> [state](#input\_state) | Maintenance state | `string` | `null` | no |
| <a name="input_pause_on_scheduled_maintenance"></a> [pause\_on\_scheduled\_maintenance](#input\_pause\_on\_scheduled\_maintenance) | Pause check on scheduled maintenance | `bool` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_check_id"></a> [check\_id](#output\_check\_id) | The check ID the maintenance is attached to |
<!-- END_TF_DOCS -->
