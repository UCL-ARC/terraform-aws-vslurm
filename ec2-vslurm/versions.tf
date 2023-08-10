terraform {
  required_version = ">= 1.2.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.11.0"
    }

    local = {
      version = ">= 2.4.0"
    }

    http = {
      version = ">= 3.4.0"
    }

    tls = {
      version = ">= 4.0.4"
    }
  }
}
