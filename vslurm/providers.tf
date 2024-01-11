terraform {
  required_version = ">= 1.5"

  required_providers {
    cloudinit = {
      version = ">= 2.3.2"
    }

    local = {
      version = ">= 2.4.0"
    }

    tls = {
      version = ">= 4.0.4"
    }

    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.11.0"
    }

    http = {
      version = ">= 3.4.0"
    }
  }
}
