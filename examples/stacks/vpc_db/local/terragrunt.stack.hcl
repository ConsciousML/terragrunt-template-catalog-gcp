locals {
  repo_root = get_repo_root()

  version = coalesce(
    get_env("GITHUB_HEAD_REF", ""), # PR branch name (only set in PRs)
    get_env("GITHUB_REF_NAME", ""), # Branch/tag name
    try(run_cmd("git", "rev-parse", "--abbrev-ref", "HEAD"), ""),
    "main" # fallback
  )
}

unit "apis" {
  source = "${local.repo_root}/examples/units/apis"
  path   = "apis"

  values = {
    version = local.version
  }
}

unit "vpc" {
  source = "${local.repo_root}/examples/units/vpc"
  path   = "vpc"

  values = {
    version      = local.version
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
    version          = local.version
    instance_name    = "cloudsql-postgres"
    database_version = "POSTGRES_15"
    region           = "europe-west1"
    backup_location  = "europe-west1"
  }
}