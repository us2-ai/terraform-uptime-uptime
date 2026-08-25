# escalation

Submodule for creating Uptime.com check escalation policies. Escalations define a series of alert steps that trigger after specified wait times.

## Usage

```hcl
module "escalation" {
  source = "path/to/terraform-uptime/modules/escalation"

  check_id = 12345

  escalations = [
    {
      contact_groups = ["DevOps"]
      num_repeats    = 3
      wait_time      = 5
    },
    {
      contact_groups = ["Management"]
      num_repeats    = 1
      wait_time      = 15
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
| [uptime_check_escalations.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/check_escalations) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Create | `bool` | `true` | no |
| <a name="input_check_id"></a> [check\_id](#input\_check\_id) | The ID of the check to attach escalations to | `number` | n/a | yes |
| <a name="input_escalations"></a> [escalations](#input\_escalations) | List of escalation rules | <pre>list(object({<br/>    contact_groups = list(string)<br/>    num_repeats    = number<br/>    wait_time      = number<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_check_id"></a> [check\_id](#output\_check\_id) | The check ID the escalations are attached to |
<!-- END_TF_DOCS -->
