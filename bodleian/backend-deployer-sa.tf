# This SA is used by the bodleian-service to deploy resources
#tfsec:ignore:google-iam-no-privileged-service-accounts
resource "google_service_account" "backend_deployer_sa" {
  project      = var.project_id
  account_id   = "bodleian-backend-cicd"
  display_name = "bodleian-backend"
  description  = "CI/CD service account for ${var.project_id}"
}

# This SA needs to be able to do some privileged work
resource "google_project_iam_member" "iam_member_project" {
  #checkov:skip=CKV_GCP_117:Allow
  for_each = toset([
    "roles/logging.logWriter",
    "roles/run.developer",
    "roles/viewer"
  ])
  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.backend_deployer_sa.email}"
}
