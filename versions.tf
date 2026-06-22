terraform {
  required_version = ">= 1.6"

  required_providers {
    uptime = {
      source  = "uptime-com/uptime"
      version = ">= 2.28"
    }
  }
}
