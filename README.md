# terraform-uptime

Terraform module to manage [Uptime.com](https://uptime.com) monitoring resources including checks, tags, check groups, integrations, escalations, maintenance windows, contacts, status pages, credentials, dashboards, SLA reports, and more.

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
- **Maintenance** — Schedule maintenance windows for checks
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

## Submodules

| Module | Description |
|---|---|
| [check](./modules/check/) | Creates individual uptime checks of any supported type |
| [tag](./modules/tag/) | Creates uptime tags |
| [group](./modules/group/) | Creates check groups |
| [integration](./modules/integration/) | Creates alert integrations |
| [escalation](./modules/escalation/) | Creates check escalation policies |
| [maintenance](./modules/maintenance/) | Creates check maintenance windows |
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
- [Complete](./examples/complete/) — Multiple check types, integrations, escalations, and maintenance
- [Integrations](./examples/integrations/) — Various integration configurations
- [Maintenance](./examples/maintenance/) — Cloud status check, maintenance schedules, and notifications

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.6 |
| uptime | >= 2.28 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| check | ./modules/check | n/a |
| contact | ./modules/contact | n/a |
| credential | ./modules/credential | n/a |
| dashboard | ./modules/dashboard | n/a |
| escalation | ./modules/escalation | n/a |
| group | ./modules/group | n/a |
| integration | ./modules/integration | n/a |
| maintenance | ./modules/maintenance | n/a |
| maintenance\_notification | ./modules/maintenance\_notification | n/a |
| maintenance\_schedule | ./modules/maintenance\_schedule | n/a |
| scheduled\_report | ./modules/scheduled\_report | n/a |
| service\_variable | ./modules/service\_variable | n/a |
| sla\_report | ./modules/sla\_report | n/a |
| statuspage | ./modules/statuspage | n/a |
| subaccount | ./modules/subaccount | n/a |
| tag | ./modules/tag | n/a |
| user | ./modules/user | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Create resources in module | `bool` | `true` | no |
| create\_group | Create primary group for all checks | `bool` | `true` | no |
| create\_tag | Create primary tag for all checks | `bool` | `true` | no |
| name | Global name to be used on all the resources as identifier | `string` | n/a | yes |
| color\_hex | The color of the primary tag | `string` | `null` | no |
| config | The configuration of primary group | `any` | `{}` | no |
| address | FQDN of the system | `string` | `null` | no |
| port | Port | `number` | `null` | no |
| script | API Script (JSON) | `string` | `null` | no |
| contact\_groups | Contact Groups | `list(string)` | `[]` | no |
| encryption | Encryption | `bool` | `false` | no |
| dns\_record\_type | The DNS record type | `string` | `null` | no |
| dns\_server | The DNS server to use | `string` | `null` | no |
| expect\_string | Expected string | `string` | `null` | no |
| expect\_string\_type | Expected string type | `string` | `null` | no |
| headers | HTTP headers | `map(list(string))` | `{}` | no |
| include\_in\_global\_metrics | Global include in global metrics | `bool` | `null` | no |
| is\_paused | Global pause | `bool` | `null` | no |
| notes | Global Notes | `string` | `null` | no |
| sla | Global SLA settings | `any` | `{}` | no |
| groups | Groups | `any` | `{}` | no |
| tags | Tags | `any` | `{}` | no |
| additional\_tags | Additional tags to be added | `list(string)` | `[]` | no |
| checks | Checks | `any` | `{}` | no |
| interval | Check frequency in minutes | `number` | `null` | no |
| sensitivity | Number of locations that must be down before alerting | `number` | `null` | no |
| num\_retries | Number of retries before marking check as down | `number` | `null` | no |
| threshold | Threshold for alerts | `number` | `null` | no |
| locations | Locations | `list(string)` | `[]` | no |
| username | Username | `string` | `null` | no |
| password | Password | `string` | `null` | no |
| proxy | Proxy | `string` | `null` | no |
| send\_string | String to POST | `string` | `null` | no |
| status\_code | Expected HTTP code returned | `string` | `null` | no |
| check\_version | Check version | `number` | `null` | no |
| use\_ip\_version | Use IP Version | `string` | `null` | no |
| send\_resolved\_notifications | Send resolved notifications | `bool` | `null` | no |
| sla\_uptime | SLA uptime (string, for RUM2 checks) | `string` | `null` | no |
| integrations | Integrations | `any` | `{}` | no |
| escalations | Escalations | `any` | `{}` | no |
| maintenances | Maintenances | `any` | `{}` | no |
| maintenance\_schedules | Maintenance Schedules | `any` | `{}` | no |
| maintenance\_notifications | Maintenance Notifications | `any` | `{}` | no |
| contacts | Contacts | `any` | `{}` | no |
| statuspages | Status Pages | `any` | `{}` | no |
| credentials | Credentials | `any` | `{}` | no |
| dashboards | Dashboards | `any` | `{}` | no |
| sla\_reports | SLA Reports | `any` | `{}` | no |
| scheduled\_reports | Scheduled Reports | `any` | `{}` | no |
| service\_variables | Service Variables | `any` | `{}` | no |
| subaccounts | Subaccounts | `any` | `{}` | no |
| users | Users | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| tag | Tag module outputs |
| group | Group module outputs |
| check | Check module outputs |
| integration | Integration module outputs |
| escalation | Escalation module outputs |
| maintenance | Maintenance module outputs |
| maintenance\_schedule | Maintenance schedule module outputs |
| maintenance\_notification | Maintenance notification module outputs |
| contact | Contact module outputs |
| statuspage | Status page module outputs |
| credential | Credential module outputs |
| dashboard | Dashboard module outputs |
| sla\_report | SLA report module outputs |
| scheduled\_report | Scheduled report module outputs |
| service\_variable | Service variable module outputs |
| subaccount | Subaccount module outputs |
| user | User module outputs |
<!-- END_TF_DOCS -->

## License

Apache 2.0 — see [LICENSE](./LICENSE) for details.
