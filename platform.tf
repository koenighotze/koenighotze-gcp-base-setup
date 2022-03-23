module "platform" {
  source = "./platform"

  billing_account_id  = var.billing_account_id
  admin_sa_email      = var.seed_sa_email_address
  project_postfix     = var.project_postfix
  artifact_reader_sas = []
  artifact_writer_sas = []
}
