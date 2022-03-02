variable "billing_account_id" {
  type        = string
  sensitive   = true
  description = "The id of the billing account"
}

variable "seed_sa_email_address" {
  type        = string
  sensitive   = true
  description = "Email address of the service account"
}

variable "region" {
  default = "europe-west3"
}

variable "environment" {
  default = "dev"
}

variable "github_admin_token" {
  type        = string
  sensitive   = true
  description = "The API Token for the GitHub API"
}

variable "project_postfix" {
  type = string
  description = "The unique postfix for the projects"
}