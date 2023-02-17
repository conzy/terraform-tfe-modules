variable "env_vars" {
  type    = map(string)
  default = {}
}
variable "name" {
  description = "The name of the workspace"
}
variable "organization" {
  description = "The organization"
}
variable "teams" {
  type        = map(string)
  description = "A map of team names and the access level that team should have"
}

variable "terraform_version" {
  type    = string
  default = "1.0.6"
}

variable "working_directory" {
  default     = ""
  description = "The directory to run terraform in"
}

variable "trigger_prefixes" {
  type    = list(string)
  default = []
}

variable "auto_apply" {
  type        = bool
  description = "Should this workspace implicitly run the apply phase or wait for manual approval"
  default     = false
}

variable "vcs_repo" {
  type    = map(string)
  default = {}
}

variable "global_remote_state" {
  type        = bool
  description = "By enabling this all workspaces in the organisation can access this workspace's state"
  default     = false
}

variable "remote_state_consumer_ids" {
  type        = list(string)
  description = "A list of workspace IDs that can access this workspace's state"
  default     = []
}

variable "notification_triggers" {
  type        = list(string)
  description = "What workspace operations should trigger notifications"
  default     = []
}

variable "slack_webhook_url" {
  type        = string
  description = "A valid slack webhook URL"
  default     = ""
}

variable "structured_run_output_enabled" {
  type        = bool
  description = "Use new graphical output or classic output"
  default     = false
}

variable "tag_names" {
  type        = list(string)
  description = "A list of tags to apple to the workspace"
  default     = []
}

variable "description" {
  type        = string
  description = "Workspace description"
  default     = "This workspace is managed by Terraform"
}

variable "execution_mode" {
  type        = string
  description = "remote, local or agent execution"
  default     = "remote"
}

variable "agent_pool_id" {
  type        = string
  description = "The id of an agent pool"
  default     = null
}

variable "variable_sets" {
  type        = list(string)
  description = "Variable sets to associate with this workspace"
  default     = []
}
