variable "project_id" {
  type        = string
  description = "The id of the project"
}

variable "region" {
  default = "europe-west3"
}

variable "location" {
  default = "europe-west3"
}

variable "target_repository_name" {
  default = "koenighotze/gcp-terraform-examples"
}

variable "workload_identity_provider_name" {
  type        = string
  description = "The name of the workload identity provider"
}

variable "workload_identity_pool_id" {
  type        = string
  description = "The id of the workload identity pool"
}

variable "admin_sa_email" {
  type        = string
  sensitive   = true
  description = "Email address of the admin service account"
}
