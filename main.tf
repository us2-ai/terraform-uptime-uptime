locals {
  create_tag   = var.create && var.create_tag
  create_group = var.create && var.create_group

  primary_tag = local.create_tag ? {
    "${var.name}" = {
      color_hex = var.color_hex
    }
  } : {}
  tags = merge(local.primary_tag, var.tags)

  primary_group = local.create_group ? {
    "${var.name}" = {
      contact_groups            = var.contact_groups
      include_in_global_metrics = var.include_in_global_metrics
      is_paused                 = var.is_paused
      notes                     = var.notes
      sla                       = var.sla
      tags                      = concat(try([module.tag[var.name].tag], []), var.additional_tags)

      config = {
        down_condition             = try(var.config.down_condition, null)
        services                   = try(var.config.services, [])
        tags                       = concat(try([module.tag[var.name].tag], []), try(var.config.tags, []))
        uptime_percent_calculation = try(var.config.uptime_percent_calculation, null)

        response_time = {
          calculation_mode = try(var.config.response_time.calculation_mode, null)
          check_type       = try(var.config.response_time.check_type, null)
          single_check     = try(var.config.response_time.single_check, null)
        }
      }
    }
  } : {}
  groups = merge(local.primary_group, var.groups)
}

module "tag" {
  source   = "./modules/tag"
  for_each = { for k, v in local.tags : k => v if var.create }

  tag       = try(each.value.tag, each.key)
  color_hex = try(each.value.color_hex, null)
}

module "group" {
  source   = "./modules/group"
  for_each = { for k, v in local.groups : k => v if var.create }

  name                      = try(each.value.name, each.key)
  contact_groups            = try(each.value.contact_groups, [])
  include_in_global_metrics = try(each.value.include_in_global_metrics, false)
  is_paused                 = try(each.value.is_paused, false)
  notes                     = try(each.value.notes, null)
  sla                       = try(each.value.sla, {})
  tags                      = concat(try([module.tag[var.name].tag], []), try(each.value.additional_tags, []))
  config                    = try(each.value.config, {})
}

module "check" {
  source   = "./modules/check"
  for_each = { for k, v in var.checks : k => v if var.create }

  create                      = try(each.value.create_check, true)
  name                        = try(each.value.name, each.key)
  type                        = each.value.type
  address                     = try(each.value.address, var.address)
  port                        = try(each.value.port, var.port)
  script                      = try(each.value.script, var.script)
  config                      = try(each.value.config, var.config)
  contact_groups              = try(each.value.contact_groups, var.contact_groups)
  interval                    = try(each.value.interval, var.interval)
  sensitivity                 = try(each.value.sensitivity, var.sensitivity)
  num_retries                 = try(each.value.num_retries, var.num_retries)
  encryption                  = try(each.value.encryption, var.encryption)
  dns_record_type             = try(each.value.dns_record_type, var.dns_record_type)
  dns_server                  = try(each.value.dns_server, var.dns_server)
  expect_string               = try(each.value.expect_string, var.expect_string)
  expect_string_type          = try(each.value.expect_string_type, var.expect_string_type)
  headers                     = try(each.value.headers, var.headers)
  username                    = try(each.value.username, var.username)
  password                    = try(each.value.password, var.password)
  proxy                       = try(each.value.proxy, var.proxy)
  send_string                 = try(each.value.send_string, var.send_string)
  status_code                 = try(each.value.status_code, var.status_code)
  check_version               = try(each.value.check_version, var.check_version)
  include_in_global_metrics   = try(each.value.include_in_global_metrics, var.include_in_global_metrics)
  is_paused                   = try(each.value.is_paused, var.is_paused)
  notes                       = try(each.value.notes, var.notes)
  tags                        = concat(try([module.tag[var.name].tag], []), try(each.value.tags, []), var.additional_tags)
  threshold                   = try(each.value.threshold, var.threshold)
  sla                         = try(each.value.sla, var.sla)
  locations                   = try(each.value.locations, var.locations)
  use_ip_version              = try(each.value.use_ip_version, var.use_ip_version)
  send_resolved_notifications = try(each.value.send_resolved_notifications, var.send_resolved_notifications)
  sla_uptime                  = try(each.value.sla_uptime, var.sla_uptime)
  pagespeed_config            = try(each.value.pagespeed_config, {})
  pagespeed_headers           = try(each.value.pagespeed_headers, null)
  cloudstatus_config          = try(each.value.cloudstatus_config, {})
}

module "integration" {
  source   = "./modules/integration"
  for_each = { for k, v in var.integrations : k => v if var.create }

  create         = try(each.value.create_integration, true)
  name           = try(each.value.name, each.key)
  type           = each.value.type
  contact_groups = try(each.value.contact_groups, var.contact_groups)
  settings       = try(each.value.settings, {})
}

