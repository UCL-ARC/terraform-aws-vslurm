terraform {
  required_version = ">= 1.5"

  required_providers {
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = ">= 2.3.2"
    }

    local = {
      source  = "hashicorp/local"
      version = ">= 2.4.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.4"
    }

    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.31.0"
    }

    http = {
      source  = "hashicorp/http"
      version = ">= 3.4.0"
    }
  }
}
