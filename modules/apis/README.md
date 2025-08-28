<!-- BEGIN_TF_DOCS -->
# APIs Module

This module enables Google Cloud APIs for a GCP project.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.1 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 6.48 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 6.48 |

## Resources

| Name | Type |
|------|------|
| [google_project_service.wif_required_apis](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apis"></a> [apis](#input\_apis) | List of Google Cloud API service names to enable (e.g., 'compute.googleapis.com', 'storage.googleapis.com', 'cloudsql.googleapis.com') | `list(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->