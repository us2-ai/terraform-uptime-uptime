# contact

Submodule for creating Uptime.com contact groups: the email, SMS, phone call, integration, and push notification targets that a check alerts.

## Usage

```hcl
module "contact" {
  source = "path/to/terraform-uptime/modules/contact"

  name       = "oncall"
  email_list = ["oncall@example.com"]
  sms_list   = ["+15551234567"]
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
| [uptime_contact.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/contact) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Create | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Contact group name | `string` | n/a | yes |
| <a name="input_email_list"></a> [email\_list](#input\_email\_list) | Email addresses for notifications | `set(string)` | `null` | no |
| <a name="input_sms_list"></a> [sms\_list](#input\_sms\_list) | Phone numbers for SMS notifications | `set(string)` | `null` | no |
| <a name="input_phonecall_list"></a> [phonecall\_list](#input\_phonecall\_list) | Phone numbers for voice call notifications | `set(string)` | `null` | no |
| <a name="input_integrations"></a> [integrations](#input\_integrations) | Integration URLs for third-party notifications | `set(string)` | `null` | no |
| <a name="input_push_notification_profiles"></a> [push\_notification\_profiles](#input\_push\_notification\_profiles) | Push notification profile identifiers | `set(string)` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the contact |
| <a name="output_name"></a> [name](#output\_name) | The contact group name |
| <a name="output_url"></a> [url](#output\_url) | The API URL of the contact |
<!-- END_TF_DOCS -->
