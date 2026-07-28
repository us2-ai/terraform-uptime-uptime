locals {
  # At most one of the integration resources exists, selected by var.type — and none at all when
  # create is false. `one()` yields null for an empty list, where coalesce() would fail with
  # "no non-null arguments" and break plan for an integration that was deliberately disabled.
  integration_ids = concat(
    uptime_integration_cachet.this[*].id,
    uptime_integration_datadog.this[*].id,
    uptime_integration_geckoboard.this[*].id,
    uptime_integration_jira_servicedesk.this[*].id,
    uptime_integration_klipfolio.this[*].id,
    uptime_integration_microsoft_teams.this[*].id,
    uptime_integration_opsgenie.this[*].id,
    uptime_integration_pagerduty.this[*].id,
    uptime_integration_pushbullet.this[*].id,
    uptime_integration_pushover.this[*].id,
    uptime_integration_slack.this[*].id,
    uptime_integration_status.this[*].id,
    uptime_integration_statuspage.this[*].id,
    uptime_integration_victorops.this[*].id,
    uptime_integration_wavefront.this[*].id,
    uptime_integration_webhook.this[*].id,
    uptime_integration_zapier.this[*].id,
  )

  integration_names = concat(
    uptime_integration_cachet.this[*].name,
    uptime_integration_datadog.this[*].name,
    uptime_integration_geckoboard.this[*].name,
    uptime_integration_jira_servicedesk.this[*].name,
    uptime_integration_klipfolio.this[*].name,
    uptime_integration_microsoft_teams.this[*].name,
    uptime_integration_opsgenie.this[*].name,
    uptime_integration_pagerduty.this[*].name,
    uptime_integration_pushbullet.this[*].name,
    uptime_integration_pushover.this[*].name,
    uptime_integration_slack.this[*].name,
    uptime_integration_status.this[*].name,
    uptime_integration_statuspage.this[*].name,
    uptime_integration_victorops.this[*].name,
    uptime_integration_wavefront.this[*].name,
    uptime_integration_webhook.this[*].name,
    uptime_integration_zapier.this[*].name,
  )
}

output "id" {
  description = "The ID of the integration, or null when the integration is not created"
  value       = one(local.integration_ids)
}

output "name" {
  description = "The name of the integration, or null when the integration is not created"
  value       = one(local.integration_names)
}
