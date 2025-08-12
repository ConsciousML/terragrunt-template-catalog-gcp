terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }

  required_version = ">= 1.9.1"
}

provider "google" {
  project = "main-project-468812"
  region  = "europe-west1"
}