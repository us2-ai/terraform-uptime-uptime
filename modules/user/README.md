# user

Submodule for creating Uptime.com account users.

## Usage

```hcl
module "user" {
  source = "path/to/terraform-uptime/modules/user"

  email      = "someone@example.com"
  password   = var.initial_password
  first_name = "Some"
  last_name  = "One"
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
| [uptime_user.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/user) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Create | `bool` | `true` | no |
| <a name="input_email"></a> [email](#input\_email) | Email address | `string` | n/a | yes |
| <a name="input_password"></a> [password](#input\_password) | Password | `string` | n/a | yes |
| <a name="input_first_name"></a> [first\_name](#input\_first\_name) | First name | `string` | `null` | no |
| <a name="input_last_name"></a> [last\_name](#input\_last\_name) | Last name | `string` | `null` | no |
| <a name="input_access_level"></a> [access\_level](#input\_access\_level) | Access level | `string` | `null` | no |
| <a name="input_is_api_enabled"></a> [is\_api\_enabled](#input\_is\_api\_enabled) | Enable API access | `bool` | `null` | no |
| <a name="input_notify_paid_invoices"></a> [notify\_paid\_invoices](#input\_notify\_paid\_invoices) | Notify on paid invoices | `bool` | `null` | no |
| <a name="input_require_two_factor"></a> [require\_two\_factor](#input\_require\_two\_factor) | Require two-factor authentication | `string` | `null` | no |
| <a name="input_assigned_subaccounts"></a> [assigned\_subaccounts](#input\_assigned\_subaccounts) | Assigned subaccounts | `set(string)` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the user |
| <a name="output_email"></a> [email](#output\_email) | The user email |
| <a name="output_url"></a> [url](#output\_url) | The API URL of the user |
<!-- END_TF_DOCS -->
