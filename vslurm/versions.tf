terraform {
  required_version = ">= 1.2.0"

  required_providers {
    local = {
      version = ">= 2.4.0"
    }

    http = {
      version = ">= 3.4.0"
    }

    tls = {
      version = ">= 4.0.4"
    }

    cloudinit = {
      version = ">= 2.3.2"
    }

    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.11.0"
    }
  }
}
