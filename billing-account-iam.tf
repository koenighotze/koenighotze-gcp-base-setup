resource "google_billing_account_iam_member" "billing_account_admins" {
  billing_account_id = data.google_billing_account.billing_account.id
  role               = "roles/billing.viewer"
  member             = "serviceAccount:${var.seed_sa_email_address}"
}