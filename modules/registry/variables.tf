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

