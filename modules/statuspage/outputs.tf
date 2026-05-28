output "id" {
  description = "The ID of the status page"
  value       = try(uptime_statuspage.this[0].id, null)
}

output "name" {
  description = "The status page name"
  value       = try(uptime_statuspage.this[0].name, null)
}

output "url" {
  description = "The API URL of the status page"
  value       = try(uptime_statuspage.this[0].url, null)
}

output "slug" {
  description = "The URL slug of the status page"
  value       = try(uptime_statuspage.this[0].slug, null)
}

output "component" {
  description = "Map of status page component outputs"
  value       = uptime_statuspage_component.this
}

output "incident" {
  description = "Map of status page incident outputs"
  value       = uptime_statuspage_incident.this
}

output "metric" {
  description = "Map of status page metric outputs"
  value       = uptime_statuspage_metric.this
}

output "subscriber" {
  description = "Map of status page subscriber outputs"
  value       = uptime_statuspage_subscriber.this
}

output "user" {
  description = "Map of status page user outputs"
  value       = uptime_statuspage_user.this
}

output "public_url" {
  description = "Public-facing URL of the status page (populated by the API)"
  value       = try(uptime_statuspage.this[0].public_url, null)
}

output "private_url" {
  description = "Internal URL of the status page"
  value       = try(uptime_statuspage.this[0].private_url, null)
}

output "cname_url" {
  description = "Custom-domain URL of the status page (when a cname is configured)"
  value       = try(uptime_statuspage.this[0].cname_url, null)
}

output "incidents_url" {
  description = "API URL for incidents on the status page"
  value       = try(uptime_statuspage.this[0].incidents_url, null)
}

output "components_url" {
  description = "API URL for components on the status page"
  value       = try(uptime_statuspage.this[0].components_url, null)
}

output "metrics_url" {
  description = "API URL for metrics on the status page"
  value       = try(uptime_statuspage.this[0].metrics_url, null)
}

output "history_url" {
  description = "API URL for history entries on the status page"
  value       = try(uptime_statuspage.this[0].history_url, null)
}

output "current_status_url" {
  description = "API URL for the current status snapshot"
  value       = try(uptime_statuspage.this[0].current_status_url, null)
}

output "description_html" {
  description = "HTML-rendered description of the status page"
  value       = try(uptime_statuspage.this[0].description_html, null)
}

output "page_type_display" {
  description = "Human-readable label for the page type"
  value       = try(uptime_statuspage.this[0].page_type_display, null)
}
