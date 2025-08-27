# Development Guide

## Development
Suppose we want to add a module named `example`.

First, use relative path for terraform source.
1. Create a branch
2. Write a terraform module in `modules/example`.
3. Write a terragrunt wrapper in `units/example` with `values.`
4. Write a new stack in `stacks/example_stack` or add your unit to an existing stack in `stacks`.
5. Write in `examples/stacks/example` a `terragrunt.stack.hcl` that call the `stacks/example_stack` or the existing stack you modified.
6. Then test your example stack:
```bash
cd examples/stacks/example
terragrunt stack generate
terragrunt stack run validate
terragrunt stack run plan
terragrunt stack run apply
```

Once your stack works, create a PR and merge it on `main`.

## Integrate In Production
Next, tag the lastest commit on main:
```bash
#replace with your version
export YOUR_GIT_TAG=v0.0.1

git checkout main
git tag $YOUR_GIT_TAG 
git push origin $YOUR_GIT_TAG
```

Finally, integrate your modification in the [terragrunt-template-live-gcp](https://github.com/ConsciousML/terragrunt-template-live-gcp) repository inside the appropriate environment.


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