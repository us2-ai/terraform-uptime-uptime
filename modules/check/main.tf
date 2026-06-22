locals {
  http_protocol = var.encryption ? "https://" : "http://"
  http_address  = join("", [local.http_protocol, var.address])
  http_port     = var.encryption ? 443 : 80
  encryption    = var.encryption ? "SSL_TLS" : null
}

resource "uptime_check_blacklist" "this" {
  count = var.create && var.type == "blacklist" ? 1 : 0

  address = var.address
  name    = var.name

  contact_groups = var.contact_groups
  is_paused      = var.is_paused
  locations      = var.locations
  notes          = var.notes
  num_retries    = var.num_retries
  tags           = var.tags
}

resource "uptime_check_cloudstatus" "this" {
  count = var.create && var.type == "cloudstatus" ? 1 : 0

  name = var.name

  contact_groups      = var.contact_groups
  group               = try(var.cloudstatus_config.group, null)
  is_paused           = var.is_paused
  locations           = var.locations
  monitoring_type     = try(var.cloudstatus_config.monitoring_type, null)
  notify_only_on_down = try(var.cloudstatus_config.notify_only_on_down, null)
  service_name        = try(var.cloudstatus_config.service_name, null)
  service_titles      = try(var.cloudstatus_config.service_titles, null)
  services            = try(var.cloudstatus_config.services, null)
  tags                = var.tags
}

resource "uptime_check_dns" "this" {
  count = var.create && var.type == "dns" ? 1 : 0

  address = var.address
  name    = var.name

  contact_groups            = var.contact_groups
  dns_record_type           = var.dns_record_type
  dns_server                = var.dns_server
  expect_string             = var.expect_string
  include_in_global_metrics = var.include_in_global_metrics
  interval                  = var.interval
  is_paused                 = var.is_paused
  locations                 = var.locations
  notes                     = var.notes
  num_retries               = var.num_retries
  sensitivity               = var.sensitivity
  sla                       = var.sla
  tags                      = var.tags
  threshold                 = var.threshold
}

resource "uptime_check_sslcert" "this" {
  count = var.create && var.type == "sslcert" ? 1 : 0

  address = var.address
  name    = var.name

  config = {
    crl                       = try(var.config.crl, null)
    fingerprint               = try(var.config.fingerprint, null)
    first_element_only        = try(var.config.first_element_only, null)
    ignore_authority_warnings = try(var.config.ignore_authority_warnings, null)
    ignore_sct                = try(var.config.ignore_sct, null)
    issuer                    = try(var.config.issuer, null)
    match                     = try(var.config.match, null)
    min_version               = try(var.config.min_version, null)
    protocol                  = try(var.config.protocol, null)
    resolve                   = try(var.config.resolve, null)
    self_signed               = try(var.config.self_signed, null)
    url                       = try(var.config.url, null)
  }
  contact_groups = var.contact_groups
  is_paused      = var.is_paused
  locations      = var.locations
  notes          = var.notes
  num_retries    = var.num_retries
  port           = var.port
  tags           = var.tags
  threshold      = var.threshold
}

resource "uptime_check_malware" "this" {
  count = var.create && var.type == "malware" ? 1 : 0

  address = var.address
  name    = var.name

  contact_groups = var.contact_groups
  is_paused      = var.is_paused
  locations      = var.locations
  notes          = var.notes
  num_retries    = var.num_retries
  sla            = var.sla
  tags           = var.tags
}

resource "uptime_check_http" "this" {
  count = var.create && var.type == "http" ? 1 : 0

  address = local.http_address
  name    = var.name

  contact_groups            = var.contact_groups
  encryption                = local.encryption
  expect_string             = var.expect_string
  expect_string_type        = var.expect_string_type
  headers                   = var.headers
  include_in_global_metrics = var.include_in_global_metrics
  interval                  = var.interval
  is_paused                 = var.is_paused
  locations                 = var.locations
  notes                     = var.notes
  num_retries               = var.num_retries
  password                  = var.password
  port                      = try(var.port, local.http_port)
  proxy                     = var.proxy
  send_string               = var.send_string
  sensitivity               = var.sensitivity
  sla                       = var.sla
  status_code               = var.status_code
  tags                      = var.tags
  threshold                 = var.threshold
  username                  = var.username
  version                   = var.check_version
}

