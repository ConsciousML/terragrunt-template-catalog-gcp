locals {
  # Sets the reference of the source code to:
  version = coalesce(
    get_env("GITHUB_HEAD_REF", ""), # PR branch name (only set in PRs)
    get_env("GITHUB_REF_NAME", ""), # Branch/tag name
    try(run_cmd("git", "rev-parse", "--abbrev-ref", "HEAD"), ""),
    "main" # fallback
  )
}

stack "vpc_db" {
  source = "github.com/ConsciousML/terragrunt-template-catalog-gcp//stacks/vpc_db?ref=${local.version}"
  path   = "infrastructure"

  values = {
    version = local.version
    apis = [
      "compute.googleapis.com",
      "servicenetworking.googleapis.com"
    ]
    network_name     = "vpc"
    subnet_name      = "subnet"
    subnet_cidr      = "10.0.0.0/24"
    region           = "europe-west1"
    instance_name    = "cloudsql-postgres"
    database_version = "POSTGRES_15"
    backup_location  = "europe-west1"
  }
}