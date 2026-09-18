# Attribute allowlists for the root module's collection variables
#
# Collection variables are typed `any` and read with `try(each.value.<attr>, ...)`, so an attribute
# the module does not read would otherwise be silently discarded. Each collection validates its
# attribute names against the corresponding entry here. Adding an attribute to the module means
# adding it here too, or callers cannot set it.
#
# Referencing a local from a `validation` block requires Terraform/OpenTofu >= 1.9.

locals {
  allowed_attributes = {
    checks = [
      "address", "check_version", "cloudstatus_config", "config", "contact_groups", "create_check",
      "dns_record_type", "dns_server", "encryption", "expect_string", "expect_string_type",
      "headers", "include_in_global_metrics", "interval", "is_paused", "locations", "name",
      "notes", "num_retries", "pagespeed_config", "pagespeed_headers", "password", "port", "proxy",
      "script", "send_resolved_notifications", "send_string", "sensitivity", "sla", "sla_uptime",
      "status_code", "tags", "threshold", "type", "use_ip_version", "use_private_locations",
      "username"
    ]
    contacts = [
      "create_contact", "email_list", "integrations", "name", "phonecall_list",
      "push_notification_profiles", "sms_list"
    ]
    credentials = [
      "create_credential", "credential_type", "description", "display_name", "secret", "username"
    ]
    dashboards = [
      "alerts", "create_dashboard", "is_pinned", "metrics", "name", "ordering", "selected",
      "services"
    ]
    escalations = [
      "check_id", "create_escalation", "escalations"
    ]
    groups = [
      "additional_tags", "config", "contact_groups", "include_in_global_metrics", "is_paused",
      "name", "notes", "sla"
    ]
    integrations = [
      "contact_groups", "create_integration", "name", "settings", "type"
    ]
    maintenance_notifications = [
      "contact_groups", "create_maintenance_notification", "event", "offset", "schedule_id"
    ]
    maintenance_schedules = [
      "create_maintenance_schedule", "duration_minutes", "ends_at", "is_active", "name",
      "pause_checks_during_maintenance", "rrule", "schedule_type", "services", "starts_at", "tags"
    ]
    scheduled_reports = [
      "at_time", "create_scheduled_report", "file_type", "is_enabled", "name", "on_weekday",
      "recipient_emails", "recipient_users", "recurrence", "sla_report"
    ]
    service_variables = [
      "create_service_variable", "credential_id", "property_name", "service_id", "variable_name"
    ]
    sla_reports = [
      "create_sla_report", "default_date_range", "filter_response_time_sla_violations",
      "filter_slowest", "filter_uptime_sla_violations", "filter_with_downtime", "name",
      "reporting_groups", "response_time_section_sort", "services_selected", "services_tags",
      "show_response_time_section", "show_response_time_sla", "show_uptime_section",
      "show_uptime_sla", "uptime_section_sort"
    ]
    statuspages = [
      "allow_drill_down", "allow_pdf_report", "allow_search_indexing",
      "allow_subscriptions_email", "allow_subscriptions_rss", "allow_subscriptions_slack",
      "allow_subscriptions_sms", "allow_subscriptions_webhook", "auth_password", "auth_username",
      "cname", "company_website_url", "components", "contact_email", "create_statuspage",
      "custom_css", "custom_css_inspire", "custom_footer_html", "custom_footer_html_inspire",
      "custom_header_bg_color_hex", "custom_header_html", "custom_header_html_inspire",
      "custom_header_text_color_hex", "default_history_date_range", "description", "email_from",
      "email_reply_to", "google_analytics_code", "hide_empty_tabs_history", "incidents",
      "max_visible_component_days", "metrics", "name", "page_type", "show_active_incidents",
      "show_component_history", "show_component_response_time", "show_history_snake",
      "show_history_tab", "show_past_incidents", "show_status_tab", "show_summary_metrics", "slug",
      "subscribers", "subscription_domain_allows", "subscription_domain_blocks", "theme",
      "timezone", "uptime_calculation_type", "users", "visibility_level"
    ]
    subaccounts = [
      "create_subaccount", "name"
    ]
    tags = [
      "color_hex", "tag"
    ]
    users = [
      "access_level", "assigned_subaccounts", "create_user", "email", "first_name",
      "is_api_enabled", "last_name", "notify_paid_invoices", "password", "require_two_factor"
    ]
  }
}
