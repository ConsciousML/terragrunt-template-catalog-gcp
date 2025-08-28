# Terraform Modules Directory

This directory contains reusable Terraform modules for deploying Google Cloud Platform (GCP) resources.

## What are Modules?

A **module** is a directory containing Terraform configuration files that define GCP resources.

Each module declares specific Terraform resources and can be reused across different deployments with different input variables.

## What's Inside?

Each module in this directory:
- Declares Terraform resources using `main.tf`
- Defines input variables in `variables.tf` 
- Configures providers in `providers.tf`
- Exposes outputs in `outputs.tf` (when applicable)

## How are Modules Used?

Modules are not used directly as in native Terraform setups.
Read the [developement guide](../docs/development.md).

## Documentation 
All Terraform modules have a `README.md` automatically generated using [terraform-docs](https://terraform-docs.io/) during CI. Each module's README.md is created from:

- `header.md` - Module title and description
- Generated terraform-docs content (requirements, providers, resources, inputs, outputs)  
- `footer.md` - Additional explanations or usage notes

When authoring a new module:
1. Create a `header.md` file with the module name and brief description
2. Create a `footer.md` file with additional context (leave empty if not needed)
3. The README.md will be generated automatically by the CI workflow