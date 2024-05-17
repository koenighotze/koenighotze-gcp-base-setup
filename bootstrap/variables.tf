variable "seed_project" {
  type        = string
  description = "The name of the seed project"
  default     = "koenighotze-seed"
}

variable "billing_account_id" {
  type        = string
  sensitive   = true
  description = "The id of the billing account"
}

variable "workload_identity_pool_id" {
  type        = string
  description = "The id of the workload identity pool"
  default     = "github-cicd-pool"
}

variable "workload_identity_pool_provider_id" {
  type        = string
  description = "The id of the workload identity pool provider"
  default     = "github-cicd-pool-provider"
}

variable "postfix" {
  type        = string
  description = "The unique postfix for the projects"
}

variable "extra_labels" {
  type        = map(string)
  description = "Extra labels to apply to resources"
  default     = {}
}

variable "projects_config" {
  type = map(object({
    extra_apis  = list(string)
    extra_roles = list(string)
  }))
  default = {}
}
