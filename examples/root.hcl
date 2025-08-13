locals {
  # Automatically load account-level variables
  project_vars = read_terragrunt_config(find_in_parent_folders("project.hcl"))

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Automatically load environment related variables (dev, staging, prod, ...)
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))

  # Extract the variables we need for easy access
  gcp_project = local.project_vars.locals.project
  gcp_region  = local.region_vars.locals.region
  environment = local.environment_vars.locals.environment
}

remote_state {
  backend = "gcs"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {

    project  = "${local.gcp_project}"
    location = "eu"

    bucket = "${local.gcp_project}-tofu-state-${local.environment}"
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

# Pass key variables to child configurationsd
inputs = merge(
  local.project_vars.locals,
  local.region_vars.locals,
  local.environment_vars.locals
)