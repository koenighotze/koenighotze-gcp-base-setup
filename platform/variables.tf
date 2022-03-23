variable "admin_sa_email" {
  type        = string
  sensitive   = true
  description = "Email address of the service account"
}

variable "project_postfix" {
  type        = string
  description = "The unique postfix for the projects"
}

variable "artifact_reader_sas" {
  default     = []
  description = "Service accounts emails with read access"
}

variable "artifact_writer_sas" {
  default     = []
  description = "Service accounts emails with read access"
}

variable "region" {
  default = "europe-west3"
}
