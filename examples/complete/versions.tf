terraform {
  required_version = ">= 1.9"

  required_providers {
    uptime = {
      source  = "uptime-com/uptime"
      version = "~> 2.34"
    }
  }
}
