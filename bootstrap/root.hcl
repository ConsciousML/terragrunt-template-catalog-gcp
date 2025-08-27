locals {
  # Load GCP project ID variable
  project_vars = read_terragrunt_config(find_in_parent_folders("project.hcl"))

  # Load GCP region variable
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Load environment related variables (dev, staging, prod, ...)
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))

  gcp_project = local.project_vars.locals.project
  gcp_region  = local.region_vars.locals.region
  environment = local.environment_vars.locals.environment
}

# Configure GCS backend for storing Terraform state files
remote_state {
  backend = "gcs"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {

    project  = "${local.gcp_project}"
    location = "eu"

    # The bucket name is suffixed using the env name (i.e `dev`, `staging`, ect.)
    # This allows to completely isolate states between environments
    bucket = "${local.gcp_project}-tofu-state-${local.environment}"

    # The state file path within the bucket, based on module's relative path to ensure each module has its own isolated state
    prefix = "${path_relative_to_include()}/tofu.tfstate"
    gcs_bucket_labels = {
      owner = "terragrunt"
      name  = "tofu_state_storage"
    }
  }
}

generate "provider" {
  path      = "providers.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "google" {
  project = "${local.gcp_project}"
  region = "${local.gcp_region}"
}
EOF
}

generate "versions" {
  path      = "versions.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.48"
    }
  }

  required_version = ">= 1.9.1"
}
EOF
}

catalog {
  urls = [
    "https://github.com/ConsciousML/terragrunt-template-catalog-gcp"
  ]
}

# Pass key variables to child configurations
inputs = merge(
  local.project_vars.locals,
  local.region_vars.locals,
  local.environment_vars.locals
)