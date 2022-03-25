variable "admin_sa_email" {
  type        = string
  sensitive   = true
  description = "Email address of the service account"
}

variable "project_postfix" {
  type        = string
  description = "The unique postfix for the projects"
}

variable "region" {
  default = "europe-west3"
}
