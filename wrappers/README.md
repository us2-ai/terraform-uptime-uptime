# Wrapper Module

This module implements a single wrapper pattern that allows managing several copies of the `terraform-uptime` module in places where using the native Terraform `for_each` feature is not feasible (e.g., with [Terragrunt](https://terragrunt.gruntwork.io/)).

## Usage with Terragrunt

```hcl
# terragrunt.hcl
terraform {
  source = "path/to/terraform-uptime//wrappers"
}

inputs = {
  defaults = {
    contact_groups = ["DevOps"]
    encryption     = true
    interval       = 5
  }

  items = {
    service-a = {
      name    = "service-a"
      address = "service-a.example.com"
      checks = {
        http = { type = "http" }
      }
    }
    service-b = {
      name    = "service-b"
      address = "service-b.example.com"
      checks = {
        http = { type = "http" }
        dns  = { type = "dns", expect_string = "10.0.0.1" }
      }
    }
  }
}
```

## Variable Precedence

Values are resolved in this order (highest priority first):

1. Per-item values in `var.items`
2. Shared defaults in `var.defaults`
3. Module-level fallback defaults

<!-- BEGIN_TF_DOCS -->


## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.10.3 |
| <a name="requirement_uptime"></a> [uptime](#requirement\_uptime) | >= 3.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_wrapper"></a> [wrapper](#module\_wrapper) | ../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_defaults"></a> [defaults](#input\_defaults) | Map of default values which will be used for each item. | `any` | `{}` | no |
| <a name="input_items"></a> [items](#input\_items) | Maps of items to create a wrapper from. Values are passed through to the module. | `any` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_wrapper"></a> [wrapper](#output\_wrapper) | Map of outputs of a wrapper. |
<!-- END_TF_DOCS -->