module "escalation" {
  source   = "./modules/escalation"
  for_each = { for k, v in var.escalations : k => v if var.create }

  create      = try(each.value.create_escalation, true)
  check_id    = each.value.check_id
  escalations = each.value.escalations
}

module "maintenance" {
  source   = "./modules/maintenance"
  for_each = { for k, v in var.maintenances : k => v if var.create }

  create                         = try(each.value.create_maintenance, true)
  check_id                       = each.value.check_id
  schedule                       = try(each.value.schedule, null)
  state                          = try(each.value.state, null)
  pause_on_scheduled_maintenance = try(each.value.pause_on_scheduled_maintenance, null)
}

module "maintenance_schedule" {
  source   = "./modules/maintenance_schedule"
  for_each = { for k, v in var.maintenance_schedules : k => v if var.create }

  create                          = try(each.value.create_maintenance_schedule, true)
  name                            = try(each.value.name, each.key)
  schedule_type                   = each.value.schedule_type
  starts_at                       = each.value.starts_at
  duration_minutes                = try(each.value.duration_minutes, null)
  ends_at                         = try(each.value.ends_at, null)
  is_active                       = try(each.value.is_active, null)
  pause_checks_during_maintenance = try(each.value.pause_checks_during_maintenance, null)
  rrule                           = try(each.value.rrule, null)
  services                        = try(each.value.services, null)
  tags                            = try(each.value.tags, null)
}

module "maintenance_notification" {
  source   = "./modules/maintenance_notification"
  for_each = { for k, v in var.maintenance_notifications : k => v if var.create }

  create         = try(each.value.create_maintenance_notification, true)
  schedule_id    = each.value.schedule_id
  event          = each.value.event
  offset         = each.value.offset
  contact_groups = each.value.contact_groups
}

module "contact" {
  source   = "./modules/contact"
  for_each = { for k, v in var.contacts : k => v if var.create }

  create                     = try(each.value.create_contact, true)
  name                       = try(each.value.name, each.key)
  email_list                 = try(each.value.email_list, null)
  sms_list                   = try(each.value.sms_list, null)
  phonecall_list             = try(each.value.phonecall_list, null)
  integrations               = try(each.value.integrations, null)
  push_notification_profiles = try(each.value.push_notification_profiles, null)
}

module "statuspage" {
  source   = "./modules/statuspage"
  for_each = { for k, v in var.statuspages : k => v if var.create }

  create                       = try(each.value.create_statuspage, true)
  name                         = try(each.value.name, each.key)
  allow_drill_down             = try(each.value.allow_drill_down, null)
  allow_pdf_report             = try(each.value.allow_pdf_report, null)
  allow_search_indexing        = try(each.value.allow_search_indexing, null)
  allow_subscriptions          = try(each.value.allow_subscriptions, null)
  allow_subscriptions_email    = try(each.value.allow_subscriptions_email, null)
  allow_subscriptions_rss      = try(each.value.allow_subscriptions_rss, null)
  allow_subscriptions_slack    = try(each.value.allow_subscriptions_slack, null)
  allow_subscriptions_sms      = try(each.value.allow_subscriptions_sms, null)
  auth_password                = try(each.value.auth_password, null)
  auth_username                = try(each.value.auth_username, null)
  cname                        = try(each.value.cname, null)
  company_website_url          = try(each.value.company_website_url, null)
  contact_email                = try(each.value.contact_email, null)
  custom_css                   = try(each.value.custom_css, null)
  custom_footer_html           = try(each.value.custom_footer_html, null)
  custom_header_bg_color_hex   = try(each.value.custom_header_bg_color_hex, null)
  custom_header_html           = try(each.value.custom_header_html, null)
  custom_header_text_color_hex = try(each.value.custom_header_text_color_hex, null)
  default_history_date_range   = try(each.value.default_history_date_range, null)
  description                  = try(each.value.description, null)
  email_from                   = try(each.value.email_from, null)
  email_reply_to               = try(each.value.email_reply_to, null)
  google_analytics_code        = try(each.value.google_analytics_code, null)
  hide_empty_tabs_history      = try(each.value.hide_empty_tabs_history, null)
  max_visible_component_days   = try(each.value.max_visible_component_days, null)
  page_type                    = try(each.value.page_type, null)
  show_active_incidents        = try(each.value.show_active_incidents, null)
  show_component_history       = try(each.value.show_component_history, null)
  show_component_response_time = try(each.value.show_component_response_time, null)
  show_history_snake           = try(each.value.show_history_snake, null)
  show_history_tab             = try(each.value.show_history_tab, null)
  show_past_incidents          = try(each.value.show_past_incidents, null)
  show_status_tab              = try(each.value.show_status_tab, null)
  show_summary_metrics         = try(each.value.show_summary_metrics, null)
  slug                         = try(each.value.slug, null)
  theme                        = try(each.value.theme, null)
  timezone                     = try(each.value.timezone, null)
  uptime_calculation_type      = try(each.value.uptime_calculation_type, null)
  components                   = try(each.value.components, {})
  incidents                    = try(each.value.incidents, {})
  metrics                      = try(each.value.metrics, {})
  subscribers                  = try(each.value.subscribers, {})
  subscription_domain_allows   = try(each.value.subscription_domain_allows, {})
  subscription_domain_blocks   = try(each.value.subscription_domain_blocks, {})
  users                        = try(each.value.users, {})
}

