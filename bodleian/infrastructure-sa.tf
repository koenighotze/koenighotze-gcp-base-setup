resource "google_service_account" "bodleian_infrastructure_service_account" {
  project      = data.google_project.project.project_id
  account_id   = "infra-setup-sa"
  display_name = "Infrastructure Setup Service Account"
  description  = "Service account for infrastructure activities on this project"
}

resource "google_project_iam_binding" "bodleian_infrastructure_iam_binding_project" {
  project = data.google_project.project.project_id
  role    = "roles/logging.logWriter"

  members = [
    "serviceAccount:${google_service_account.bodleian_infrastructure_service_account.email}"
  ]
}

resource "google_project_iam_binding" "bodleian_infrastructure_iam_binding_project" {
  project = data.google_project.project.project_id
  role    = "roles/iam.serviceAccountViewer"

  members = [
    "serviceAccount:${google_service_account.bodleian_infrastructure_service_account.email}"
  ]
}

#tfsec:ignore:google-iam-no-privileged-service-accounts
resource "google_project_iam_binding" "bodleian_infrastructure_iam_binding_project" {
  project = data.google_project.project.project_id
  role    = "roles/run.admin"

  members = [
    "serviceAccount:${google_service_account.bodleian_infrastructure_service_account.email}"
  ]
}

resource "google_project_iam_binding" "bodleian_infrastructure_iam_binding_project" {
  project = data.google_project.project.project_id
  role    = "roles/viewer"

  members = [
    "serviceAccount:${google_service_account.bodleian_infrastructure_service_account.email}"
  ]
}

resource "google_service_account_iam_binding" "backend_service_sa_user_iam_binding" {
  service_account_id = google_service_account.backend_service_sa.name
  role               = "roles/iam.serviceAccountUser"

  members = [
    "serviceAccount:${google_service_account.bodleian_infrastructure_service_account.email}"
  ]
}