resource "uptime_check_ssh" "this" {
  count = var.create && var.type == "ssh" ? 1 : 0

  address = var.address
  name    = var.name

  contact_groups            = var.contact_groups
  include_in_global_metrics = var.include_in_global_metrics
  interval                  = var.interval
  is_paused                 = var.is_paused
  locations                 = var.locations
  notes                     = var.notes
  num_retries               = var.num_retries
  port                      = var.port
  sensitivity               = var.sensitivity
  sla                       = var.sla
  tags                      = var.tags
  use_ip_version            = var.use_ip_version
}

resource "uptime_check_tcp" "this" {
  count = var.create && var.type == "tcp" ? 1 : 0

  address = var.address
  name    = var.name

  contact_groups            = var.contact_groups
  encryption                = local.encryption
  expect_string             = var.expect_string
  include_in_global_metrics = var.include_in_global_metrics
  interval                  = var.interval
  is_paused                 = var.is_paused
  locations                 = var.locations
  notes                     = var.notes
  num_retries               = var.num_retries
  port                      = var.port
  send_string               = var.send_string
  sla                       = var.sla
  tags                      = var.tags
  use_ip_version            = var.use_ip_version
}

resource "uptime_check_api" "this" {
  count = var.create && var.type == "api" ? 1 : 0

  name   = var.name
  script = var.script

  contact_groups            = var.contact_groups
  include_in_global_metrics = var.include_in_global_metrics
  interval                  = var.interval
  is_paused                 = var.is_paused
  locations                 = var.locations
  notes                     = var.notes
  num_retries               = var.num_retries
  sensitivity               = var.sensitivity
  sla                       = var.sla
  tags                      = var.tags
  threshold                 = var.threshold
}

resource "uptime_check_heartbeat" "this" {
  count = var.create && var.type == "heartbeat" ? 1 : 0

  name = var.name

  contact_groups            = var.contact_groups
  include_in_global_metrics = var.include_in_global_metrics
  interval                  = var.interval
  is_paused                 = var.is_paused
  notes                     = var.notes
  sla                       = var.sla
  tags                      = var.tags
}

resource "uptime_check_icmp" "this" {
  count = var.create && var.type == "icmp" ? 1 : 0

  address = var.address
  name    = var.name

  contact_groups            = var.contact_groups
  include_in_global_metrics = var.include_in_global_metrics
  interval                  = var.interval
  is_paused                 = var.is_paused
  locations                 = var.locations
  notes                     = var.notes
  num_retries               = var.num_retries
  sensitivity               = var.sensitivity
  sla                       = var.sla
  tags                      = var.tags
  use_ip_version            = var.use_ip_version
}

resource "uptime_check_imap" "this" {
  count = var.create && var.type == "imap" ? 1 : 0

  address = var.address
  name    = var.name

  contact_groups            = var.contact_groups
  encryption                = local.encryption
  expect_string             = var.expect_string
  include_in_global_metrics = var.include_in_global_metrics
  interval                  = var.interval
  is_paused                 = var.is_paused
  locations                 = var.locations
  notes                     = var.notes
  num_retries               = var.num_retries
  port                      = var.port
  sla                       = var.sla
  tags                      = var.tags
  use_ip_version            = var.use_ip_version
}

resource "uptime_check_ntp" "this" {
  count = var.create && var.type == "ntp" ? 1 : 0

  address = var.address
  name    = var.name

  contact_groups            = var.contact_groups
  include_in_global_metrics = var.include_in_global_metrics
  interval                  = var.interval
  is_paused                 = var.is_paused
  locations                 = var.locations
  notes                     = var.notes
  num_retries               = var.num_retries
  port                      = var.port
  sensitivity               = var.sensitivity
  sla                       = var.sla
  tags                      = var.tags
  threshold                 = var.threshold
  use_ip_version            = var.use_ip_version
}

resource "uptime_check_pagespeed" "this" {
  count = var.create && var.type == "pagespeed" ? 1 : 0

  name   = var.name
  script = var.script

  config = {
    connection_throttling  = try(var.pagespeed_config.connection_throttling, null)
    emulated_device        = try(var.pagespeed_config.emulated_device, null)
    exclude_urls           = try(var.pagespeed_config.exclude_urls, null)
    uptime_grade_threshold = try(var.pagespeed_config.uptime_grade_threshold, null)
  }
  contact_groups = var.contact_groups
  headers        = var.pagespeed_headers
  interval       = var.interval
  is_paused      = var.is_paused
  locations      = var.locations
  notes          = var.notes
  num_retries    = var.num_retries
  password       = var.password
  tags           = var.tags
  username       = var.username
}

