# Maintenance & Cloud Status Example

This example demonstrates the resources added in v1.2.0:

- a `cloudstatus` check that monitors a public cloud provider's status group,
- account-level **maintenance schedules** — a recurring RRULE window and a one-off window, and
- **maintenance notifications** that alert a contact group before and after a window.

It requires the `uptime-com/uptime` provider `>= 2.28`.
