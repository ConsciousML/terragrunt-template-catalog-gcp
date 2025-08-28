# Terragrunt Template Catalog for GCP

A Terragrunt Template Catalog for production Infrastructure as Code (IaC) on Google Cloud Platform (GCP).

## Catalog vs Live Infrastructure

This is a **catalog repository**, a collection of reusable IaC components.

This IaC production toolkit follows [Gruntwork's official patterns](https://github.com/gruntwork-io/terragrunt-infrastructure-catalog-example) by using two template repositories:
- **This repository** (catalog): Build a collection of reusable [modules](./modules), [units](./units/), and [stacks](./stacks/)
- **Live repository**: Reference these components in your the [infrastructure-live repository](https://github.com/ConsciousML/terragrunt-template-live-gcp) to deploy them in a multi-environment ecosystem with production CI/CD

## What's Inside
- **[Modules](modules/README.md)**: Reusable Terraform modules that declare GCP resources (VPC, databases, compute instances)
- **[Units](units/README.md)**: Terragrunt wrappers around modules that add configuration and dependencies
- **[Stacks](stacks/README.md)**: Collections of units arranged in dependency graphs for complete environments
- **[Examples](examples/README.md)**: Simple configuration for testing and development

## Getting Started

### Preliminaries
First, you'll need to fork this repository and make a few changes:
1. Click on `Use this template` to create your own repository
2. Use your IDE of choice to replace every occurrence of `github.com/ConsciousML/terragrunt-template-catalog-gcp` and `git::git@github.com:ConsciousML/terragrunt-template-catalog-gcp.git` by your GitHub repo URL following the same format
3. In `examples/` change `region.hcl` and `project.hcl` to match your GCP settings

### Installation

### Option 1: Use mise (recommended)
Install mise by following their [getting started](https://mise.jdx.dev/getting-started.html). 

Then use it to install all the dependencies automatically:
```bash
mise install
```

### Option 2: Install tools manually
- [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/)
- [OpenTofu](https://opentofu.org/docs/intro/install/) (or [Terraform](https://developer.hashicorp.com/terraform/install))
- [Go](https://go.dev/doc/install)
- [Python3.13.1](https://www.python.org/downloads/)
- [tflint](https://github.com/terraform-linters/tflint)
- [GitHub CLI](https://github.com/cli/cli#installation)
- [gcloud CLI](https://cloud.google.com/sdk/docs/install)

See [mise.toml](./mise.toml) for specific versions.

### Authenticate with GCP:
```bash
gcloud auth application-default login
```

### TODO

### Run

Try the example VPC with Compute Engine stack:

```bash
cd examples/stacks/vpc_gce
terragrunt stack generate
terragrunt stack run apply --backend-bootstrap --non-interactive
```

- Go into the GCP console and check that your resources have been created
- To destroy:

```bash
cd examples/stacks/vpc_gce
terragrunt stack generate
terragrunt stack run destroy --non-interactive
```

## Architecture Overview

The catalog follows a layered architecture where each layer builds upon the previous one:

```
Examples (examples/) → Reference Stacks (stacks/) → Units (units/) → Modules (modules/)
```

**Modules** declare Terraform resources for GCP services like networking, compute, and databases. Each module handles a specific infrastructure concern with well-defined inputs and outputs.

**Units** wrap modules with Terragrunt configuration, adding environment-specific settings and dependency management. They serve as the building blocks for larger infrastructure deployments.

**Stacks** compose multiple units into complete environments using dependency graphs. For example, the `vpc_gce` stack combines VPC networking with compute instances, ensuring proper deployment ordering.

**Examples** provide ready-to-deploy configurations that demonstrate how to use stacks in practice, serving as both documentation and testing environments.

## Development Workflow

### Local Development
Use the [examples directory](examples/README.md) to test infrastructure changes locally before committing. The examples automatically reference your current branch, allowing you to validate modifications without manual configuration.

### Quality Assurance
Every pull request automatically runs [continuous integration checks](docs/continuous-integration.md) including:
- Code formatting and linting
- Security scanning
- Terragrunt validation
- Infrastructure planning

### Infrastructure Testing
Add the `run-terratest` label to your pull request to trigger [automated infrastructure testing](tests/README.md). This deploys actual resources, validates functionality, and cleans up automatically.

### Pre-commit Setup (Recommended)
```bash
pre-commit install
```

This runs the same checks as CI locally, catching issues before you push.

## CI/CD Integration

### Initial Setup
After creating your repository from this template, run the [bootstrap process](bootstrap/README.md) once to configure GitHub Actions authentication with GCP. This enables:

- Workload Identity Federation for secure, keyless authentication
- Deploy key management for private repository access
- Automated secret management for CI workflows

### Using the CI
The [CI workflow](docs/continuous-integration.md) provides automated validation:
1. Create a branch and make changes
2. Open a pull request to trigger code quality checks
3. Add `run-terratest` label for full infrastructure testing
4. Merge when all checks pass

## Available Infrastructure Components

### Networking
- **VPC** - Virtual Private Cloud with customizable subnets and firewall rules

### Compute
- **GCE** - Google Compute Engine instances with configurable machine types and networking

### Storage
- **Database** - Cloud SQL PostgreSQL with high availability options

### DevOps
- **APIs** - GCP service enablement for project setup
- **GitHub Integration** - Workload Identity Federation and deploy key management

## Production Usage

This catalog is designed for development and testing. For production deployments, consider using [terragrunt-template-live-gcp](https://github.com/ConsciousML/terragrunt-template-live-gcp) which provides:
- Environment separation (dev/staging/prod)
- Enhanced security configurations
- Production-ready defaults
- Cross-environment state management

## Contributing

We welcome contributions! When adding new modules or stacks:
1. Follow the existing architectural patterns
2. Include comprehensive examples
3. Add Terratest coverage
4. Update relevant documentation
5. Ensure CI passes before merging

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.
