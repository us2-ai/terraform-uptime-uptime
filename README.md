# terraform-uptime

Terraform module to manage [Uptime.com](https://uptime.com) monitoring resources including checks, tags, check groups, integrations, escalations, maintenance schedules, contacts, status pages, credentials, dashboards, SLA reports, and more.

## Usage

```hcl
module "uptime" {
  source  = "path/to/terraform-uptime"

  name           = "my-service"
  address        = "example.com"
  contact_groups = ["DevOps"]

  checks = {
    homepage = {
      type       = "http"
      encryption = true
    }
    dns = {
      type            = "dns"
      dns_record_type = "A"
      expect_string   = "93.184.216.34"
    }
    heartbeat = {
      type = "heartbeat"
    }
  }

  integrations = {
    slack-alerts = {
      type = "slack"
      settings = {
        webhook_url = "https://hooks.slack.com/services/..."
        channel     = "#alerts"
      }
    }
  }
}
```

## Features

### Supported Check Types (22)

| Check Type | Description |
|---|---|
| `api` | API multi-step checks with JSON scripts |
| `blacklist` | Domain blacklist monitoring |
| `cloudstatus` | Public cloud provider status feed monitoring |
| `dns` | DNS record verification |
| `heartbeat` | Heartbeat/cron job monitoring |
| `http` | HTTP/HTTPS endpoint monitoring |
| `icmp` | Ping/ICMP monitoring |
| `imap` | IMAP mail server checks |
| `malware` | Malware scanning |
| `ntp` | NTP time server checks |
| `pagespeed` | Page speed performance monitoring |
| `pop` | POP mail server checks |
| `rdap` | RDAP domain/IP registration checks |
| `rum2` | Real user monitoring |
| `smtp` | SMTP mail server checks |
| `sslcert` | SSL certificate expiry monitoring |
| `ssh` | SSH connectivity checks |
| `tcp` | TCP port connectivity |
| `transaction` | Browser transaction checks |
| `udp` | UDP connectivity checks |
| `webhook` | Incoming webhook checks |
| `whois` | WHOIS domain expiry monitoring |

### Supported Integrations (17)

cachet, datadog, geckoboard, jira_servicedesk, klipfolio, microsoft_teams, opsgenie, pagerduty, pushbullet, pushover, slack, status, statuspage, victorops, wavefront, webhook, zapier

### Additional Resources

- **Tags** — Create and manage tags with optional colors
- **Check Groups** — Group checks with shared SLA and alerting configuration
- **Escalations** — Define escalation policies attached to checks
- **Maintenance Schedules** — Account-level maintenance windows (one-off or RRULE recurring) targeting checks and tags
- **Maintenance Notifications** — Notify contact groups before/after a maintenance schedule event
- **Contacts** — Manage notification contacts and contact groups (email, SMS, phone, push, integrations)
- **Status Pages** — Public status pages with components, incidents, metrics, subscribers, domain allow/block lists, and users
- **Credentials** — API credentials for secure check configuration
- **Dashboards** — Custom monitoring dashboards with alerts, metrics, and service views
- **SLA Reports** — Service level agreement tracking and reporting
- **Scheduled Reports** — Automated SLA report delivery on a recurring schedule
- **Service Variables** — Inject credential values into check configurations securely
- **Subaccounts** — Manage subaccounts within your Uptime.com account
- **Users** — Manage account team members with access levels and 2FA
- **Private Locations** — Resolve the account's private monitoring locations and target checks at them

## Strict attribute validation

Collection variables are typed `any` so that per-type check configuration can pass through
untouched. As of v2.0.0 each collection also validates its attribute *names*, so a misspelled or
unsupported attribute fails instead of being silently discarded:

```
var.checks has unsupported attribute(s): homepage.use_private_location.
Valid attributes: address, check_version, cloudstatus_config, config, ...
```

The error lists the collection's valid attributes, so the correct spelling is in the message rather
than something to go look up.

Attributes nested inside a collection (statuspage `components`, check `config`, integration
`settings`) are validated at `terraform plan` rather than `terraform validate`, because Terraform
does not expand module `for_each` during validate. Blocks passed straight through to the provider —
`sla`, credential `secret`, dashboard `alerts`/`metrics`/`services`/`selected`, group `config` —
are type-checked by the provider itself.

## Upgrading

Major versions of this module track major versions of the `uptime-com/uptime` provider, and each
one has its own guide with the steps in order and the `terraform state` addresses spelled out:

- [UPGRADE-3.0.md](./UPGRADE-3.0.md): provider 3.0.0 removed `uptime_check_maintenance`, so the
  `maintenances` collection is gone. Migrate windows to `maintenance_schedules` before upgrading.

## Submodules

| Module | Description |
|---|---|
| [check](./modules/check/) | Creates individual uptime checks of any supported type |
| [tag](./modules/tag/) | Creates uptime tags |
| [group](./modules/group/) | Creates check groups |
| [integration](./modules/integration/) | Creates alert integrations |
| [escalation](./modules/escalation/) | Creates check escalation policies |
| [maintenance_schedule](./modules/maintenance_schedule/) | Creates account-level maintenance schedules |
| [maintenance_notification](./modules/maintenance_notification/) | Creates maintenance schedule notifications |
| [contact](./modules/contact/) | Creates notification contacts and contact groups |
| [statuspage](./modules/statuspage/) | Creates status pages with components, incidents, metrics, subscribers, and users |
| [credential](./modules/credential/) | Creates API credentials |
| [dashboard](./modules/dashboard/) | Creates custom monitoring dashboards |
| [sla_report](./modules/sla_report/) | Creates SLA reports |
| [scheduled_report](./modules/scheduled_report/) | Creates scheduled report deliveries |
| [service_variable](./modules/service_variable/) | Creates service variables for credential injection |
| [subaccount](./modules/subaccount/) | Creates subaccounts |
| [user](./modules/user/) | Creates account users |

## Examples

- [Simple](./examples/simple/) — Single HTTP check with tag and group
- [Complete](./examples/complete/) — Multiple check types, integrations, escalations, and maintenance schedules
- [Integrations](./examples/integrations/) — Various integration configurations
- [Maintenance](./examples/maintenance/) — Cloud status check, maintenance schedules, and notifications
- [Private Locations](./examples/private-locations/) — Targeting checks at the account's private monitoring locations

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

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_tag"></a> [tag](#module\_tag) | ./modules/tag | n/a |
| <a name="module_group"></a> [group](#module\_group) | ./modules/group | n/a |
| <a name="module_check"></a> [check](#module\_check) | ./modules/check | n/a |
| <a name="module_integration"></a> [integration](#module\_integration) | ./modules/integration | n/a |
| <a name="module_escalation"></a> [escalation](#module\_escalation) | ./modules/escalation | n/a |
| <a name="module_maintenance_schedule"></a> [maintenance\_schedule](#module\_maintenance\_schedule) | ./modules/maintenance_schedule | n/a |
| <a name="module_maintenance_notification"></a> [maintenance\_notification](#module\_maintenance\_notification) | ./modules/maintenance_notification | n/a |
| <a name="module_contact"></a> [contact](#module\_contact) | ./modules/contact | n/a |
| <a name="module_statuspage"></a> [statuspage](#module\_statuspage) | ./modules/statuspage | n/a |
| <a name="module_credential"></a> [credential](#module\_credential) | ./modules/credential | n/a |
| <a name="module_dashboard"></a> [dashboard](#module\_dashboard) | ./modules/dashboard | n/a |
| <a name="module_sla_report"></a> [sla\_report](#module\_sla\_report) | ./modules/sla_report | n/a |
| <a name="module_scheduled_report"></a> [scheduled\_report](#module\_scheduled\_report) | ./modules/scheduled_report | n/a |
| <a name="module_service_variable"></a> [service\_variable](#module\_service\_variable) | ./modules/service_variable | n/a |
| <a name="module_subaccount"></a> [subaccount](#module\_subaccount) | ./modules/subaccount | n/a |
| <a name="module_user"></a> [user](#module\_user) | ./modules/user | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [uptime_private_locations.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/data-sources/private_locations) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Create resources in module | `bool` | `true` | no |
| <a name="input_create_group"></a> [create\_group](#input\_create\_group) | Create primary group for all checks | `bool` | `true` | no |
| <a name="input_create_tag"></a> [create\_tag](#input\_create\_tag) | Create primary tag for all checks | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Global name to be used on all the resources as identifier | `string` | n/a | yes |
| <a name="input_color_hex"></a> [color\_hex](#input\_color\_hex) | The color of the primary tag. | `string` | `null` | no |
| <a name="input_config"></a> [config](#input\_config) | The configuration of the primary check group. This is not a default for a check's `config` block, which is a different, non-overlapping schema. | `any` | `{}` | no |
| <a name="input_address"></a> [address](#input\_address) | FQDN of the system. | `string` | `null` | no |
| <a name="input_port"></a> [port](#input\_port) | Port | `number` | `null` | no |
| <a name="input_script"></a> [script](#input\_script) | API Script (JSON) | `string` | `null` | no |
| <a name="input_contact_groups"></a> [contact\_groups](#input\_contact\_groups) | Contact Groups | `list(string)` | `[]` | no |
| <a name="input_encryption"></a> [encryption](#input\_encryption) | Encryption | `bool` | `false` | no |
| <a name="input_dns_record_type"></a> [dns\_record\_type](#input\_dns\_record\_type) | The DNS record type | `string` | `null` | no |
| <a name="input_dns_server"></a> [dns\_server](#input\_dns\_server) | The DNS server to use | `string` | `null` | no |
| <a name="input_expect_string"></a> [expect\_string](#input\_expect\_string) | Expected string | `string` | `null` | no |
| <a name="input_expect_string_type"></a> [expect\_string\_type](#input\_expect\_string\_type) | Expected string type | `string` | `null` | no |
| <a name="input_headers"></a> [headers](#input\_headers) | HTTP headers | `map(list(string))` | `{}` | no |
| <a name="input_include_in_global_metrics"></a> [include\_in\_global\_metrics](#input\_include\_in\_global\_metrics) | Global include in global metrics | `bool` | `null` | no |
| <a name="input_is_paused"></a> [is\_paused](#input\_is\_paused) | Global pause | `bool` | `null` | no |
| <a name="input_notes"></a> [notes](#input\_notes) | Global Notes | `string` | `null` | no |
| <a name="input_sla"></a> [sla](#input\_sla) | Global SLA settings | `any` | `{}` | no |
| <a name="input_groups"></a> [groups](#input\_groups) | Groups | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags | `any` | `{}` | no |
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | Additional tags to be added | `list(string)` | `[]` | no |
| <a name="input_checks"></a> [checks](#input\_checks) | Checks | `any` | `{}` | no |
| <a name="input_interval"></a> [interval](#input\_interval) | Check frequency in minutes | `number` | `null` | no |
| <a name="input_sensitivity"></a> [sensitivity](#input\_sensitivity) | Number of locations that must be down before alerting | `number` | `null` | no |
| <a name="input_num_retries"></a> [num\_retries](#input\_num\_retries) | Number of retries before marking check as down | `number` | `null` | no |
| <a name="input_threshold"></a> [threshold](#input\_threshold) | Threshold for alerts | `number` | `null` | no |
| <a name="input_locations"></a> [locations](#input\_locations) | Locations | `list(string)` | `[]` | no |
| <a name="input_lookup_private_locations"></a> [lookup\_private\_locations](#input\_lookup\_private\_locations) | Query the account's private monitoring locations and expose them via the `private_locations` and `private_check_locations` outputs. The lookup is performed automatically for any check that sets `use_private_locations`, so this only needs to be set when you want the outputs on their own. | `bool` | `false` | no |
| <a name="input_username"></a> [username](#input\_username) | Username | `string` | `null` | no |
| <a name="input_password"></a> [password](#input\_password) | Password | `string` | `null` | no |
| <a name="input_proxy"></a> [proxy](#input\_proxy) | Proxy | `string` | `null` | no |
| <a name="input_send_string"></a> [send\_string](#input\_send\_string) | String to POST | `string` | `null` | no |
| <a name="input_status_code"></a> [status\_code](#input\_status\_code) | Expected HTTP code returned | `string` | `null` | no |
| <a name="input_check_version"></a> [check\_version](#input\_check\_version) | Check version | `number` | `null` | no |
| <a name="input_use_ip_version"></a> [use\_ip\_version](#input\_use\_ip\_version) | Use IP Version | `string` | `null` | no |
| <a name="input_send_resolved_notifications"></a> [send\_resolved\_notifications](#input\_send\_resolved\_notifications) | Send resolved notifications | `bool` | `null` | no |
| <a name="input_sla_uptime"></a> [sla\_uptime](#input\_sla\_uptime) | SLA uptime (string, for RUM2 checks) | `string` | `null` | no |
| <a name="input_integrations"></a> [integrations](#input\_integrations) | Integrations | `any` | `{}` | no |
| <a name="input_escalations"></a> [escalations](#input\_escalations) | Escalations | `any` | `{}` | no |
| <a name="input_maintenances"></a> [maintenances](#input\_maintenances) | REMOVED in v3.0.0. Provider 3.0.0 dropped `uptime_check_maintenance`, so per-check maintenance windows can no longer be managed here. Retained only so that an existing configuration fails with a pointer to the migration steps instead of an unexplained "Unsupported argument". Use `maintenance_schedules` and `maintenance_notifications` instead; see UPGRADE-3.0.md. | `any` | `{}` | no |
| <a name="input_maintenance_schedules"></a> [maintenance\_schedules](#input\_maintenance\_schedules) | Maintenance Schedules | `any` | `{}` | no |
| <a name="input_maintenance_notifications"></a> [maintenance\_notifications](#input\_maintenance\_notifications) | Maintenance Notifications | `any` | `{}` | no |
| <a name="input_contacts"></a> [contacts](#input\_contacts) | Contacts | `any` | `{}` | no |
| <a name="input_statuspages"></a> [statuspages](#input\_statuspages) | Status Pages | `any` | `{}` | no |
| <a name="input_credentials"></a> [credentials](#input\_credentials) | Credentials | `any` | `{}` | no |
| <a name="input_dashboards"></a> [dashboards](#input\_dashboards) | Dashboards | `any` | `{}` | no |
| <a name="input_sla_reports"></a> [sla\_reports](#input\_sla\_reports) | SLA Reports | `any` | `{}` | no |
| <a name="input_scheduled_reports"></a> [scheduled\_reports](#input\_scheduled\_reports) | Scheduled Reports | `any` | `{}` | no |
| <a name="input_service_variables"></a> [service\_variables](#input\_service\_variables) | Service Variables | `any` | `{}` | no |
| <a name="input_subaccounts"></a> [subaccounts](#input\_subaccounts) | Subaccounts | `any` | `{}` | no |
| <a name="input_users"></a> [users](#input\_users) | Users | `any` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_tag"></a> [tag](#output\_tag) | Map of tag module outputs keyed by tag name |
| <a name="output_group"></a> [group](#output\_group) | Map of check group module outputs keyed by group name |
| <a name="output_check"></a> [check](#output\_check) | Map of check module outputs keyed by check name |
| <a name="output_integration"></a> [integration](#output\_integration) | Map of integration module outputs keyed by integration name |
| <a name="output_escalation"></a> [escalation](#output\_escalation) | Map of escalation module outputs keyed by escalation name |
| <a name="output_maintenance_schedule"></a> [maintenance\_schedule](#output\_maintenance\_schedule) | Map of maintenance schedule module outputs keyed by schedule name |
| <a name="output_maintenance_notification"></a> [maintenance\_notification](#output\_maintenance\_notification) | Map of maintenance notification module outputs keyed by notification name |
| <a name="output_contact"></a> [contact](#output\_contact) | Map of contact module outputs keyed by contact name |
| <a name="output_statuspage"></a> [statuspage](#output\_statuspage) | Map of statuspage module outputs keyed by statuspage name |
| <a name="output_credential"></a> [credential](#output\_credential) | Map of credential module outputs keyed by credential name |
| <a name="output_dashboard"></a> [dashboard](#output\_dashboard) | Map of dashboard module outputs keyed by dashboard name |
| <a name="output_sla_report"></a> [sla\_report](#output\_sla\_report) | Map of SLA report module outputs keyed by report name |
| <a name="output_scheduled_report"></a> [scheduled\_report](#output\_scheduled\_report) | Map of scheduled report module outputs keyed by report name |
| <a name="output_service_variable"></a> [service\_variable](#output\_service\_variable) | Map of service variable module outputs keyed by variable name |
| <a name="output_subaccount"></a> [subaccount](#output\_subaccount) | Map of subaccount module outputs keyed by subaccount name |
| <a name="output_user"></a> [user](#output\_user) | Map of user module outputs keyed by user name |
| <a name="output_private_locations"></a> [private\_locations](#output\_private\_locations) | The account's private monitoring locations, including `country`, `location`, `name`, and address attributes. Empty unless `lookup_private_locations` is set or a check uses `use_private_locations`. |
| <a name="output_private_check_locations"></a> [private\_check\_locations](#output\_private\_check\_locations) | The `location` values of the account's private monitoring locations, in the form a check's `locations` list expects |
<!-- END_TF_DOCS -->

## License

Apache 2.0 — see [LICENSE](./LICENSE) for details.
