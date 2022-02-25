resource "google_billing_account_iam_member" "billing_account_admins" {
  billing_account_id = var.billing_account_id
  role               = "roles/billing.costsManager"
  member             = "serviceAccount:${var.seed_sa_email_address}"
}