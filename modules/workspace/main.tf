terraform {
  required_providers {
    tfe = {
      version = ">= 0.36.0"
    }
  }
}


resource "tfe_workspace" "this" {
  name                      = var.name
  organization              = var.organization
  terraform_version         = var.terraform_version
  working_directory         = var.working_directory
  trigger_prefixes          = var.trigger_prefixes
  global_remote_state       = var.global_remote_state
  remote_state_consumer_ids = var.remote_state_consumer_ids
  dynamic "vcs_repo" {
    for_each = length(keys(var.vcs_repo)) == 0 ? [] : [var.vcs_repo]
    content {
      identifier     = vcs_repo.value["identifier"]
      branch         = vcs_repo.value["branch"]
      oauth_token_id = vcs_repo.value["oauth_token_id"]
    }
  }
  auto_apply                    = var.auto_apply
  structured_run_output_enabled = var.structured_run_output_enabled
  tag_names                     = var.tag_names
  description                   = var.description
  execution_mode                = var.execution_mode
  agent_pool_id                 = var.agent_pool_id
}

resource "tfe_variable" "env_vars" {
  for_each     = var.env_vars
  key          = each.key
  sensitive    = false
  value        = each.value
  category     = "env"
  workspace_id = tfe_workspace.this.id
  description  = "Managed by Terraform"
}

resource "tfe_workspace_variable_set" "variable_sets" {
  for_each        = toset(var.variable_sets)
  variable_set_id = each.key
  workspace_id    = tfe_workspace.this.id
}

# Create an environment variable to indicate this workspace is managed by Terraform
resource "tfe_variable" "managed_by_terraform" {
  key          = "MANAGED_BY_TERRAFORM"
  sensitive    = false
  value        = "true"
  category     = "env"
  workspace_id = tfe_workspace.this.id
  description  = "Managed by Terraform"
}

data "tfe_team" "team_mapping" {
  for_each     = var.teams
  name         = each.key
  organization = var.organization
}

resource "tfe_team_access" "access" {
  for_each     = var.teams
  access       = each.value
  team_id      = data.tfe_team.team_mapping[each.key].id
  workspace_id = tfe_workspace.this.id
}

# Notification

locals {
  default_triggers = [
    "run:applying",
    "run:completed",
    "run:created",
    "run:errored",
    "run:needs_attention",
    "run:planning",
  ]
}

resource "tfe_notification_configuration" "slack" {
  count            = var.slack_webhook_url == "" || var.execution_mode == "local" ? 0 : 1
  enabled          = true
  destination_type = "slack"
  name             = tfe_workspace.this.name
  url              = var.slack_webhook_url
  triggers         = length(var.notification_triggers) == 0 ? local.default_triggers : var.notification_triggers
  workspace_id     = tfe_workspace.this.id
}
