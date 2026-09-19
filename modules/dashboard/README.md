# dashboard

Submodule for creating Uptime.com dashboards. The `alerts`, `metrics`, `selected`, and `services` blocks pass straight through to the provider, which type-checks them. `alerts`, `selected`, and `services` are required by the provider even when empty.

## Usage

```hcl
module "dashboard" {
  source = "path/to/terraform-uptime/modules/dashboard"

  name      = "Production"
  is_pinned = true

  alerts = {
    show_section = true
  }
  services = {
    show_section = true
    show = {
      uptime        = true
      response_time = true
    }
    sort = {
      primary   = "is_paused,cached_state_is_up"
      secondary = "-cached_last_down_alert_at"
    }
  }
  selected = {
    tags = ["production"]
  }
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
| [uptime_dashboard.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/dashboard) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Create | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Dashboard name | `string` | n/a | yes |
| <a name="input_is_pinned"></a> [is\_pinned](#input\_is\_pinned) | Pin dashboard to top of list | `bool` | `null` | no |
| <a name="input_ordering"></a> [ordering](#input\_ordering) | Dashboard position in list | `number` | `null` | no |
| <a name="input_alerts"></a> [alerts](#input\_alerts) | Alerts configuration | `any` | n/a | yes |
| <a name="input_metrics"></a> [metrics](#input\_metrics) | Metrics configuration | `any` | `null` | no |
| <a name="input_selected"></a> [selected](#input\_selected) | Selected services and tags | `any` | n/a | yes |
| <a name="input_services"></a> [services](#input\_services) | Services display configuration | `any` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the dashboard |
| <a name="output_name"></a> [name](#output\_name) | The dashboard name |
<!-- END_TF_DOCS -->