resource "uptime_check_pop" "this" {
  count = var.create && var.type == "pop" ? 1 : 0

  address = var.address
  name    = var.name

  contact_groups            = var.contact_groups
  encryption                = local.encryption
  expect_string             = var.expect_string
  include_in_global_metrics = var.include_in_global_metrics
  interval                  = var.interval
  is_paused                 = var.is_paused
  locations                 = var.locations
  notes                     = var.notes
  num_retries               = var.num_retries
  port                      = var.port
  sla                       = var.sla
  tags                      = var.tags
  use_ip_version            = var.use_ip_version
}

resource "uptime_check_rdap" "this" {
  count = var.create && var.type == "rdap" ? 1 : 0

  address = var.address
  name    = var.name

  contact_groups              = var.contact_groups
  expect_string               = var.expect_string
  is_paused                   = var.is_paused
  locations                   = var.locations
  notes                       = var.notes
  num_retries                 = var.num_retries
  send_resolved_notifications = var.send_resolved_notifications
  sla                         = var.sla
  tags                        = var.tags
  threshold                   = var.threshold
}

resource "uptime_check_rum2" "this" {
  count = var.create && var.type == "rum2" ? 1 : 0

  address = var.address
  name    = var.name

  contact_groups            = var.contact_groups
  include_in_global_metrics = var.include_in_global_metrics
  is_paused                 = var.is_paused
  notes                     = var.notes
  sla_uptime                = var.sla_uptime
  tags                      = var.tags
}

resource "uptime_check_smtp" "this" {
  count = var.create && var.type == "smtp" ? 1 : 0

  address = var.address
  name    = var.name

  contact_groups            = var.contact_groups
  encryption                = local.encryption
  expect_string             = var.expect_string
  include_in_global_metrics = var.include_in_global_metrics
  interval                  = var.interval
  is_paused                 = var.is_paused
  locations                 = var.locations
  notes                     = var.notes
  num_retries               = var.num_retries
  port                      = var.port
  sla                       = var.sla
  tags                      = var.tags
  use_ip_version            = var.use_ip_version
}

resource "uptime_check_transaction" "this" {
  count = var.create && var.type == "transaction" ? 1 : 0

  name   = var.name
  script = var.script

  contact_groups            = var.contact_groups
  include_in_global_metrics = var.include_in_global_metrics
  interval                  = var.interval
  is_paused                 = var.is_paused
  locations                 = var.locations
  notes                     = var.notes
  num_retries               = var.num_retries
  sensitivity               = var.sensitivity
  sla                       = var.sla
  tags                      = var.tags
  threshold                 = var.threshold
}

resource "uptime_check_udp" "this" {
  count = var.create && var.type == "udp" ? 1 : 0

  address       = var.address
  expect_string = var.expect_string
  name          = var.name
  port          = var.port
  send_string   = var.send_string

  contact_groups            = var.contact_groups
  include_in_global_metrics = var.include_in_global_metrics
  interval                  = var.interval
  is_paused                 = var.is_paused
  locations                 = var.locations
  notes                     = var.notes
  num_retries               = var.num_retries
  sensitivity               = var.sensitivity
  sla                       = var.sla
  tags                      = var.tags
  use_ip_version            = var.use_ip_version
}

resource "uptime_check_webhook" "this" {
  count = var.create && var.type == "webhook" ? 1 : 0

  name = var.name

  contact_groups            = var.contact_groups
  include_in_global_metrics = var.include_in_global_metrics
  is_paused                 = var.is_paused
  notes                     = var.notes
  sla                       = var.sla
  tags                      = var.tags
}

resource "uptime_check_whois" "this" {
  count = var.create && var.type == "whois" ? 1 : 0

  address       = var.address
  expect_string = var.expect_string
  name          = var.name

  contact_groups = var.contact_groups
  is_paused      = var.is_paused
  locations      = var.locations
  notes          = var.notes
  num_retries    = var.num_retries
  sla            = var.sla
  tags           = var.tags
  threshold      = var.threshold
}
