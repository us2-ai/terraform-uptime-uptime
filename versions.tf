terraform {
  required_version = ">= 1.6"

  required_providers {
    uptime = {
      source = "uptime-com/uptime"
      # Requires the us2-ai fork build of the provider, which exposes the
      # uptime_private_locations data source and consumes a forked
      # uptime-client-go that surfaces the `is_private` and `country` fields
      # on probe servers. Install the binary via the install-provider action
      # at us2-ai/terraform-provider-uptime; see docs/ci-integration.md in
      # that repository. The pinned version must match the release tag of
      # the forked provider.
      version = "2.26.0-us2.0"
    }
  }
}
