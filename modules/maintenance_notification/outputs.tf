output "id" {
  description = "The ID of the maintenance notification"
  value       = try(uptime_maintenance_notification.this[0].id, null)
}

output "created_at" {
  description = "Creation timestamp of the maintenance notification"
  value       = try(uptime_maintenance_notification.this[0].created_at, null)
}

output "modified_at" {
  description = "Last modification timestamp of the maintenance notification"
  value       = try(uptime_maintenance_notification.this[0].modified_at, null)
}
