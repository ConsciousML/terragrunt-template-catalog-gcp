# Terragrunt Units Directory

This directory contains reusable [Terragrunt units](https://terragrunt.gruntwork.io/docs/features/units/) for deploying Google Cloud Platform (GCP) infrastructure. 

Each unit represents a single piece of infrastructure that can be composed together to create complete stacks.

## What are Units?

A **unit** is a directory containing a `terragrunt.hcl` file that represents a single piece of infrastructure.

You can think of a unit as a single instance of a Terraform module. Units can be combined together into [stacks](https://terragrunt.gruntwork.io/docs/features/stacks/) to create complete environments.

## What's Inside?
Each unit in this directory:
- References a corresponding Terraform module in the `modules/` directory
- Defines input variables using the `values.*` pattern
- Manages dependencies between other units
- Includes environment-specific naming conventions

## How to Use?
Refer to the [stacks directory](../stacks/) to see how `units` are used.