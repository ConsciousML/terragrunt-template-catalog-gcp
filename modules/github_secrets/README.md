<!-- BEGIN_TF_DOCS -->
# GitHub Secrets Module

This module creates GitHub Actions secrets required to authenticate GitHub Actions with GCP: WIF\_PROVIDER, WIF\_SERVICE\_ACCOUNT, and PROJECT\_ID.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.1 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 6.6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | ~> 6.6.0 |

## Resources

| Name | Type |
|------|------|
| [github_actions_secret.project_id](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret) | resource |
| [github_actions_secret.wif_provider](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret) | resource |
| [github_actions_secret.wif_service_account](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_github_repo_name"></a> [github\_repo\_name](#input\_github\_repo\_name) | GitHub repository name where secrets will be stored | `string` | n/a | yes |
| <a name="input_github_token"></a> [github\_token](#input\_github\_token) | GitHub personal access token with 'repo' permissions. Required to create and manage GitHub Actions secrets | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Google Cloud project ID where the Workload Identity Federation is configured | `string` | n/a | yes |
| <a name="input_wif_provider"></a> [wif\_provider](#input\_wif\_provider) | Workload Identity Federation provider resource name (e.g., 'projects/PROJECT\_NUM/locations/global/workloadIdentityPools/POOL\_ID/providers/PROVIDER\_ID') | `string` | n/a | yes |
| <a name="input_wif_service_account"></a> [wif\_service\_account](#input\_wif\_service\_account) | Email address of the service account configured for Workload Identity Federation (e.g., 'service-account@PROJECT\_ID.iam.gserviceaccount.com') | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secrets_created"></a> [secrets\_created](#output\_secrets\_created) | List of GitHub secrets that were created |
<!-- END_TF_DOCS -->