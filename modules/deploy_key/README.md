<!-- BEGIN_TF_DOCS -->
# Deploy Key Module

This module creates SSH deploy keys for GitHub repository access.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.1 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 6.6.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | ~> 6.6.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | ~> 4.1 |

## Resources

| Name | Type |
|------|------|
| [github_actions_secret.deploy_key](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret) | resource |
| [github_repository_deploy_key.deploy_key](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_deploy_key) | resource |
| [tls_private_key.deploy_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_current_repository"></a> [current\_repository](#input\_current\_repository) | GitHub repository name (format: 'repo-name') where the GitHub Actions secrets will be stored | `string` | n/a | yes |
| <a name="input_deploy_key_title"></a> [deploy\_key\_title](#input\_deploy\_key\_title) | Human-readable title for the deploy key as it appears in GitHub repository settings | `string` | `"Terragrunt Deploy Key"` | no |
| <a name="input_github_token"></a> [github\_token](#input\_github\_token) | GitHub personal access token with 'repo' and 'admin:repo\_hook' permissions. Required to create deploy keys and manage repository settings | `string` | n/a | yes |
| <a name="input_repositories"></a> [repositories](#input\_repositories) | List of GitHub repository names (format: 'repo-name') where deploy keys will be added for secure access | `list(string)` | n/a | yes |
| <a name="input_secret_names"></a> [secret\_names](#input\_secret\_names) | List of GitHub Actions secret names for storing private keys. Must correspond 1:1 with the repositories list (same order) | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_deploy_key_ids"></a> [deploy\_key\_ids](#output\_deploy\_key\_ids) | Map of repository names to deploy key IDs |
| <a name="output_public_keys"></a> [public\_keys](#output\_public\_keys) | Map of repository names to public keys |
| <a name="output_secret_names"></a> [secret\_names](#output\_secret\_names) | List of secret names created for each repository |
<!-- END_TF_DOCS -->