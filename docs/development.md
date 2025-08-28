# Development Workflow

This guide walks you through the complete development workflow for adding new infrastructure modules to the Terragrunt Template Catalog for GCP.

## Overview

The development process follows a structured approach with four main layers:

1. **Terraform Module** (`modules/`): The core infrastructure code
2. **Terragrunt Unit** (`units/`): Wrapper that makes the module reusable
3. **Stack Definition** (`stacks/`): Combines units into deployable infrastructure
4. **Example Implementation** (`examples/`): Concrete usage examples for testing

## Step-by-Step Development Process

### 1. Create a Feature Branch
```bash
git checkout -b add-new-module-feature
```

### 2. Write the Terraform Module
Create your infrastructure module in `modules/your_module/` with the standard Terraform files:
- `main.tf`: Resource definitions
- `variables.tf`: Input variables with detailed descriptions
- `output.tf`: Output values (if needed)
- `providers.tf`: Provider requirements

### 3. Create a Terragrunt Unit Wrapper
Write a terragrunt wrapper in `units/your_module/terragrunt.hcl` that:
- References the module using `values.version` for the git ref
- Defines dependencies on other units (if needed)
- Maps unit inputs to module variables

### 4. Add to a Stack
Either create a new stack in `stacks/your_stack/` or add your unit to an existing stack that:
- Combines multiple units into a cohesive infrastructure deployment
- Passes values from stack parameters to unit inputs
- Defines the deployment path for each unit

### 5. Instantiate the Stack 
Write an example in `examples/stacks/your_example/` that:
- Demonstrates concrete usage of your stack
- Provides configuration values

**Important**: remember to set the version of your source to your current branch or use the following to automate reference selection:
```hcl
locals {
  # Sets the reference of the source code to:
  version = coalesce(
    get_env("GITHUB_HEAD_REF", ""), # PR branch name (only set in PRs)
    get_env("GITHUB_REF_NAME", ""), # Branch/tag name
    try(run_cmd("git", "rev-parse", "--abbrev-ref", "HEAD"), ""),
    "main" # fallback
  )
}

stack "vpc_db" {
  source = "your_git_url//stacks/vpc_db?ref=${local.version}"
  path   = "infrastructure"

  values = {
    version = local.version
    # ...
  }
  # ...
}
```

### 6. Test Your Changes
```bash
cd examples/stacks/your_example
terragrunt stack generate
terragrunt stack run validate
terragrunt stack run plan
terragrunt stack run apply
```

### 7. Create Pull Request
Once your stack works correctly, create a PR and merge it to `main`.

## Practical Example

Here's how the GCE module was developed following the workflow:

### 1. Terraform Module → [modules/gce/](../modules/gce/)
Created the base infrastructure code with [main.tf](../modules/gce/main.tf), [variables.tf](../modules/gce/variables.tf), [providers.tf](../modules/gce/providers.tf) and [output.tf](../modules/gce/output.tf)

### 2. Terragrunt Unit → [units/gce/](../units/gce/)
Wrapped the module in [terragrunt.hcl](../units/gce/terragrunt.hcl) with dependencies on VPC and APIs units

### 3. Stack Definition → [stacks/vpc_gce/](../stacks/vpc_gce/)
Combined units into [terragrunt.stack.hcl](../stacks/vpc_gce/terragrunt.stack.hcl) (APIs + VPC + GCE)

### 4. Example Implementation → [examples/stacks/vpc_gce/](.../examples/stacks/vpc_gce/)
Created [terragrunt.stack.hcl](../examples/stacks/vpc_gce/terragrunt.stack.hcl) with concrete values for testing

### 5. Testing Commands

```bash
cd examples/stacks/vpc_gce
terragrunt stack generate
terragrunt stack run validate
terragrunt stack run plan
terragrunt stack run apply
terragrunt stack run destroy
```

## Integrate In Production
Next, tag the latest commit on main:
```bash
#replace with your version
export YOUR_GIT_TAG=v0.0.1

git checkout main
git tag $YOUR_GIT_TAG 
git push origin $YOUR_GIT_TAG
```

Finally, integrate your modification in the [terragrunt-template-live-gcp](https://github.com/ConsciousML/terragrunt-template-live-gcp) repository inside the appropriate environment.