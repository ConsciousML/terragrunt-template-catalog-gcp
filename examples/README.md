# Examples - Development Environment

This directory provides example configurations for testing Terragrunt stacks during development.

## Purpose

This environment is designed for **development and testing only**.

For production deployments, use the [terragrunt-template-live-gcp](https://github.com/ConsciousML/terragrunt-template-live-gcp) repository.

## Configuration Files

The examples directory uses the same configuration pattern as the production template:

- `environment.hcl`: Environment name (e.g., "example-2") used for resource naming and state isolation
- `project.hcl`: GCP project ID where resources will be deployed  
- `region.hcl`: Default GCP region for resources
- `root.hcl`" Root configuration that loads variables, configures GCS backend, and sets up providers

These files automatically provide GCP variables (project, region, environment) to all stacks, eliminating the need to configure them individually.

## Stack Configuration

Stacks in `examples/stacks/` reference the catalog using git links with automatic version inference:

```hcl
stack "vpc_db" {
  source = "github.com/ConsciousML/terragrunt-template-catalog-gcp//stacks/vpc_db?ref=${local.version}"
  # ...
}
```

The `ref` parameter automatically resolves to:
1. PR branch name (in pull requests)
2. Current branch name  
3. Current git branch (local development)
4. "main" (fallback)

This allows testing catalog changes from any branch without manual configuration.

## Getting Started

### Prerequisites
- Follow the [installation instructions](../README.md#installation):
- GCP project with billing enabled
- GCP [IAM permissions](../bootstrap/enable_tg_github_actions/terragrunt.stack.hcl)

### Deploy a Stack
```bash
cd examples/stacks/vpc_db

# Generate Terragrunt configuration  
terragrunt stack generate

terragrunt stack run apply
```

### Destroy a Stack
```bash
cd examples/stacks/vpc_db

terragrunt stack run destroy
```

## Available Example Stacks

- `vpc_db/`: VPC with Cloud SQL PostgreSQL database
- `vpc_gce/`: VPC with Google Compute Engine instance

Each stack includes example values that can be modified for testing different configurations.

## Production Setup

For production environments, use [terragrunt-template-live-gcp](https://github.com/ConsciousML/terragrunt-template-live-gcp) which provides:
- Environment separation (dev/staging/prod)
- Enhanced security configurations  
- Production-ready defaults
- Proper state management across environments