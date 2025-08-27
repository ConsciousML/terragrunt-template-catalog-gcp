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