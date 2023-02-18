terraform {
  required_providers {
    tfe = {
      version = ">= 0.36.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

resource "tfe_registry_module" "registry_module" {
  vcs_repo {
    display_identifier = github_repository.repo.full_name
    identifier         = github_repository.repo.full_name
    oauth_token_id     = var.oauth_token_id
  }
}

resource "github_repository" "repo" {
  name        = var.name
  description = var.description
  visibility  = var.visibility

  template {
    owner                = "conzy"
    repository           = "terraform-module-template"
    include_all_branches = true
  }
}

resource "github_branch_protection" "protection" {
  count          = var.branch_protection ? 1 : 0
  repository_id  = github_repository.repo.name
  pattern        = "main"
  enforce_admins = var.enforce_admins

  required_status_checks {
    strict   = false
    contexts = var.check_contexts
  }

  required_pull_request_reviews {
    dismiss_stale_reviews = true
  }
}
