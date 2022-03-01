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