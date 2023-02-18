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
