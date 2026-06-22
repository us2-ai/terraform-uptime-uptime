output "id" {
  description = "The ID of the check"
  value = coalesce(
    try(uptime_check_api.this[0].id, null),
    try(uptime_check_blacklist.this[0].id, null),
    try(uptime_check_cloudstatus.this[0].id, null),
    try(uptime_check_dns.this[0].id, null),
    try(uptime_check_heartbeat.this[0].id, null),
    try(uptime_check_http.this[0].id, null),
    try(uptime_check_icmp.this[0].id, null),
    try(uptime_check_imap.this[0].id, null),
    try(uptime_check_malware.this[0].id, null),
    try(uptime_check_ntp.this[0].id, null),
    try(uptime_check_pagespeed.this[0].id, null),
    try(uptime_check_pop.this[0].id, null),
    try(uptime_check_rdap.this[0].id, null),
    try(uptime_check_rum2.this[0].id, null),
    try(uptime_check_smtp.this[0].id, null),
    try(uptime_check_sslcert.this[0].id, null),
    try(uptime_check_ssh.this[0].id, null),
    try(uptime_check_tcp.this[0].id, null),
    try(uptime_check_transaction.this[0].id, null),
    try(uptime_check_udp.this[0].id, null),
    try(uptime_check_webhook.this[0].id, null),
    try(uptime_check_whois.this[0].id, null),
  )
}

output "name" {
  description = "The name of the check"
  value = coalesce(
    try(uptime_check_api.this[0].name, null),
    try(uptime_check_blacklist.this[0].name, null),
    try(uptime_check_cloudstatus.this[0].name, null),
    try(uptime_check_dns.this[0].name, null),
    try(uptime_check_heartbeat.this[0].name, null),
    try(uptime_check_http.this[0].name, null),
    try(uptime_check_icmp.this[0].name, null),
    try(uptime_check_imap.this[0].name, null),
    try(uptime_check_malware.this[0].name, null),
    try(uptime_check_ntp.this[0].name, null),
    try(uptime_check_pagespeed.this[0].name, null),
    try(uptime_check_pop.this[0].name, null),
    try(uptime_check_rdap.this[0].name, null),
    try(uptime_check_rum2.this[0].name, null),
    try(uptime_check_smtp.this[0].name, null),
    try(uptime_check_sslcert.this[0].name, null),
    try(uptime_check_ssh.this[0].name, null),
    try(uptime_check_tcp.this[0].name, null),
    try(uptime_check_transaction.this[0].name, null),
    try(uptime_check_udp.this[0].name, null),
    try(uptime_check_webhook.this[0].name, null),
    try(uptime_check_whois.this[0].name, null),
  )
}

output "heartbeat_url" {
  description = "The heartbeat URL (only for heartbeat checks)"
  value       = try(uptime_check_heartbeat.this[0].heartbeat_url, null)
}

output "webhook_url" {
  description = "The webhook URL (only for webhook checks)"
  value       = try(uptime_check_webhook.this[0].webhook_url, null)
}
