variable "seed_project" {
  type        = string
  description = "The name of the seed project"
  default     = "koenighotze-seed"
}

variable "billing_account_id" {
  type        = string
  sensitive   = true
  description = "The id of the billing account"
  default     = "011CC2-3475B8-FC57E1"
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
  default     = "398addce"
}

# variable "seed_sa_email" {
#   type        = string
#   sensitive   = true
#   description = "Email address of the service account"
# }

# variable "region" {
#   type    = string
#   default = "europe-west3"
# }

# variable "github_admin_token" {
#   type        = string
#   sensitive   = true
#   description = "The API Token for the GitHub API"
# }

# variable "github_api_label_token" {
#   type        = string
#   sensitive   = true
#   description = "The API Token for the GitHub API used in pull requests"
# }

# variable "project_postfix" {
#   type        = string
#   description = "The unique postfix for the projects"
# }

# variable "workload_identity_provider_name" {
#   type        = string
#   description = "The name of the workload identity provider"
# }

# variable "workload_identity_pool_id" {
#   type        = string
#   description = "The id of the workload identity pool"
# }

# variable "codacy_api_token" {
#   type        = string
#   sensitive   = true
#   description = "The API token for uploading coverage data"
# }

# # variable "docker_registry_username" {
# #   type        = string
# #   sensitive   = true
# #   description = "The username for uploading images to docker hub"
# # }

# # variable "docker_registry_token" {
# #   type        = string
# #   sensitive   = true
# #   description = "The API token for uploading images to docker hub"
# # }
