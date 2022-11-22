resource "google_service_account" "frontend_service_sa" {
  project     = data.google_project.project.project_id
  account_id  = "bodleian-frontend"
  description = "Service account for running the frontend part"
}

# # # This service must be able to run the frontend as part of cloud run
# # #tfsec:ignore:google-iam-no-privileged-service-accounts
resource "google_project_iam_member" "bodleian_frontend_service_iam_binding" {
  for_each = toset([
    "roles/logging.logWriter",
    "roles/run.developer",
    "roles/viewer"
  ])
  project = data.google_project.project.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.frontend_service_sa.email}"
}

resource "google_service_account_iam_binding" "frontend_service_sa_user_iam_binding_serviceaccountuser" {
  service_account_id = google_service_account.frontend_service_sa.name
  role               = "roles/iam.serviceAccountUser"

  members = [
    "serviceAccount:${google_service_account.frontend_deployer_sa.email}",
    "serviceAccount:${google_service_account.bodleian_infrastructure_service_account.email}"
  ]
}
