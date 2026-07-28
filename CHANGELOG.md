# Changelog

All notable changes to this project will be documented in this file.

## [2.0.0] - 2026-07-28

### Breaking Changes

- **Minimum Terraform/OpenTofu raised from 1.6 to 1.9.** The attribute allowlists below are stored
  once in a `local.allowed_attributes` map and referenced from each variable's `validation` block.
  Referencing a local from a validation block requires 1.9; 1.8 and earlier reject it with
  `Invalid reference in variable validation`. Verified against Terraform 1.9.0/1.13.3 and
  OpenTofu 1.9.0/1.12.5 — both engines behave identically and share the same 1.9 floor.

- **Unknown attributes are now rejected instead of silently ignored.** Every collection variable in
  this module is typed `any` and read through `try(each.value.<attr>, ...)`, which meant a misspelled
  or unsupported attribute was discarded with no error, no warning, and no diff — `use_private_location`
  instead of `use_private_locations`, or a stale attribute from an older module version, simply did
  nothing. Each collection now validates its attribute names and fails with the offending entries
  named:

  ```
  var.checks has unsupported attribute(s): typo.sorting_wieght, typo.use_private_location.
  Valid attributes: address, check_version, cloudstatus_config, config, ...
  ```

  The message lists the collection's valid attributes, so a misspelling can be corrected from the
  error itself.

  Covered: the 17 root collections (`checks`, `statuspages`, `integrations`, `contacts`, `tags`,
  `groups`, `escalations`, `maintenances`, `maintenance_schedules`, `maintenance_notifications`,
  `credentials`, `dashboards`, `sla_reports`, `scheduled_reports`, `service_variables`,
  `subaccounts`, `users`), the 7 nested statuspage collections (`components`, `incidents`, `metrics`,
  `subscribers`, `subscription_domain_allows`, `subscription_domain_blocks`, `users`), the check
  `config`, `pagespeed_config`, and `cloudstatus_config` blocks, integration `settings`, and the
  wrapper module's `items` and `defaults`.

  **Migration:** run `terraform plan`. Anything it now rejects was already being ignored, so removing
  or correcting the reported attributes produces no infrastructure change. A corrected typo may
  produce a real diff — that is the setting taking effect for the first time.

  Notes on coverage: attributes nested inside collections validate at plan time rather than
  `terraform validate` time, because Terraform does not expand module `for_each` during validate.
  Integration `settings` is checked against the union of attributes across all 17 integration types
  rather than per-type, since a validation rule cannot reference the sibling `type` variable.
  Free-form blocks that are passed straight through to the provider (`sla`, credential `secret`,
  dashboard `alerts`/`metrics`/`services`/`selected`, maintenance `schedule`, group `config`) are
  unaffected — the provider already type-checks those and rejects unknown attributes itself.

- The statuspage `allow_subscriptions` variable is no longer accepted. The Uptime.com API derives it
  from the per-channel `allow_subscriptions_*` flags and the provider stopped sending it on writes in
  v2.25.0, so any value set here was silently discarded. Setting it now fails at plan time with a
  message naming the per-channel flags to use instead.

  **Migration:** remove `allow_subscriptions` and set `allow_subscriptions_email`,
  `allow_subscriptions_rss`, `allow_subscriptions_slack`, `allow_subscriptions_sms`, or
  `allow_subscriptions_webhook`. Since the attribute was already inert, this changes no
  infrastructure — only whether a dead setting is reported.

### Bug Fixes

- `create_check = false` and `create_integration = false` no longer break `terraform plan`. The
  `id` and `name` outputs were built with `coalesce()` over every possible check/integration
  resource, and `coalesce()` fails when every argument is null — which is exactly the case for a
  deliberately disabled resource. Both now use `one()`, which yields `null` instead. The outputs
  return `null` rather than erroring when the resource is not created.
- The root `config` variable no longer leaks into checks. It is documented as the primary check
  group's configuration, but was also passed as the default for each check's `config` block. The two
  schemas do not overlap at all — group config is `down_condition`, `response_time`, `services`,
  `tags`, `uptime_percent_calculation`; check config is the sslcert options (`crl`, `fingerprint`,
  `issuer`, …) — so the inherited value could never be meaningful. Set `config` per check instead.
- Remove a dead `tags` key from the generated primary group. The group module reads
  `additional_tags`, so this value was silently discarded; the primary tag was already applied
  through a separate path, so grouping is unaffected.
- Add the missing provider version constraint to the 14 submodules that declared only a `source`,
  so using a submodule directly cannot silently resolve a provider too old for its resources.

### Features

- Add support for the `uptime_private_locations` data source (provider v2.29.0+). Checks can set
  `use_private_locations = true` to monitor from the account's private locations; explicitly listed
  `locations` are merged in and de-duplicated. The account's locations are also available via the
  new `private_locations` and `private_check_locations` outputs, and the lookup is only performed
  when a check opts in or `lookup_private_locations` is set.
- Add INSPIRE-theme branding attributes to the statuspage module: `custom_css_inspire`,
  `custom_header_html_inspire`, `custom_footer_html_inspire` (provider v2.30.0+). API-managed status
  pages render with the INSPIRE theme, so the pre-existing legacy attributes (`custom_css`,
  `custom_header_html`, `custom_footer_html`) have no visible effect on them.
- Add `allow_subscriptions_webhook` and `visibility_level` to the statuspage module
- Add `sorting_weight` to statuspage components to control render order
- Add a dedicated private-locations example

### Notes

- Raise minimum provider version from `>= 2.28` to `>= 2.31` to cover the new attributes and data
  source, and to pick up the `uptime_statuspage` `auth_password` and `uptime_service_variable`
  resource-ID fixes released in v2.30.0/v2.31.0
- Align the simple, complete, and integrations examples with the current provider floor; they still
  pinned `~> 2.10`
- Update the complete example to use per-channel subscription flags, INSPIRE branding, and component
  `sorting_weight`

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
