output "check" {
  description = "Check outputs"
  value       = module.uptime.check
}

output "private_locations" {
  description = "Full private monitoring location records, including country"
  value       = module.uptime.private_locations
}

output "private_check_locations" {
  description = "Private location values in the form a check's locations list expects"
  value       = module.uptime.private_check_locations
}
