<!-- BEGIN_TF_DOCS -->
# Workload Identity Federation Module

This module sets up Workload Identity Federation for secure GitHub Actions authentication with GCP.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 6.48 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 6.48 |

## Resources

| Name | Type |
|------|------|
| [google_iam_workload_identity_pool.github_pool](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool) | resource |
| [google_iam_workload_identity_pool_provider.github](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider) | resource |
| [google_project_iam_member.additional_roles](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.github_actions](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_member.workload_identity_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Optional description explaining the purpose of the workload identity pool (max 256 characters) | `string` | n/a | yes |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | Human-readable display name for the workload identity pool (max 32 characters) | `string` | n/a | yes |
| <a name="input_github_repo_name"></a> [github\_repo\_name](#input\_github\_repo\_name) | GitHub repository name that will be granted access through Workload Identity Federation | `string` | n/a | yes |
| <a name="input_github_username"></a> [github\_username](#input\_github\_username) | GitHub username or organization name that will be granted access through Workload Identity Federation | `string` | n/a | yes |
| <a name="input_iam_roles"></a> [iam\_roles](#input\_iam\_roles) | List of additional IAM roles to assign to the service account (e.g., 'roles/compute.admin', 'roles/storage.objectAdmin'). The 'roles/iam.workloadIdentityUser' role is automatically included | `list(string)` | `[]` | no |
| <a name="input_project"></a> [project](#input\_project) | Google Cloud project ID where Workload Identity Federation resources will be created | `string` | n/a | yes |
| <a name="input_service_account_description"></a> [service\_account\_description](#input\_service\_account\_description) | Optional description explaining the purpose of the service account (max 256 characters) | `string` | n/a | yes |
| <a name="input_service_account_display_name"></a> [service\_account\_display\_name](#input\_service\_account\_display\_name) | Human-readable display name for the service account (max 100 characters) | `string` | n/a | yes |
| <a name="input_service_account_id"></a> [service\_account\_id](#input\_service\_account\_id) | Unique identifier for the service account (6-30 characters, lowercase letters, numbers, hyphens only) | `string` | n/a | yes |
| <a name="input_workload_identity_pool_id"></a> [workload\_identity\_pool\_id](#input\_workload\_identity\_pool\_id) | Unique identifier for the workload identity pool (4-32 characters, lowercase letters, numbers, hyphens only) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_project_number"></a> [project\_number](#output\_project\_number) | The project number (needed for some GitHub Actions configurations) |
| <a name="output_service_account_email"></a> [service\_account\_email](#output\_service\_account\_email) | Email address of the service account |
| <a name="output_workload_identity_pool_id"></a> [workload\_identity\_pool\_id](#output\_workload\_identity\_pool\_id) | The workload identity pool ID |
| <a name="output_workload_identity_provider_name"></a> [workload\_identity\_provider\_name](#output\_workload\_identity\_provider\_name) | The full name of the workload identity provider |

## Resource Roles in GitHub Actions Authentication

- **Workload Identity Pool**: Central trust boundary that manages access for external identities (GitHub) to GCP resources
- **Workload Identity Pool Provider**: Establishes the trust relationship between GCP and GitHub's OIDC tokens, mapping GitHub claims to GCP attributes
- **Service Account**: Dedicated identity that GitHub Actions assumes to access GCP services with specific permissions
- **Workload Identity User Role**: Enables the external identity (GitHub repo) to impersonate the service account through the identity pool
- **Project IAM Members**: Grants the service account necessary permissions to perform infrastructure operations in the GCP project
<!-- END_TF_DOCS -->