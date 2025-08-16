# Develop a new module
Suppose we want to add a module named `example`.
First, use relative path for terraform source.


1. Write a terraform module in `modules/example`.
2. Write a terragrunt wrapper in `units/example` with `values.`
3. Write in `examples/stacks/example` a `terragrunt.stack.hcl` that call the `units/example` an insert the appropriate values.
4. Then test your example stack:
```bash
cd examples/stacks/example
terragrunt stack generate
terragrunt stack run validate
terragrunt stack run plan
terragrunt stack run apply
```

Once it works, in `units/example` replace terraform source by the github url with value.

# Enable GitHub Actions to run Terragrunt

# Troubleshoot
if you face an error:
```bash
Error: Error creating WorkloadIdentityPool: googleapi: Error 409: Requested entity already exists
```

This happends because WIP can only be soft-deleted. GCP deletes it after 30 days.
So we'll need to undelete it and import it in your TF state.

In the trace, under `google_iam_workload_identity_pool_provider.github` find the WIP ID:
```bash
workload_identity_pool_id          = "YOUR_WIP_ID"
```

Declare a variables for convenience, replace `{{YOUR_WIP_ID}}`:
```bash
export WIP_ID={{YOUR_WIP_ID}}
export PROJECT_NUMBER=$(gcloud projects describe $(gcloud config get-value project) --format="value(projectNumber)")
```

Then run:
```bash
gcloud iam workload-identity-pools undelete $WIP_ID --location=global
```

`cd` into where your wip unit is:
```bash
cd .terragrunt-stack/workload_identity_federation/
```

Import the pool into Terraform state:
```bash
terragrunt import google_iam_workload_identity_pool.github_pool projects/$PROJECT_NUMBER/locations/global/workloadIdentityPools/$WIP_ID
```

Go back to the root of your stack and run:
```bash
cd ../..
terragrunt stack run apply
```

If your still stuck, use another `google_iam_workload_identity_pool` ID.