# Create the container responsible to manage non-GCP entities
resource "google_iam_workload_identity_pool" "github_pool" {
  project                   = var.project
  workload_identity_pool_id = var.workload_identity_pool_id
  display_name              = var.display_name
  description               = var.description
}

# Configure the WIP
resource "google_iam_workload_identity_pool_provider" "github" {
  project = var.project

  # Gives access to the GitHub provider
  workload_identity_pool_id          = google_iam_workload_identity_pool.github_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-provider"

  # Maps GitHub OIDC token claims to GCP attributes
  attribute_mapping = {
    "attribute.aud"              = "assertion.aud"
    "google.subject"             = "assertion.sub"
    "attribute.sub"              = "assertion.sub"
    "attribute.actor"            = "assertion.actor"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
    "attribute.ref"              = "assertion.ref"
  }

  # Declares to use the OIDC method and points to the GitHub Actions token
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }

  # Condition to restrict access to specific repository
  attribute_condition = "assertion.repository == \"${var.github_username}/${var.github_repo_name}\""
}

# Create a service account dedicated for GitHub Workflows
resource "google_service_account" "github_actions" {
  account_id   = var.service_account_id
  display_name = var.service_account_display_name
  description  = var.service_account_description
}

resource "google_service_account_iam_member" "workload_identity_user" {
  service_account_id = google_service_account.github_actions.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_pool.name}/attribute.repository/${var.github_username}/${var.github_repo_name}"
}

resource "google_project_iam_member" "additional_roles" {
  for_each = toset(var.iam_roles)

  project = var.project
  role    = each.value
  member  = "serviceAccount:${google_service_account.github_actions.email}"
}