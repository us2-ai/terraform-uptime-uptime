locals {
  # At most one of the check resources exists, selected by var.type — and none at all when
  # create is false. `one()` yields null for an empty list, where coalesce() would fail with
  # "no non-null arguments" and break plan for a check that was deliberately disabled.
  check_ids = concat(
    uptime_check_api.this[*].id,
    uptime_check_blacklist.this[*].id,
    uptime_check_cloudstatus.this[*].id,
    uptime_check_dns.this[*].id,
    uptime_check_heartbeat.this[*].id,
    uptime_check_http.this[*].id,
    uptime_check_icmp.this[*].id,
    uptime_check_imap.this[*].id,
    uptime_check_malware.this[*].id,
    uptime_check_ntp.this[*].id,
    uptime_check_pagespeed.this[*].id,
    uptime_check_pop.this[*].id,
    uptime_check_rdap.this[*].id,
    uptime_check_rum2.this[*].id,
    uptime_check_smtp.this[*].id,
    uptime_check_sslcert.this[*].id,
    uptime_check_ssh.this[*].id,
    uptime_check_tcp.this[*].id,
    uptime_check_transaction.this[*].id,
    uptime_check_udp.this[*].id,
    uptime_check_webhook.this[*].id,
    uptime_check_whois.this[*].id,
  )

  check_names = concat(
    uptime_check_api.this[*].name,
    uptime_check_blacklist.this[*].name,
    uptime_check_cloudstatus.this[*].name,
    uptime_check_dns.this[*].name,
    uptime_check_heartbeat.this[*].name,
    uptime_check_http.this[*].name,
    uptime_check_icmp.this[*].name,
    uptime_check_imap.this[*].name,
    uptime_check_malware.this[*].name,
    uptime_check_ntp.this[*].name,
    uptime_check_pagespeed.this[*].name,
    uptime_check_pop.this[*].name,
    uptime_check_rdap.this[*].name,
    uptime_check_rum2.this[*].name,
    uptime_check_smtp.this[*].name,
    uptime_check_sslcert.this[*].name,
    uptime_check_ssh.this[*].name,
    uptime_check_tcp.this[*].name,
    uptime_check_transaction.this[*].name,
    uptime_check_udp.this[*].name,
    uptime_check_webhook.this[*].name,
    uptime_check_whois.this[*].name,
  )
}

output "id" {
  description = "The ID of the check, or null when the check is not created"
  value       = one(local.check_ids)
}

output "name" {
  description = "The name of the check, or null when the check is not created"
  value       = one(local.check_names)
}

output "heartbeat_url" {
  description = "The heartbeat URL (only for heartbeat checks)"
  value       = try(uptime_check_heartbeat.this[0].heartbeat_url, null)
}

output "webhook_url" {
  description = "The webhook URL (only for webhook checks)"
  value       = try(uptime_check_webhook.this[0].webhook_url, null)
}
