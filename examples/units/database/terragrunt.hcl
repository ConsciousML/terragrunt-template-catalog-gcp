include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  environment_hcl = find_in_parent_folders("environment.hcl")
  environment     = read_terragrunt_config(local.environment_hcl).locals.environment
}

terraform {
  source = "${get_path_to_repo_root()}//modules/database"
}

dependency "apis" {
  config_path = "../apis"
  skip_outputs = true
}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    network_self_link = "projects/main-project-468812/global/networks/mock-vpc"
  }
   = ["init", "plan", "validate"]
}

inputs = {
  instance_name    = "${local.environment}-${values.instance_name}"
  database_version = values.database_version
  region           = values.region
  backup_location  = values.backup_location
  private_network  = dependency.vpc.outputs.network_self_link
}