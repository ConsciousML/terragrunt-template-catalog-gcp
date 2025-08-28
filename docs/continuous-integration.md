# Continuous Integration (CI)

## Overview

The [CI](../.github/workflows/ci.yaml) automatically validates Terragrunt configurations and runs [Terratest](https://terratest.gruntwork.io/docs/) on every pull request.

It ensures code quality and that the infrastructure can be deployed an destroyed correctly before merging changes.

## How It Works

The [CI](../.github/workflows/ci.yaml) consists of three main jobs:

### 1. Code Quality Checks
Runs automatically on every PR:
- **Format validation**: Ensures Terragrunt (TG) and Terraform (TF) files are properly formatted
- **Linting**: Validates configuration syntax and best practices with TFLint
- **Security scanning**: Checks for security issues and vulnerabilities with TFSec
- **Terragrunt validation**: Ensures the TF and TG files have valid syntax
- **Plan**: Verifies infrastructure changes without applying them

**Note**: Read the [pre-commit configuration](../.pre-commit-config.yaml) to learn more about the run checks.

### 2. Terratest
Runs when the `run-terratest` label is added to a PR:
- **Infrastructure deployment**: Creates actual GCP resources in a test environment
- **Testing**: Runs Go to validate deployed infrastructure
- **Cleanup**: Automatically destroys test resources

### 3. Documentation Generation
Uses `terraform-docs` to automatically generate `README.md` in each terraform module in `modules/`.

If authoring new Terraform modules in `modules/`, read the [documentation instructions](../modules/README.md#documentation)

## Setup
### Initial Setup
Follow the [bootstrap guide](../bootstrap/README.md) to:
- Configure GitHub Actions authentication with GCP
- Set up Workload Identity Federation
- Configure deploy keys for private repositories

### Pre-commit Setup (Recommended)
Install pre-commit locally to catch issues before pushing:

```bash
# Install pre-commit
pip install pre-commit

# Install the git hooks
pre-commit install

# Test it works
pre-commit run --all-files
```

This runs the same checks as CI locally, preventing CI failures.

## Using the CI

### Standard PR Workflow
1. Create a branch with your changes
2. Push to GitHub and open a pull request
3. The `code-quality-checks` job runs automatically
4. Address any failures and push fixes

### Running Infrastructure Tests
When your PR is ready for final validation:

1. Add the `run-terratest` label to your PR
2. The `terratest` job will run after code quality checks pass
3. Tests deploy infrastructure, validate it, then clean up
4. Address any failures and push fixes
5. Once both jobs pass, merge your PR

> **Note**: Infrastructure tests consume GCP resources and take some time to deploy and destroy. The label check is used to run the tests only run when your PR is ready for final validation before merging.

## Troubleshooting

### Pre-commit Failures
- **Format issues**: Run `terragrunt hcl format` and `tofu fmt -recursive`, add, commit, and push
- **Linting errors**: Check TFLint output and fix reported issues
- **Security issues**: Review TFSec findings and address vulnerabilities

### Terragrunt Plan Failures
- Ensure all required variables are set in `terragrunt.hcl`
- Check that GCP APIs are enabled
- Verify IAM permissions for the service account

### Terratest Failures
- Check the `run-terratest` label is present on the PR
- Ensure test environment has sufficient GCP quotas
- Review test logs for specific infrastructure deployment issues

## Tips
- Failed workflows don't cancel automatically to prevent state corruption
- Do not cancel the CI manually as this will generate state locks.