# Warning: to test a stack on a branch, remember to change `ref=main` to `ref=YOUR_BRANCH`
# and `version = YOUR_BRANCH`
stack "vpc-db" {
  source = "github.com/ConsciousML/terragrunt-template-catalog-gcp//stacks/vpc-db?ref=main"
  path   = "infrastructure"

  values = {
    version          = "main"
    network_name     = "vpc"
    subnet_name      = "subnet"
    subnet_cidr      = "10.0.0.0/24"
    region           = "europe-west1"
    instance_name    = "cloudsql-postgres"
    database_version = "POSTGRES_15"
    backup_location  = "europe-west1"
  }
}