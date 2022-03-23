resource "google_billing_account_iam_member" "billing_account_admins" {
  billing_account_id = var.billing_account_id
  role               = "roles/billing.admin"
  member             = "serviceAccount:${data.google_service_account.seed_sa.email}"
}