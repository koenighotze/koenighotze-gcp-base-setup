resource "google_service_account" "backend_service_sa" {
  project     = data.google_project.project.project_id
  account_id  = "bodleian-backend"
  description = "Service account for running the backend part"
}

# This service must be able to run the backend as part of cloud run
resource "google_project_iam_member" "bodleian_backend_service_iam_binding" {
  #checkov:skip=CKV_GCP_117:Allow
  for_each = toset([
    "roles/logging.logWriter",
    "roles/run.developer",
    "roles/viewer"
  ])
  project = data.google_project.project.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.backend_service_sa.email}"
}

resource "google_service_account_iam_member" "deployer_serviceaccountuser" {
  service_account_id = google_service_account.backend_service_sa.name
  role               = "roles/iam.serviceAccountUser"

  member = "serviceAccount:${google_service_account.backend_deployer_sa.email}"
}

resource "google_service_account_iam_member" "infrastructure_serviceaccountuser" {
  service_account_id = google_service_account.backend_service_sa.name
  role               = "roles/iam.serviceAccountUser"

  member = "serviceAccount:${google_service_account.bodleian_infrastructure_service_account.email}"
}
