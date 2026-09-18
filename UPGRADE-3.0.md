# Upgrade from 2.x to 3.0

Module 3.0.0 requires the `uptime-com/uptime` provider `>= 3.0`, and provider 3.0.0 removed the
`uptime_check_maintenance` resource. Uptime.com is shutting off the per-check maintenance endpoint
that resource used on 2026-09-28, and the provider's changelog is explicit that nothing else in
the API takes its place: maintenance windows are now account-level schedules that target checks by
ID or by tag.

That resource was the whole of this module's `maintenance` submodule. The submodule, the root
`maintenances` collection, the root `maintenance` output, and the wrapper's `maintenances`
attribute are gone in 3.0.0. `maintenance_schedules` and `maintenance_notifications`, in the module
since 1.2.0, are the replacement.

If you never set `maintenances`, the upgrade is a version bump. Skip to [step 2](#step-2-upgrade).

## Why the order matters

Provider 3.0.0 has no schema for `uptime_check_maintenance`. Terraform needs a resource's schema to
decode its state entry, so if a check maintenance window is still in state when you run
`terraform plan` against 3.0.0, the plan fails with "does not support resource type" and keeps
failing until the entry is gone. This module cannot do that removal for you: a `removed` block
needs the same missing schema. So each window has to leave state while you are still on module
2.x and provider 2.34, and only then can the versions move.

## What changed

| 2.x | 3.0 |
| --- | --- |
| `maintenances` collection | Removed. Still declared, but any non-empty value fails validation with a pointer here. Removed for good in 4.0.0. |
| `module "maintenance"` output `maintenance` | Removed |
| `modules/maintenance` submodule | Removed |
| Wrapper `items.*.maintenances` and `defaults.maintenances` | Removed from the allowlists, so setting either fails validation |
| Statuspage `allow_subscriptions` | Removed. It was retained in 2.0.0 only to fail with a message; now it fails the `statuspages` allowlist check instead. The value has been inert since provider 2.25.0. |
| Provider floor | `>= 2.34` becomes `>= 3.0` in every `versions.tf` |
| Terraform/OpenTofu floor | `>= 1.9` becomes `>= 1.10.3`. OpenTofu 1.9.0 through 1.10.2 crash in `tofu test` on this module; see the 3.0.0 changelog entry. |

## Before you start

Stay on module 2.1.0 (any 2.x works) and provider 2.34.x for step 1. Run `terraform plan` first
and make sure it is clean, so that the only changes in the next steps are the ones described here.

Check the engine version too. Module 3.0.0 requires Terraform or OpenTofu 1.10.3 or newer, and
`terraform init` in step 2 refuses an older one with "Unsupported Terraform Core version". Upgrade
the engine before step 2 if needed; it has no effect on steps 1 or 3.

List the windows in state:

```bash
terraform state list | grep uptime_check_maintenance
```

Each one has this address, where `uptime` is whatever you named the module call and `weekly` is
the key in your `maintenances` map:

```
module.uptime.module.maintenance["weekly"].uptime_check_maintenance.this[0]
```

Through the wrapper, the item key comes first:

```
module.wrapper["service-a"].module.maintenance["weekly"].uptime_check_maintenance.this[0]
```

Note each window's key, its `check_id`, and its `schedule` and `state` values. You need them in
step 3.

## Step 1: end or keep each window, on 2.x

Decide per window.

**To end a window**, delete its entry from `maintenances` and apply. Deleting the resource sets
the check's maintenance state back to `ACTIVE`, which ends the window server-side. The window is
gone from Uptime.com as well as from Terraform.

**To keep a window**, delete its entry from `maintenances` and remove it from state instead of
applying:

```bash
terraform state rm 'module.uptime.module.maintenance["weekly"].uptime_check_maintenance.this[0]'
```

The window survives untouched on the Uptime.com side. Terraform just stops tracking it.

When every entry is gone, `maintenances` is `{}` or absent. Remove the `maintenance` output from
your own outputs if you exposed it, and remove `allow_subscriptions` from any status page. Run
`terraform plan` again. It should show no changes.

## Step 2: upgrade

Move the module reference to `v3.0.0` and the provider constraint to `~> 3.0`, then:

```bash
terraform init -upgrade
```

```bash
terraform plan
```

Expect no changes. Two errors are possible here and both mean step 1 was incomplete:

- `var.maintenances is no longer supported` is the module's own check. An entry is still in
  configuration.
- `does not support resource type "uptime_check_maintenance"` comes from the provider. An entry is
  still in state. Go back to provider 2.34 (`terraform init -upgrade` after restoring the old
  constraint) and finish step 1.

## Step 3: re-adopt the windows you kept

The API already stores every window written through the old endpoint as a maintenance schedule.
The conversion happened server-side; nothing you kept was lost. Each old window became one of
three schedule types:

| Old `schedule.type` or `state` | New `schedule_type` |
| --- | --- |
| `WEEKLY`, `MONTHLY` | `RRULE` |
| `ONCE` | `ONE_OFF` |
| `state = "SUPPRESSED"` | `MANUAL`, open-ended |

Field for field:

| Old field | New field |
| --- | --- |
| `weekdays` (integers, 0 is Sunday) | `BYDAY` names inside `rrule`, for example `FREQ=WEEKLY;BYDAY=SU` |
| `from_time`, `to_time` | `starts_at` (RFC 3339) and `duration_minutes` |
| `once_start_date`, `once_end_date` | `starts_at`, `ends_at` |
| `pause_on_scheduled_maintenance` | `pause_checks_during_maintenance` |
| `check_id` | one entry in `services` |

List the schedules so you have each one's ID and its converted values. The endpoint is
`GET /api/v1/maintenance/schedules/` on your account's API host, authenticated with your API token;
the [Uptime.com API reference](https://uptime.com/api/v1/docs/) covers the request. Match each
schedule to a window by its target check and time.

Declare each `RRULE` or `ONE_OFF` schedule in `maintenance_schedules`, and add an `import` block
in your root configuration pointing at the module's resource address with that schedule ID:

```hcl
module "uptime" {
  # ...
  maintenance_schedules = {
    weekly = {
      schedule_type                   = "RRULE"
      starts_at                       = "2026-10-04T02:00:00Z"
      rrule                           = "FREQ=WEEKLY;BYDAY=SU"
      duration_minutes                = 120
      pause_checks_during_maintenance = true
      services                        = [module.uptime.check["homepage"].id]
    }
  }
}

import {
  to = module.uptime.module.maintenance_schedule["weekly"].uptime_maintenance_schedule.this[0]
  id = "123"
}
```

`terraform plan` shows the import and, if your declared values differ from what the API stored, an
in-place update alongside it. Read that diff: it is the only place the conversion's exact
`starts_at` and `rrule` are visible before you overwrite them. Adjust the configuration until the
plan is an import with no changes, or accept the update knowingly, then apply. Delete the `import`
block afterwards; it is a one-time instruction.

Notifications for a schedule go in `maintenance_notifications`, keyed by
`module.uptime.maintenance_schedule["weekly"].id`. The old resource had none, so there is nothing
to import there.

**`MANUAL` schedules cannot be managed by the provider**, which supports only `RRULE` and
`ONE_OFF`. A check that was `SUPPRESSED` before the upgrade stays suppressed indefinitely with
nothing in Terraform pointing at it. End that suppression in the Uptime.com UI or through the API,
or replace it with a bounded `ONE_OFF` schedule, so that the check is not silently muted forever.

## Checklist

1. On module 2.x and provider 2.34, `terraform plan` is clean.
2. Every `maintenances` entry is removed from configuration, and each window is either applied away
   or removed from state with `terraform state rm`.
3. `allow_subscriptions` is removed from every status page.
4. Terraform or OpenTofu is 1.10.3 or newer. Module reference at `v3.0.0`, provider at `~> 3.0`,
   `terraform init -upgrade`, plan shows no changes.
5. Kept windows are declared in `maintenance_schedules` and imported by schedule ID.
6. Any `MANUAL` schedule left behind by a `SUPPRESSED` check is ended or replaced.
