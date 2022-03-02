variable "project_id" {
  type        = string
  sensitive   = false
  description = "The id of the project"
}

variable "location" {
  default = "europe-west3"
}

variable "project_name" {
  type        = string
  sensitive   = false
  description = "The name of the project"
}

variable "github_org_name" {
  default = "koenighotze"
}

variable "github_admin_token" {
  type        = string
  sensitive   = true
  description = "The API Token for the GitHub API"
}
