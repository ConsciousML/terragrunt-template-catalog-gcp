# The environment where to deploy the infrastructure, i.e `dev`, `staging`, ect.
# The env name will prefix the GCS bucket name storing the tfstates
# as well as some resource variables to avoid collision
locals {
  environment = "example-2"
}
