terraform {
  # Attribute allowlists reference locals from a validation block (>= 1.9), and OpenTofu below
  # 1.10.3 crashes in `tofu test` on these suites (see CHANGELOG 3.0.0), hence a patch-level floor.
  required_version = ">= 1.10.3"

  required_providers {
    uptime = {
      source  = "uptime-com/uptime"
      version = ">= 3.1"
    }
  }
}
