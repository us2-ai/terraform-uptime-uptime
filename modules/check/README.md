# check

Submodule for creating individual Uptime.com checks. Supports 21 check types selected via the `type` variable.

## Usage

```hcl
module "check" {
  source = "path/to/terraform-uptime/modules/check"

  name    = "my-http-check"
  type    = "http"
  address = "https://example.com"

  contact_groups = ["DevOps"]
  interval       = 5
  locations      = ["US-East", "EU-West"]
}
```

<!-- BEGIN_TF_DOCS -->


## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.10.3 |
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
| [uptime_check_api.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/check_api) | resource |
| [uptime_check_blacklist.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/check_blacklist) | resource |
| [uptime_check_cloudstatus.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/check_cloudstatus) | resource |
| [uptime_check_dns.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/check_dns) | resource |
| [uptime_check_heartbeat.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/check_heartbeat) | resource |
| [uptime_check_http.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/check_http) | resource |
| [uptime_check_icmp.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/check_icmp) | resource |
| [uptime_check_imap.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/check_imap) | resource |
| [uptime_check_malware.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/check_malware) | resource |
| [uptime_check_ntp.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/check_ntp) | resource |
| [uptime_check_pagespeed.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/check_pagespeed) | resource |
| [uptime_check_pop.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/check_pop) | resource |
| [uptime_check_rdap.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/check_rdap) | resource |
| [uptime_check_rum2.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/check_rum2) | resource |
| [uptime_check_smtp.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/check_smtp) | resource |
| [uptime_check_ssh.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/check_ssh) | resource |
| [uptime_check_sslcert.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/check_sslcert) | resource |
| [uptime_check_tcp.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/check_tcp) | resource |
| [uptime_check_transaction.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/check_transaction) | resource |
| [uptime_check_udp.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/check_udp) | resource |
| [uptime_check_webhook.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/check_webhook) | resource |
| [uptime_check_whois.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/check_whois) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Create | `bool` | `true` | no |
| <a name="input_type"></a> [type](#input\_type) | The type of check to create | `string` | n/a | yes |
| <a name="input_address"></a> [address](#input\_address) | Address | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name | `string` | n/a | yes |
| <a name="input_script"></a> [script](#input\_script) | API Script (JSON) | `string` | `null` | no |
| <a name="input_contact_groups"></a> [contact\_groups](#input\_contact\_groups) | Contact Groups | `list(string)` | `[]` | no |
| <a name="input_encryption"></a> [encryption](#input\_encryption) | Encryption | `bool` | `false` | no |
| <a name="input_is_paused"></a> [is\_paused](#input\_is\_paused) | Is paused? | `bool` | `false` | no |
| <a name="input_notes"></a> [notes](#input\_notes) | Notes | `string` | `null` | no |
| <a name="input_num_retries"></a> [num\_retries](#input\_num\_retries) | The number of retries | `number` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for which this resource belongs to | `list(string)` | `[]` | no |
| <a name="input_dns_record_type"></a> [dns\_record\_type](#input\_dns\_record\_type) | The DNS record type | `string` | `null` | no |
| <a name="input_dns_server"></a> [dns\_server](#input\_dns\_server) | The DNS server to use | `string` | `null` | no |
| <a name="input_expect_string"></a> [expect\_string](#input\_expect\_string) | Expected string | `string` | `null` | no |
| <a name="input_expect_string_type"></a> [expect\_string\_type](#input\_expect\_string\_type) | Expected string type | `string` | `null` | no |
| <a name="input_headers"></a> [headers](#input\_headers) | HTTP headers | `map(list(string))` | `{}` | no |
| <a name="input_include_in_global_metrics"></a> [include\_in\_global\_metrics](#input\_include\_in\_global\_metrics) | Include in global metrics | `bool` | `false` | no |
| <a name="input_interval"></a> [interval](#input\_interval) | The interval between checks | `number` | `null` | no |
| <a name="input_locations"></a> [locations](#input\_locations) | The list of locations | `list(string)` | `[]` | no |
| <a name="input_sensitivity"></a> [sensitivity](#input\_sensitivity) | Sensitivity | `number` | `null` | no |
| <a name="input_sla"></a> [sla](#input\_sla) | SLA | `any` | `{}` | no |
| <a name="input_threshold"></a> [threshold](#input\_threshold) | The threshold to trigger an alert | `number` | `null` | no |
| <a name="input_config"></a> [config](#input\_config) | SSLcert configuration | `any` | `{}` | no |
| <a name="input_port"></a> [port](#input\_port) | Port | `number` | `null` | no |
| <a name="input_username"></a> [username](#input\_username) | Username | `string` | `null` | no |
| <a name="input_password"></a> [password](#input\_password) | Password | `string` | `null` | no |
| <a name="input_proxy"></a> [proxy](#input\_proxy) | Proxy | `string` | `null` | no |
| <a name="input_send_string"></a> [send\_string](#input\_send\_string) | String to POST | `string` | `null` | no |
| <a name="input_status_code"></a> [status\_code](#input\_status\_code) | Expected HTTP code returned | `string` | `null` | no |
| <a name="input_check_version"></a> [check\_version](#input\_check\_version) | Check version | `number` | `null` | no |
| <a name="input_use_ip_version"></a> [use\_ip\_version](#input\_use\_ip\_version) | Use IP Version | `string` | `null` | no |
| <a name="input_pagespeed_config"></a> [pagespeed\_config](#input\_pagespeed\_config) | Pagespeed check configuration | `any` | `{}` | no |
| <a name="input_pagespeed_headers"></a> [pagespeed\_headers](#input\_pagespeed\_headers) | Pagespeed headers (JSON string) | `string` | `null` | no |
| <a name="input_send_resolved_notifications"></a> [send\_resolved\_notifications](#input\_send\_resolved\_notifications) | Send resolved notifications | `bool` | `null` | no |
| <a name="input_sla_uptime"></a> [sla\_uptime](#input\_sla\_uptime) | SLA uptime (string, for RUM2 checks) | `string` | `null` | no |
| <a name="input_cloudstatus_config"></a> [cloudstatus\_config](#input\_cloudstatus\_config) | Cloudstatus check configuration. Supported keys:<br/>group (number), monitoring\_type (string: ALL or SPECIFIC),<br/>notify\_only\_on\_down (bool), service\_name (string, deprecated/legacy),<br/>service\_titles (list(string)), services (list(number)). | `any` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the check, or null when the check is not created |
| <a name="output_name"></a> [name](#output\_name) | The name of the check, or null when the check is not created |
| <a name="output_heartbeat_url"></a> [heartbeat\_url](#output\_heartbeat\_url) | The heartbeat URL (only for heartbeat checks) |
| <a name="output_webhook_url"></a> [webhook\_url](#output\_webhook\_url) | The webhook URL (only for webhook checks) |
<!-- END_TF_DOCS -->
