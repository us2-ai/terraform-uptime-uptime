# integration

Submodule for creating Uptime.com alert integrations. Supports 17 integration types selected via the `type` variable.

## Usage

```hcl
module "integration" {
  source = "path/to/terraform-uptime/modules/integration"

  name           = "slack-alerts"
  type           = "slack"
  contact_groups = ["DevOps"]

  settings = {
    webhook_url = "https://hooks.slack.com/services/..."
    channel     = "#alerts"
  }
}
```

## Supported Types

cachet, datadog, geckoboard, jira\_servicedesk, klipfolio, microsoft\_teams, opsgenie, pagerduty, pushbullet, pushover, slack, status, statuspage, victorops, wavefront, webhook, zapier

<!-- BEGIN_TF_DOCS -->


## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.10.3 |
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
| [uptime_integration_cachet.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/integration_cachet) | resource |
| [uptime_integration_datadog.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/integration_datadog) | resource |
| [uptime_integration_geckoboard.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/integration_geckoboard) | resource |
| [uptime_integration_jira_servicedesk.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/integration_jira_servicedesk) | resource |
| [uptime_integration_klipfolio.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/integration_klipfolio) | resource |
| [uptime_integration_microsoft_teams.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/integration_microsoft_teams) | resource |
| [uptime_integration_opsgenie.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/integration_opsgenie) | resource |
| [uptime_integration_pagerduty.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/integration_pagerduty) | resource |
| [uptime_integration_pushbullet.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/integration_pushbullet) | resource |
| [uptime_integration_pushover.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/integration_pushover) | resource |
| [uptime_integration_slack.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/integration_slack) | resource |
| [uptime_integration_status.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/integration_status) | resource |
| [uptime_integration_statuspage.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/integration_statuspage) | resource |
| [uptime_integration_victorops.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/integration_victorops) | resource |
| [uptime_integration_wavefront.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/integration_wavefront) | resource |
| [uptime_integration_webhook.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/integration_webhook) | resource |
| [uptime_integration_zapier.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/integration_zapier) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Create | `bool` | `true` | no |
| <a name="input_type"></a> [type](#input\_type) | The type of integration to create | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name | `string` | n/a | yes |
| <a name="input_contact_groups"></a> [contact\_groups](#input\_contact\_groups) | Contact Groups | `list(string)` | `[]` | no |
| <a name="input_settings"></a> [settings](#input\_settings) | Integration-specific settings | `any` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the integration, or null when the integration is not created |
| <a name="output_name"></a> [name](#output\_name) | The name of the integration, or null when the integration is not created |
<!-- END_TF_DOCS -->
