variable "name" {
  type        = string
  description = "The name of the repo to create. This will also be the module name"
}

variable "visibility" {
  type        = string
  description = "Public or Private repo. Safe default of private"
  default     = "private"
}

variable "oauth_token_id" {
  type        = string
  description = "The oauth token id of the VCS Provider."
}

variable "description" {
  type        = string
  description = "The repo description"
  default     = "Managed by Terraform"
}

variable "delete_branch_on_merge" {
  type        = bool
  default     = true
  description = "Tidy up head branches on merge."
}

variable "branch_protection" {
  type        = bool
  default     = true
  description = "Should branch protection be enforced."
}

variable "enforce_admins" {
  type        = bool
  description = "Should admins be subject to branch protection rules. I need to disable this for demo purposes!"
  default     = true
}

variable "check_contexts" {
  type        = list(string)
  description = "What contexts should be used for required status checks? We default to lint which is the check in the template repo."
  default     = ["lint"]
}
