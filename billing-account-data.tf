data "google_billing_account" "billing_account" {
  billing_account = var.billing_account_id
  depends_on = [
    google_project_service.baseline_project_services
  ]
}