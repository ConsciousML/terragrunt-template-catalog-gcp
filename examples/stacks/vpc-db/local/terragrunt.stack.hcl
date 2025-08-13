locals {
  repo_root = get_repo_root()
}

unit "apis" {
  source = "${local.repo_root}/examples/units/apis"
  path   = "apis"
}

unit "vpc" {
  source = "${local.repo_root}/examples/units/vpc"
  path   = "vpc"

  values = {
    network_name = "vpc"
    subnet_name  = "subnet"
    subnet_cidr  = "10.0.0.0/24"
    region       = "europe-west1"
  }
}

unit "database" {
  source = "${local.repo_root}/examples/units/database"
  path   = "database"

  values = {
    instance_name    = "cloudsql-postgres"
    database_version = "POSTGRES_15"
    region           = "europe-west1"
    backup_location  = "europe-west1"
  }
}