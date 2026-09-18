# statuspage

Submodule for creating Uptime.com status pages together with their components, incidents, metrics, subscribers, subscription domain allow and block lists, and users. Each nested collection validates its attribute names against `allowlists.tf`.

## Usage

```hcl
module "statuspage" {
  source = "path/to/terraform-uptime/modules/statuspage"

  name                      = "Service Status"
  slug                      = "status"
  allow_subscriptions_email = true

  # API-managed status pages render with the INSPIRE theme, so branding uses the
  # `_inspire` attributes. The legacy `custom_css` and `custom_*_html` have no effect here.
  custom_css_inspire = ".banner { font-weight: 600; }"

  components = {
    website = {
      name           = "Website"
      service_id     = 12345
      sorting_weight = 10
    }
  }
}
```

<!-- BEGIN_TF_DOCS -->


## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.10.3 |
| <a name="requirement_uptime"></a> [uptime](#requirement\_uptime) | >= 3.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_uptime"></a> [uptime](#provider\_uptime) | >= 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [uptime_statuspage.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/statuspage) | resource |
| [uptime_statuspage_component.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/statuspage_component) | resource |
| [uptime_statuspage_incident.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/statuspage_incident) | resource |
| [uptime_statuspage_metric.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/statuspage_metric) | resource |
| [uptime_statuspage_subscriber.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/statuspage_subscriber) | resource |
| [uptime_statuspage_subscription_domain_allow.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/statuspage_subscription_domain_allow) | resource |
| [uptime_statuspage_subscription_domain_block.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/statuspage_subscription_domain_block) | resource |
| [uptime_statuspage_user.this](https://registry.terraform.io/providers/uptime-com/uptime/latest/docs/resources/statuspage_user) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create"></a> [create](#input\_create) | Create | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Status page name | `string` | n/a | yes |
| <a name="input_allow_drill_down"></a> [allow\_drill\_down](#input\_allow\_drill\_down) | Allow drill down into component details | `bool` | `null` | no |
| <a name="input_allow_pdf_report"></a> [allow\_pdf\_report](#input\_allow\_pdf\_report) | Allow PDF report generation | `bool` | `null` | no |
| <a name="input_allow_search_indexing"></a> [allow\_search\_indexing](#input\_allow\_search\_indexing) | Allow search engine indexing | `bool` | `null` | no |
| <a name="input_allow_subscriptions_email"></a> [allow\_subscriptions\_email](#input\_allow\_subscriptions\_email) | Allow email subscriptions | `bool` | `null` | no |
| <a name="input_allow_subscriptions_rss"></a> [allow\_subscriptions\_rss](#input\_allow\_subscriptions\_rss) | Allow RSS subscriptions | `bool` | `null` | no |
| <a name="input_allow_subscriptions_slack"></a> [allow\_subscriptions\_slack](#input\_allow\_subscriptions\_slack) | Allow Slack subscriptions | `bool` | `null` | no |
| <a name="input_allow_subscriptions_sms"></a> [allow\_subscriptions\_sms](#input\_allow\_subscriptions\_sms) | Allow SMS subscriptions | `bool` | `null` | no |
| <a name="input_allow_subscriptions_webhook"></a> [allow\_subscriptions\_webhook](#input\_allow\_subscriptions\_webhook) | Allow webhook subscriptions | `bool` | `null` | no |
| <a name="input_auth_password"></a> [auth\_password](#input\_auth\_password) | Authentication password | `string` | `null` | no |
| <a name="input_auth_username"></a> [auth\_username](#input\_auth\_username) | Authentication username | `string` | `null` | no |
| <a name="input_cname"></a> [cname](#input\_cname) | Custom CNAME for the status page | `string` | `null` | no |
| <a name="input_company_website_url"></a> [company\_website\_url](#input\_company\_website\_url) | Company website URL | `string` | `null` | no |
| <a name="input_contact_email"></a> [contact\_email](#input\_contact\_email) | Contact email address | `string` | `null` | no |
| <a name="input_custom_css"></a> [custom\_css](#input\_custom\_css) | Custom CSS rendered only under the LEGACY theme. API-managed status pages use the INSPIRE theme, so prefer `custom_css_inspire`. | `string` | `null` | no |
| <a name="input_custom_css_inspire"></a> [custom\_css\_inspire](#input\_custom\_css\_inspire) | Custom CSS rendered under the INSPIRE theme, the theme used by all API-managed status pages | `string` | `null` | no |
| <a name="input_custom_footer_html"></a> [custom\_footer\_html](#input\_custom\_footer\_html) | Custom footer HTML rendered only under the LEGACY theme. API-managed status pages use the INSPIRE theme, so prefer `custom_footer_html_inspire`. | `string` | `null` | no |
| <a name="input_custom_footer_html_inspire"></a> [custom\_footer\_html\_inspire](#input\_custom\_footer\_html\_inspire) | Custom footer HTML rendered under the INSPIRE theme, the theme used by all API-managed status pages | `string` | `null` | no |
| <a name="input_custom_header_bg_color_hex"></a> [custom\_header\_bg\_color\_hex](#input\_custom\_header\_bg\_color\_hex) | Custom header background color hex | `string` | `null` | no |
| <a name="input_custom_header_html"></a> [custom\_header\_html](#input\_custom\_header\_html) | Custom header HTML rendered only under the LEGACY theme. API-managed status pages use the INSPIRE theme, so prefer `custom_header_html_inspire`. | `string` | `null` | no |
| <a name="input_custom_header_html_inspire"></a> [custom\_header\_html\_inspire](#input\_custom\_header\_html\_inspire) | Custom header HTML rendered under the INSPIRE theme, the theme used by all API-managed status pages | `string` | `null` | no |
| <a name="input_custom_header_text_color_hex"></a> [custom\_header\_text\_color\_hex](#input\_custom\_header\_text\_color\_hex) | Custom header text color hex | `string` | `null` | no |
| <a name="input_default_history_date_range"></a> [default\_history\_date\_range](#input\_default\_history\_date\_range) | Default history date range in days | `number` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | Status page description | `string` | `null` | no |
| <a name="input_email_from"></a> [email\_from](#input\_email\_from) | Email from address | `string` | `null` | no |
| <a name="input_email_reply_to"></a> [email\_reply\_to](#input\_email\_reply\_to) | Email reply-to address | `string` | `null` | no |
| <a name="input_google_analytics_code"></a> [google\_analytics\_code](#input\_google\_analytics\_code) | Google Analytics tracking code | `string` | `null` | no |
| <a name="input_hide_empty_tabs_history"></a> [hide\_empty\_tabs\_history](#input\_hide\_empty\_tabs\_history) | Hide empty tabs in history | `bool` | `null` | no |
| <a name="input_max_visible_component_days"></a> [max\_visible\_component\_days](#input\_max\_visible\_component\_days) | Maximum visible component days on date picker | `number` | `null` | no |
| <a name="input_page_type"></a> [page\_type](#input\_page\_type) | Page type | `string` | `null` | no |
| <a name="input_show_active_incidents"></a> [show\_active\_incidents](#input\_show\_active\_incidents) | Show active incidents | `bool` | `null` | no |
| <a name="input_show_component_history"></a> [show\_component\_history](#input\_show\_component\_history) | Show component history | `bool` | `null` | no |
| <a name="input_show_component_response_time"></a> [show\_component\_response\_time](#input\_show\_component\_response\_time) | Show component response time | `bool` | `null` | no |
| <a name="input_show_history_snake"></a> [show\_history\_snake](#input\_show\_history\_snake) | Show history snake visualization | `bool` | `null` | no |
| <a name="input_show_history_tab"></a> [show\_history\_tab](#input\_show\_history\_tab) | Show history tab | `bool` | `null` | no |
| <a name="input_show_past_incidents"></a> [show\_past\_incidents](#input\_show\_past\_incidents) | Show past incidents | `bool` | `null` | no |
| <a name="input_show_status_tab"></a> [show\_status\_tab](#input\_show\_status\_tab) | Show status tab | `bool` | `null` | no |
| <a name="input_show_summary_metrics"></a> [show\_summary\_metrics](#input\_show\_summary\_metrics) | Show summary metrics | `bool` | `null` | no |
| <a name="input_slug"></a> [slug](#input\_slug) | URL slug for the status page | `string` | `null` | no |
| <a name="input_theme"></a> [theme](#input\_theme) | Status page theme | `string` | `null` | no |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | Timezone | `string` | `null` | no |
| <a name="input_uptime_calculation_type"></a> [uptime\_calculation\_type](#input\_uptime\_calculation\_type) | Uptime calculation type | `string` | `null` | no |
| <a name="input_visibility_level"></a> [visibility\_level](#input\_visibility\_level) | Status page visibility level | `string` | `null` | no |
| <a name="input_components"></a> [components](#input\_components) | Status page components | `any` | `{}` | no |
| <a name="input_incidents"></a> [incidents](#input\_incidents) | Status page incidents | `any` | `{}` | no |
| <a name="input_metrics"></a> [metrics](#input\_metrics) | Status page metrics | `any` | `{}` | no |
| <a name="input_subscribers"></a> [subscribers](#input\_subscribers) | Status page subscribers | `any` | `{}` | no |
| <a name="input_subscription_domain_allows"></a> [subscription\_domain\_allows](#input\_subscription\_domain\_allows) | Allowed subscription domains | `any` | `{}` | no |
| <a name="input_subscription_domain_blocks"></a> [subscription\_domain\_blocks](#input\_subscription\_domain\_blocks) | Blocked subscription domains | `any` | `{}` | no |
| <a name="input_users"></a> [users](#input\_users) | Status page users | `any` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_id"></a> [id](#output\_id) | The ID of the status page |
| <a name="output_name"></a> [name](#output\_name) | The status page name |
| <a name="output_url"></a> [url](#output\_url) | The API URL of the status page |
| <a name="output_slug"></a> [slug](#output\_slug) | The URL slug of the status page |
| <a name="output_component"></a> [component](#output\_component) | Map of status page component outputs |
| <a name="output_incident"></a> [incident](#output\_incident) | Map of status page incident outputs |
| <a name="output_metric"></a> [metric](#output\_metric) | Map of status page metric outputs |
| <a name="output_subscriber"></a> [subscriber](#output\_subscriber) | Map of status page subscriber outputs |
| <a name="output_user"></a> [user](#output\_user) | Map of status page user outputs |
<!-- END_TF_DOCS -->
