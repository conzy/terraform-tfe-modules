# Workspace

Creates a workspace with:

- Team Access
- Environment Variables
- VCS Configuration
- Working Directory

You should not pass secret environment variables with this module as they will be persisted in the state file!

## Remote vs Local

Terraform Cloud supports remote or local operations. In most cases we want remote operations.

### Remote Operations

With Remote Operations, operations happen in the Terraform Cloud. Using a virtual machine in the Terraform Cloud and
credentials stored as secret environment variables in Terraform Cloud. These runs are strictly driven by VCS and you
cannot interact with the state manually. This allows us to limit infrastructure changes to Peer reviewed pull requests.

### Local Operations

Local Operations are also supported. In this scenario terraform runs from your local machine and the credentials used to
interact with the cloud services are set on your local machine. Only the state file is synchronised to terraform cloud.
This can be useful for testing / pre production environments, where we want to be able to iterate on infrastructure locally
but we still want to store the state on a remote backend for easier collaboration.

### Sharing State

You can configure a workspace to share its state with other workspaces. The below
example shows sharing with a specific workspace. You can also set `global_remote_state` true if
you are happy to share with the org.

```hcl
data "tfe_workspace" "test" {
  name         = "saas_staging_cognito"
  organization = "your-org"
}

module "development" {
  source            = "foo"
  name              = "conor_test"
  terraform_version = "1.0.6"
  organization      = var.organization
  teams = {
    engineering = "write"
    admin       = "admin"
  }
  global_remote_state = false
  remote_state_consumer_ids = [
   data.tfe_workspace.test.id
  ]
}
```

## Variable Sets

You can associate variables sets with this workspace using the `variable_sets` variable.

```hcl

resource "tfe_variable_set" "test" {
  name          = "Test Varset"
  description   = "Some description."
  organization  = var.organization
}

resource "tfe_variable_set" "test2" {
  name          = "Test Varset2"
  description   = "Some description."
  organization  = var.organization
}

module "development" {
  source            = "../../../terraform-tfe-modules/modules//workspace"
  name              = "test"
  terraform_version = "1.0.6"
  organization      = var.organization
  variable_sets     = [
    tfe_variable_set.test.id,
    tfe_variable_set.test2.id
  ]
}

```
