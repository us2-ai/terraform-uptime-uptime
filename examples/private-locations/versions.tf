terraform {
  required_version = ">= 1.10.3"

  required_providers {
    uptime = {
      source  = "uptime-com/uptime"
      version = "~> 3.0"
    }
  }
}
