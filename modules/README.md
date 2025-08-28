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