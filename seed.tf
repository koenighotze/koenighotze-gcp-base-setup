module "seed" {
  source = "./seed"

  billing_account_id    = var.billing_account_id
  seed_sa_email_address = var.seed_sa_email_address
}
