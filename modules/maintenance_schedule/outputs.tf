output "id" {
  description = "The ID of the maintenance schedule"
  value       = try(uptime_maintenance_schedule.this[0].id, null)
}

output "name" {
  description = "The name of the maintenance schedule"
  value       = try(uptime_maintenance_schedule.this[0].name, null)
}

output "created_at" {
  description = "Creation timestamp of the maintenance schedule"
  value       = try(uptime_maintenance_schedule.this[0].created_at, null)
}

output "modified_at" {
  description = "Last modification timestamp of the maintenance schedule"
  value       = try(uptime_maintenance_schedule.this[0].modified_at, null)
}
