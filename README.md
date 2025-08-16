Intended for users familiar with Terraform and why it is used.

Read the [Terragrunt Quickstart](https://terragrunt.gruntwork.io/docs/getting-started/quick-start/).

## Installation
To use this repository, you'll want to make sure you have the following installed:
- [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/)
- [OpenTofu](https://opentofu.org/docs/intro/install/) (or [Terraform](https://developer.hashicorp.com/terraform/install))
- [Go]()
- [Python3.13.1]()
- [tflint]()
- [GitHub CLI](https://github.com/cli/cli#installation)

To simplify the process of installing these tools, you can install [mise](https://mise.jdx.dev/), then run the following to concurrently install all the tools you need, pinned to the versions they were tested with (as tracked in the [mise.toml](./mise.toml) file):
```bash
mise install
```

## Pre-commit
To be able to run pre-commits, install the following tools:
- [tflint](https://github.com/terraform-linters/tflint#installation): lint your terraform code.
- [Python](https://www.python.org/downloads/) to run the pre-commits.

## CI
The CI runs the pre-commit, `terragrunt stack generate` and `terragrunt stack run plan`.
Then if the `run-terratest` label is not present, it fails.
Otherwise, it runs terratest: create the infrastructure and test for expected outcome.
This pattern is used to avoid having the CI create the infrastructure every time there is a new commit pushed on the pull request.

## TL;DR
Terragrunt is a wrapper for Terraform that simplifies:
  - keeping configs DRY (Don't Repeat Yourself)
  - managing multiple environments (dev, staging, prod)
  - managing dependencies and execution order
  - auto-running `terraform init` when needed

### Key Terragrunt concepts:
  - Unit: is a directory that contains a `terragrunt.hcl` file, and it represents a single piece of infrastructure. You can think of a unit as a single instance of an OpenTofu/Terraform module.
  - Stack: a collection of units that are managed together. You can think of a stack as a single environment, such as `dev`, `staging`, or `prod`, or an entire project.
  - Shared module: A reusable Terraform module that multiple units reference to avoid repeating code. Usually in the `modules` directory.
  ```hcl
  terraform {
    source = "..modules/shared_modules"
  }
  ```
  - Inputs: variables passed to a unit.
  ```hcl
  inputs = {
    content = "Hello from foo"
  }
  ```
  - Dependencies: how one unit can depend on outputs from another unit.
  ```hcl
  dependency "foo" {
    config_path = "../foo"
  }
  
  inputs = {
    content = "Foo content: ${dependency.foo.outputs.content}"
  }
  ```
