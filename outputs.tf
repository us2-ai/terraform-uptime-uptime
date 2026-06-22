output "tag" {
  description = "Map of tag module outputs keyed by tag name"
  value       = module.tag
}

output "group" {
  description = "Map of check group module outputs keyed by group name"
  value       = module.group
}

output "check" {
  description = "Map of check module outputs keyed by check name"
  value       = module.check
}

output "integration" {
  description = "Map of integration module outputs keyed by integration name"
  value       = module.integration
}

output "escalation" {
  description = "Map of escalation module outputs keyed by escalation name"
  value       = module.escalation
}

output "maintenance" {
  description = "Map of maintenance module outputs keyed by maintenance name"
  value       = module.maintenance
}

output "maintenance_schedule" {
  description = "Map of maintenance schedule module outputs keyed by schedule name"
  value       = module.maintenance_schedule
}

output "maintenance_notification" {
  description = "Map of maintenance notification module outputs keyed by notification name"
  value       = module.maintenance_notification
}

output "contact" {
  description = "Map of contact module outputs keyed by contact name"
  value       = module.contact
}

output "statuspage" {
  description = "Map of statuspage module outputs keyed by statuspage name"
  value       = module.statuspage
}

output "credential" {
  description = "Map of credential module outputs keyed by credential name"
  value       = module.credential
}

output "dashboard" {
  description = "Map of dashboard module outputs keyed by dashboard name"
  value       = module.dashboard
}

output "sla_report" {
  description = "Map of SLA report module outputs keyed by report name"
  value       = module.sla_report
}

output "scheduled_report" {
  description = "Map of scheduled report module outputs keyed by report name"
  value       = module.scheduled_report
}

output "service_variable" {
  description = "Map of service variable module outputs keyed by variable name"
  value       = module.service_variable
}

output "subaccount" {
  description = "Map of subaccount module outputs keyed by subaccount name"
  value       = module.subaccount
}

output "user" {
  description = "Map of user module outputs keyed by user name"
  value       = module.user
}
