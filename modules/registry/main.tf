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
