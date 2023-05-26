
#- Required Providers & Terraform Version
#

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.60.0"
    }
    null = {
      version = "~> 3.2.1"
    }
  }

  required_version = ">= 1.4.1"
}
