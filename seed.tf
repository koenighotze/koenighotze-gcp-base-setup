module "seed" {
  source = "./seed"

  billing_account_id = var.billing_account_id
  seed_sa_email      = var.seed_sa_email
}
