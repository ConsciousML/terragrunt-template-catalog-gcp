unit "apis" {
  source = "git::git@github.com:ConsciousML/terragrunt-template-catalog-gcp.git//units/apis?ref=${values.version}"
  path   = "apis"

  values = {
    version = values.version
  }
}

unit "vpc" {
  source = "git::git@github.com:ConsciousML/terragrunt-template-catalog-gcp.git//units/vpc?ref=${values.version}"
  path   = "vpc"
  
  values = {
    version = values.version
    network_name = values.network_name
    subnet_name  = values.subnet_name
    subnet_cidr  = values.subnet_cidr
    region       = values.region
  }
}

unit "database" {
  source = "git::git@github.com:ConsciousML/terragrunt-template-catalog-gcp.git//units/database?ref=${values.version}"
  path   = "database"
  
  values = {
    version = values.version
    instance_name    = values.instance_name
    database_version = values.database_version
    region           = values.region
    backup_location  = values.backup_location
  }
}