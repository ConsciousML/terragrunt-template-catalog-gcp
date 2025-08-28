# Terragrunt Template Catalog for GCP

A Terragrunt Template Catalog for production Infrastructure as Code (IaC) on Google Cloud Platform (GCP).

## Catalog vs Live Infrastructure

This is a **catalog repository**, a collection of reusable IaC components.

This IaC production toolkit follows [Gruntwork's official patterns](https://github.com/gruntwork-io/terragrunt-infrastructure-catalog-example) by using two template repositories:
- **This repository** (catalog): Build a collection of reusable [modules](./modules), [units](./units/), and [stacks](./stacks/)
- **Live repository**: Reference these components in your the [infrastructure-live repository](https://github.com/ConsciousML/terragrunt-template-live-gcp) to deploy them in a multi-environment ecosystem with production CI/CD

## What's Inside

The catalog follows a layered architecture where each layer builds upon the previous one:

```
Modules (modules/) → Units (units/) → Stacks (stacks/) → Examples (examples/)
```

- **[Modules](modules/README.md)**: Reusable Terraform modules that declare GCP resources (VPC, databases, compute instances, etc.)
- **[Units](units/README.md)**: Terragrunt wrappers around modules that add configuration and dependencies
- **[Stacks](stacks/README.md)**: Collections of units arranged in dependency graphs for pattern level re-use
- **[Examples](examples/README.md)**: Simple configuration for testing and development
- **[Bootstrap](bootstrap/README.md)**: GitHub Actions GCP authentication setup
- **[CI/CD](docs/continuous-integration.md)**: Automated validation and testing workflows

## Getting Started

### Fork the Repository
First, you'll need to fork this repository and make a few changes:
1. Click on `Use this template` to create your own repository
2. Use your IDE of choice to replace every occurrence of `github.com/ConsciousML/terragrunt-template-catalog-gcp` and `git::git@github.com:ConsciousML/terragrunt-template-catalog-gcp.git` by your GitHub repo URL following the same format
3. In `examples/` change `region.hcl` and `project.hcl` to match your GCP settings

### Installation

**Option 1: Use mise (recommended)**

First install mise by following their [getting started guide](https://mise.jdx.dev/getting-started.html), then:
```bash
mise install
```

**Option 2: Install Tools Manually**
- [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/)
- [OpenTofu](https://opentofu.org/docs/intro/install/) (or [Terraform](https://developer.hashicorp.com/terraform/install))
- [Go](https://go.dev/doc/install)
- [Python3.13.1](https://www.python.org/downloads/)
- [tflint](https://github.com/terraform-linters/tflint)
- [GitHub CLI](https://github.com/cli/cli#installation)
- [gcloud CLI](https://cloud.google.com/sdk/docs/install)

See [mise.toml](./mise.toml) for specific versions.

### Authenticate with GCP
```bash
gcloud auth application-default login
```

### Deploy an Example Architecture

Deploy a stack that activates GCP APIs, sets up a VPC, and spawns a Compute Engine:

```bash
cd examples/stacks/vpc_gce
terragrunt stack generate
terragrunt stack run apply --backend-bootstrap --non-interactive
```

- Go into the GCP console and check that your resources have been created
- Then cleanup by destroying the infrastructure:

```bash
cd examples/stacks/vpc_gce
terragrunt stack generate
terragrunt stack run destroy --non-interactive
```

**Caution**: This workflow is for development and testing. Reference your catalog components in the [infrastructure-live repository](https://github.com/ConsciousML/terragrunt-template-live-gcp) for multi-environment IaC, and production CI/CD.

## Development Workflow

1. Create a feature branch
2. Write/modify modules, units, and stacks
3. Test locally using examples
4. Create pull request
5. Merge when CI passes

See the [development guide](docs/development.md) for a detailed workflow with a step-by-step example on how to modify this template.

## Continuous Integration (CI)

After creating your repository from this template, run the [bootstrap process](bootstrap/README.md) once to configure GitHub Actions authentication with GCP.

The CI provides automated checks and testing:
1. Create a branch and make changes
2. Open a pull request to trigger code quality checks
3. Add the `run-terratest` label for full infrastructure testing
4. Merge when all checks pass

Read more in our [CI workflow guide](docs/continuous-integration.md).

### Infrastructure Testing

The `run-terratest` label triggers automated infrastructure tests that deploy real GCP resources, validate functionality, and clean up automatically.

See the [testing guide](tests/README.md) for writing custom tests.

### Pre-commit Setup (recommended)
```bash
pre-commit install
```

This runs the same checks as CI locally, catching issues before you push.

## License
This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.
