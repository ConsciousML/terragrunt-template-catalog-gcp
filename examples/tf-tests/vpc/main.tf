module "vpc" {
  source = "../../../modules/vpc"

  network_name = "test-vpc"
  subnet_name  = "test-subnet"
  subnet_cidr  = "10.0.0.0/24"
  region       = "europe-west1"
}