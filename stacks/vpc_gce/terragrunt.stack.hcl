unit "apis" {
  source = "git::git@github.com:ConsciousML/terragrunt-template-catalog-gcp.git//units/apis?ref=${values.version}"
  path   = "apis"

  values = {
    version = values.version
    apis    = values.apis
  }
}

unit "vpc" {
  source = "git::git@github.com:ConsciousML/terragrunt-template-catalog-gcp.git//units/vpc?ref=${values.version}"
  path   = "vpc"

  values = {
    version      = values.version
    network_name = values.network_name
    subnet_name  = values.subnet_name
    subnet_cidr  = values.subnet_cidr
    region       = values.region
  }
}

unit "gce" {
  source = "git::git@github.com:ConsciousML/terragrunt-template-catalog-gcp.git//units/gce?ref=${values.version}"
  path   = "gce"

  values = {
    version                = values.version
    instance_name          = values.instance_name
    machine_type           = values.machine_type
    zone                   = values.zone
    boot_disk_image        = values.boot_disk_image
    boot_disk_size         = values.boot_disk_size
    boot_disk_type         = values.boot_disk_type
    enable_external_ip     = values.enable_external_ip
    metadata               = values.metadata
    tags                   = values.tags
    service_account_email  = values.service_account_email
    service_account_scopes = values.service_account_scopes
  }
}