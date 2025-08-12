module "database" {
  source = "../../../modules/database"

  instance_name    = "test-database-instance"
  tier             = "db-f1-micro"
  database_version = "POSTGRES_15"
  region           = "europe-west1"
  backup_location  = "europe-west1"
}