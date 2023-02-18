# Terraform Registry Module / GitHub Repo

This is a handy module. This will create a GitHub repo from the public template 
repo [conzy/terraform-module-template](https://github.com/conzy/terraform-module-template)

It will then register that repo as a module with Terraform Cloud. This is a good demonstration of the power
of terraform modules that can interact with multiple cloud providers.

## Naming

Terraform Registry Modules must adhere to certain standards and conventions
listed [here](https://developer.hashicorp.com/terraform/language/modules/develop)

The repo naming is important and must follow the `terraform-<provider>-<module-name>` pattern.

e.g

- `terraform-aws-s3`
- `terraform-tfe-modules`
- `terraform-snowflake-database`

## Branch Protection

We try and enforce some best practice GitHub configuration here. The repo thats created will have a
default `main` branch and there will be a branch protection rule created that requires:

- Pull Requests with approval
- Status Checks Passing

We require the `lint` status check to pass as that is the check provided by the template repo. This gives
you out of the box terraform linting. You can override this via the `check_contexts` variable. The Terraform
Cloud registry will show you all the available configuration on the module.
