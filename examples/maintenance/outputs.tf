output "check" {
  description = "Check outputs"
  value       = module.uptime.check
}

output "contact" {
  description = "Contact outputs"
  value       = module.uptime.contact
}

output "maintenance_schedule" {
  description = "Maintenance schedule outputs"
  value       = module.uptime.maintenance_schedule
}

output "maintenance_notification" {
  description = "Maintenance notification outputs"
  value       = module.uptime.maintenance_notification
}