module "credential" {
  source   = "./modules/credential"
  for_each = { for k, v in var.credentials : k => v if var.create }

  create          = try(each.value.create_credential, true)
  display_name    = try(each.value.display_name, each.key)
  credential_type = each.value.credential_type
  description     = try(each.value.description, null)
  username        = try(each.value.username, null)
  secret          = each.value.secret
}

module "dashboard" {
  source   = "./modules/dashboard"
  for_each = { for k, v in var.dashboards : k => v if var.create }

  create    = try(each.value.create_dashboard, true)
  name      = try(each.value.name, each.key)
  is_pinned = try(each.value.is_pinned, null)
  ordering  = try(each.value.ordering, null)
  alerts    = each.value.alerts
  metrics   = try(each.value.metrics, null)
  selected  = each.value.selected
  services  = each.value.services
}

module "sla_report" {
  source   = "./modules/sla_report"
  for_each = { for k, v in var.sla_reports : k => v if var.create }

  create                              = try(each.value.create_sla_report, true)
  name                                = try(each.value.name, each.key)
  default_date_range                  = try(each.value.default_date_range, null)
  show_uptime_section                 = try(each.value.show_uptime_section, null)
  show_uptime_sla                     = try(each.value.show_uptime_sla, null)
  uptime_section_sort                 = try(each.value.uptime_section_sort, null)
  filter_uptime_sla_violations        = try(each.value.filter_uptime_sla_violations, null)
  filter_with_downtime                = try(each.value.filter_with_downtime, null)
  show_response_time_section          = try(each.value.show_response_time_section, null)
  show_response_time_sla              = try(each.value.show_response_time_sla, null)
  response_time_section_sort          = try(each.value.response_time_section_sort, null)
  filter_response_time_sla_violations = try(each.value.filter_response_time_sla_violations, null)
  filter_slowest                      = try(each.value.filter_slowest, null)
  services_tags                       = try(each.value.services_tags, null)
  services_selected                   = try(each.value.services_selected, null)
  reporting_groups                    = try(each.value.reporting_groups, null)
}

module "scheduled_report" {
  source   = "./modules/scheduled_report"
  for_each = { for k, v in var.scheduled_reports : k => v if var.create }

  create           = try(each.value.create_scheduled_report, true)
  name             = try(each.value.name, each.key)
  sla_report       = each.value.sla_report
  recurrence       = try(each.value.recurrence, null)
  at_time          = try(each.value.at_time, null)
  on_weekday       = try(each.value.on_weekday, null)
  file_type        = try(each.value.file_type, null)
  is_enabled       = try(each.value.is_enabled, null)
  recipient_emails = try(each.value.recipient_emails, null)
  recipient_users  = try(each.value.recipient_users, null)
}

module "service_variable" {
  source   = "./modules/service_variable"
  for_each = { for k, v in var.service_variables : k => v if var.create }

  create        = try(each.value.create_service_variable, true)
  service_id    = each.value.service_id
  credential_id = each.value.credential_id
  variable_name = try(each.value.variable_name, each.key)
  property_name = each.value.property_name
}

module "subaccount" {
  source   = "./modules/subaccount"
  for_each = { for k, v in var.subaccounts : k => v if var.create }

  create = try(each.value.create_subaccount, true)
  name   = try(each.value.name, each.key)
}

module "user" {
  source   = "./modules/user"
  for_each = { for k, v in var.users : k => v if var.create }

  create               = try(each.value.create_user, true)
  email                = each.value.email
  password             = each.value.password
  first_name           = try(each.value.first_name, null)
  last_name            = try(each.value.last_name, null)
  access_level         = try(each.value.access_level, null)
  is_api_enabled       = try(each.value.is_api_enabled, null)
  notify_paid_invoices = try(each.value.notify_paid_invoices, null)
  require_two_factor   = try(each.value.require_two_factor, null)
  assigned_subaccounts = try(each.value.assigned_subaccounts, null)
}
