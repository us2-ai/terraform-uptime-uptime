# Changelog

All notable changes to this project will be documented in this file.

## [1.2.0] - 2026-06-22

### Features

- Add `cloudstatus` check type for monitoring public cloud provider status feeds (provider v2.25.0+)
- Add maintenance_schedule module for account-level maintenance windows (one-off and RRULE recurring) (provider v2.28.0+)
- Add maintenance_notification module to notify contact groups before/after a maintenance schedule event (provider v2.28.0+)

### Bug Fixes

- Default tag `color_hex` to `#cccccc` when unset; the provider made this attribute required in v2.20.0

### Notes

- Raise minimum provider version from `>= 2.10` to `>= 2.28` to cover the new resources

## [1.1.1] - 2026-05-21

### Bug Fixes

- Remove the `local.statuspage_id != null` guard from the statuspage child `for_each` so child resources are created correctly

## [1.1.0] - 2026-03-28

### Features

- Add contact module for managing notification contacts and contact groups
- Add statuspage module with support for components, incidents, metrics, subscribers, domain allow/block lists, and users
- Add credential module for managing API credentials
- Add dashboard module for custom monitoring dashboards
- Add SLA report module for service level agreement tracking
- Add scheduled report module for automated report delivery
- Add service variable module for secure credential injection into checks
- Add subaccount module for subaccount management
- Add user module for account team member management

## [1.0.0] - 2026-03-26

### Features

- Add 14 new check types: heartbeat, icmp, imap, ntp, pagespeed, pop, rdap, rum2, smtp, transaction, udp, webhook, whois
- Add integration module supporting 17 integration types: cachet, datadog, geckoboard, jira_servicedesk, klipfolio, microsoft_teams, opsgenie, pagerduty, pushbullet, pushover, slack, status, statuspage, victorops, wavefront, webhook, zapier
- Add escalation module for check escalation policies
- Add maintenance module for check maintenance windows
- Add check module outputs (id, name, heartbeat_url, webhook_url)
- Add root-level outputs for check, integration, escalation, and maintenance modules
- Add global default variables for interval, sensitivity, and num_retries
- Add wrapper module for Terragrunt compatibility
- Add examples: simple, complete, integrations

### Bug Fixes

- Fix missing `api` in check type validation regex
- Add missing `locations` attribute to blacklist, sslcert, and malware checks
- Add missing `use_ip_version` attribute to ssh checks
- Add missing `ignore_authority_warnings`, `ignore_sct`, `resolve` attributes to sslcert config

## [0.0.1] - 2024-01-01

### Features

- Initial release
- Support for 8 check types: blacklist, dns, sslcert, malware, http, ssh, tcp, api
- Tag module with color support
- Check group module with SLA configuration
