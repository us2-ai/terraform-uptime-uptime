resource "uptime_statuspage" "this" {
  count = var.create ? 1 : 0

  name                         = var.name
  allow_drill_down             = var.allow_drill_down
  allow_pdf_report             = var.allow_pdf_report
  allow_search_indexing        = var.allow_search_indexing
  allow_subscriptions          = var.allow_subscriptions
  allow_subscriptions_email    = var.allow_subscriptions_email
  allow_subscriptions_rss      = var.allow_subscriptions_rss
  allow_subscriptions_slack    = var.allow_subscriptions_slack
  allow_subscriptions_sms      = var.allow_subscriptions_sms
  auth_password                = var.auth_password
  auth_username                = var.auth_username
  cname                        = var.cname
  company_website_url          = var.company_website_url
  contact_email                = var.contact_email
  custom_css                   = var.custom_css
  custom_footer_html           = var.custom_footer_html
  custom_header_bg_color_hex   = var.custom_header_bg_color_hex
  custom_header_html           = var.custom_header_html
  custom_header_text_color_hex = var.custom_header_text_color_hex
  default_history_date_range   = var.default_history_date_range
  description                  = var.description
  email_from                   = var.email_from
  email_reply_to               = var.email_reply_to
  google_analytics_code        = var.google_analytics_code
  hide_empty_tabs_history      = var.hide_empty_tabs_history
  max_visible_component_days   = var.max_visible_component_days
  page_type                    = var.page_type
  show_active_incidents        = var.show_active_incidents
  show_component_history       = var.show_component_history
  show_component_response_time = var.show_component_response_time
  show_history_snake           = var.show_history_snake
  show_history_tab             = var.show_history_tab
  show_past_incidents          = var.show_past_incidents
  show_status_tab              = var.show_status_tab
  show_summary_metrics         = var.show_summary_metrics
  slug                         = var.slug
  theme                        = var.theme
  timezone                     = var.timezone
  uptime_calculation_type      = var.uptime_calculation_type

  custom_header_html_inspire        = var.custom_header_html_inspire
  custom_footer_html_inspire        = var.custom_footer_html_inspire
  custom_css_inspire                = var.custom_css_inspire
  layout_preset                     = var.layout_preset
  show_component_bars               = var.show_component_bars
  show_component_group_descriptions = var.show_component_group_descriptions
  allow_notifications               = var.allow_notifications
  default_status_date_range         = var.default_status_date_range
  hide_empty_tabs_status            = var.hide_empty_tabs_status
  logo_url                          = var.logo_url
  email_logo_url                    = var.email_logo_url
  favicon_url                       = var.favicon_url
}

locals {
  statuspage_id = try(uptime_statuspage.this[0].id, null)
}

resource "uptime_statuspage_component" "this" {
  for_each = var.create ? var.components : {}

  statuspage_id    = local.statuspage_id
  name             = try(each.value.name, each.key)
  description      = try(each.value.description, null)
  auto_status_up   = try(each.value.auto_status_up, null)
  auto_status_down = try(each.value.auto_status_down, null)
  group_id         = try(each.value.group_id, null)
  is_group         = try(each.value.is_group, null)
  service_id       = try(each.value.service_id, null)
  status           = try(each.value.status, null)
}

resource "uptime_statuspage_incident" "this" {
  for_each = var.create ? var.incidents : {}

  statuspage_id                       = local.statuspage_id
  name                                = try(each.value.name, each.key)
  starts_at                           = each.value.starts_at
  ends_at                             = try(each.value.ends_at, null)
  incident_type                       = try(each.value.incident_type, null)
  include_in_global_metrics           = try(each.value.include_in_global_metrics, null)
  notify_subscribers                  = try(each.value.notify_subscribers, null)
  send_maintenance_start_notification = try(each.value.send_maintenance_start_notification, null)
  update_component_status             = try(each.value.update_component_status, null)

  updates             = try(each.value.updates, null)
  affected_components = try(each.value.affected_components, null)
}

resource "uptime_statuspage_metric" "this" {
  for_each = var.create ? var.metrics : {}

  statuspage_id = local.statuspage_id
  name          = try(each.value.name, each.key)
  service_id    = each.value.service_id
  is_visible    = try(each.value.is_visible, null)
}

resource "uptime_statuspage_subscriber" "this" {
  for_each = var.create ? var.subscribers : {}

  statuspage_id        = local.statuspage_id
  type                 = each.value.type
  target               = try(each.value.target, null)
  force_validation_sms = try(each.value.force_validation_sms, null)
}

resource "uptime_statuspage_subscription_domain_allow" "this" {
  for_each = var.create ? var.subscription_domain_allows : {}

  statuspage_id = local.statuspage_id
  domain        = try(each.value.domain, each.key)
}

resource "uptime_statuspage_subscription_domain_block" "this" {
  for_each = var.create ? var.subscription_domain_blocks : {}

  statuspage_id = local.statuspage_id
  domain        = try(each.value.domain, each.key)
}

resource "uptime_statuspage_user" "this" {
  for_each = var.create ? var.users : {}

  statuspage_id = local.statuspage_id
  email         = each.value.email
  first_name    = each.value.first_name
  last_name     = each.value.last_name
  is_active     = try(each.value.is_active, true)
}
