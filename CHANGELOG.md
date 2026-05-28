# Changelog

All notable changes to this project will be documented in this file.

## [1.3.0-us2.0] - 2026-05-28

### Special build requirement

Bumps the provider pin to `uptime-com/uptime` version `2.26.0-us2.1`,
which embeds an expanded `StatusPage` struct from
[us2-ai/uptime-client-go](https://github.com/us2-ai/uptime-client-go)
tag `v2.7.0-us2.2`. Same install path as `1.2.0-us2.0`: use the
composite action documented in
[docs/ci-integration.md](https://github.com/us2-ai/terraform-provider-uptime/blob/main/docs/ci-integration.md)
in the provider repository.

### Features

- Expose Inspire-theme statuspage customization in the `statuspage`
  submodule: `custom_header_html_inspire`, `custom_footer_html_inspire`,
  `custom_css_inspire`.
- Expose the Inspire-related layout controls: `layout_preset`,
  `show_component_bars`, `show_component_group_descriptions`.
- Expose previously-unmapped general-purpose statuspage settings:
  `allow_notifications`, `default_status_date_range`,
  `hide_empty_tabs_status`, `logo_url`, `email_logo_url`, `favicon_url`.
- Surface read-only response URLs and metadata as module outputs:
  `public_url`, `private_url`, `cname_url`, `incidents_url`,
  `components_url`, `metrics_url`, `history_url`, `current_status_url`,
  `description_html`, `page_type_display`.

### Notes

- Variables default to `null` so existing configurations remain a no-op
  diff against this release.
- The Uptime.com API exposes no documented path to downgrade a status
  page off the Inspire theme; pages already migrated to Inspire stay
  on it. The new `*_inspire` fields are how to style them.

## [1.2.0-us2.0] - 2026-05-28

### Special build requirement

This release pins the provider to `uptime-com/uptime` version
`2.26.0-us2.0`, which is published only by the us2-ai fork at
[us2-ai/terraform-provider-uptime](https://github.com/us2-ai/terraform-provider-uptime).
The fork depends on a matching build of [us2-ai/uptime-client-go](https://github.com/us2-ai/uptime-client-go)
(tag `v2.7.0-us2.1`) that surfaces `is_private` and `country` on probe
servers. The public Terraform Registry does not serve this build; install
it via the composite action documented in
[docs/ci-integration.md](https://github.com/us2-ai/terraform-provider-uptime/blob/main/docs/ci-integration.md)
in the provider repository.

### Features

- Reference private monitoring locations through the `uptime_private_locations`
  data source exposed by the forked provider. Returns the subset of probe
  servers flagged `is_private` by the API, usable in any `locations`
  attribute on a check.
- Add `examples/private-locations` showing the data source feeding a
  private-only HTTP check.

### Notes

- Submodules continue to inherit the root-level provider version
  constraint; no per-submodule changes were required.
- Inspire-theme statuspage fields are not yet supported in this tag and
  will be added in a later us2-prefixed release once their API schema is
  finalized.

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
