variable "billing_account_id" {
  type        = string
  sensitive   = true
  description = "The id of the billing account"
}

variable "seed_sa_email" {
  type        = string
  sensitive   = true
  description = "Email address of the service account"
}
