# Test Terragrunt Stacks With Terratest

## Installation
Follow the [Go installation instructions](https://go.dev/doc/install):

## Write a test
Copy `tests/vpc_db_stack_test.go` in the `test` directory. Use the suffix `*_test.go`.

Next, change the stack directory to the path of the stack you want to test:
```go
stackDir := "../examples/stacks/vpc-db/local"
```

Finally, write additional tests steps. For example, you can perform health checks or make a request to an API to ensure your infrastructure was deployed properly.

## Why creating an external test example?
Creating an `examples` folder is a best practice to provide complete Terraform configurations that call the module and supply any required dependencies.

This makes testing easier and helps others understand how to use the module.

In our case, the `examples/stacks/vpc_db/local` configuration calls the `stacks/vpc_db` in the `example` folder so it uses all the `.hcl` files in this directory.

This as the benefit to use environment variables specific to an `example` environment.

## Run Terratest
Setup the go module:
```bash
go mod init github.com/ConsciousML/terragrunt-template-stack-gcp
go get github.com/gruntwork-io/terratest/modules/terraform
go get github.com/stretchr/testify/assert
go mod tidy
```

Run the test:
```bash
go test -v ./tests/... -timeout 30m
```