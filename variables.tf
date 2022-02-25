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

variable "postfix" {
  default = "72d26c895553"
  description = "Project creation random string"
}