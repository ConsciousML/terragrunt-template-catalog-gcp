include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  environment_hcl = find_in_parent_folders("environment.hcl")
  environment     = read_terragrunt_config(local.environment_hcl).locals.environment
}

terraform {
  source = "git::git@github.com:ConsciousML/terragrunt-template-catalog-gcp.git//modules/gce?ref=${values.version}"
}

dependency "apis" {
  config_path  = "../apis"
  skip_outputs = true
}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    network_self_link = "projects/main-project-468812/global/networks/mock-vpc"
    subnet_self_link  = "projects/main-project-468812/regions/mock-region/subnetworks/mock-subnet"
  }
  mock_outputs_allowed_terraform_commands = ["init", "plan", "validate", "destroy"]
}

inputs = {
  instance_name          = "${local.environment}-${values.instance_name}"
  machine_type           = values.machine_type
  zone                   = values.zone
  boot_disk_image        = values.boot_disk_image
  boot_disk_size         = values.boot_disk_size
  boot_disk_type         = values.boot_disk_type
  network                = dependency.vpc.outputs.network_self_link
  subnetwork             = dependency.vpc.outputs.subnet_self_link
  enable_external_ip     = values.enable_external_ip
  metadata               = values.metadata
  tags                   = values.tags
  service_account_email  = values.service_account_email
  service_account_scopes = values.service_account_scopes
}