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
To be able to run pre-commits, run:
```bash
pre-commit install
```

## CI
Explain CI here

