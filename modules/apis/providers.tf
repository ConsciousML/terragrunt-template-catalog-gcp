terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.48"
    }
  }

  required_version = ">= 1.9.1"
}