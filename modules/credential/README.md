# credential

Submodule for creating Uptime.com credentials, the stored secrets that service variables inject into check configuration. The `secret` block passes straight through to the provider, which type-checks it.

## Usage

```hcl
module "credential" {
  source = "path/to/terraform-uptime/modules/credential"

  display_name    = "api-token"
  credential_type = "TOKEN"

  secret = {
    secret = var.api_token
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
| [uptime_credential.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/credential) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Create | `bool` | `true` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | Display name | `string` | n/a | yes |
| <a name="input_credential_type"></a> [credential\_type](#input\_credential\_type) | Credential type | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Description | `string` | `null` | no |
| <a name="input_username"></a> [username](#input\_username) | Username | `string` | `null` | no |
| <a name="input_secret"></a> [secret](#input\_secret) | Secret configuration containing sensitive values | `any` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the credential |
| <a name="output_display_name"></a> [display\_name](#output\_display\_name) | The credential display name |
| <a name="output_hint"></a> [hint](#output\_hint) | The credential hint |
<!-- END_TF_DOCS -->
