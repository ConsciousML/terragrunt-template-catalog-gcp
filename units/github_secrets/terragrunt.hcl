include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::git@github.com:ConsciousML/terragrunt-template-catalog-gcp.git//modules/github_secrets/?ref=${values.version}"
}

dependency "workload_identity_federation" {
  config_path = "../workload_identity_federation"
  mock_outputs = {
    workload_identity_provider_name = "projects/123456789/locations/global/workloadIdentityPools/mock-pool/providers/mock-provider"
    service_account_email           = "mock-service-account@mock-project.iam.gserviceaccount.com"
    project_number                  = "mock-project-123456"
  }
  mock_outputs_allowed_terraform_commands = ["init", "plan", "validate", "destroy"]
}

inputs = {
  github_token        = values.github_token
  github_repo_name    = values.github_repo_name
  wif_provider        = dependency.workload_identity_federation.outputs.workload_identity_provider_name
  wif_service_account = dependency.workload_identity_federation.outputs.service_account_email
  project_id          = dependency.workload_identity_federation.outputs.project_number
}