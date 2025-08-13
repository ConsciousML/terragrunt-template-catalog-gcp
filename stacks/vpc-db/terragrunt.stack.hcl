unit "apis" {
  source = "git::git@github.com:ConsciousML/terragrunt-template-catalog-gcp.git//units/apis?ref=first-gcp-resources"
  path   = "apis"
}

unit "vpc" {
  source = "git::git@github.com:ConsciousML/terragrunt-template-catalog-gcp.git//units/vpc?ref=first-gcp-resources"
  path   = "vpc"
  
  values = {
    network_name = values.network_name
    subnet_name  = values.subnet_name
    subnet_cidr  = values.subnet_cidr
    region       = values.region
  }
}

unit "database" {
  source = "git::git@github.com:ConsciousML/terragrunt-template-catalog-gcp.git//units/database?ref=first-gcp-resources"
  path   = "database"
  
  values = {
    instance_name    = values.instance_name
    database_version = values.database_version
    region           = values.region
    backup_location  = values.backup_location
  }
}