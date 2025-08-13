locals {
    gcp_project = "main-project-468812"
    gcp_region = "europe-west-1"
}

remote_state {
  backend = "gcs"
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {

    project = "${local.gcp_project}"
    location = "eu"

    bucket = "tofu-state-catalog-example"
    prefix   = "${path_relative_to_include()}/tofu.tfstate"
    gcs_bucket_labels = {
      owner = "terragrunt"
      name  = "tofu_state_storage"
    }
  }
}

# Configure the GCP provider
generate "provider" {
  path = "provider_google.tf"
  if_exists = "overwrite"
  contents = <<EOF
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> v6.48.0"
    }
  }

  required_version = ">= 1.9.1"
}

provider "google" {
  project = "${local.gcp_project}"
  region = "${local.gcp_region}"
}
EOF
}