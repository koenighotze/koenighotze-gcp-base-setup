resource "google_service_account" "bodleian_infrastructure_service_account" {
  project      = var.project_id
  account_id   = "infra-setup-sa"
  display_name = "Infrastructure Setup Service Account"
  description  = "Service account for infrastructure activities on this project"
}

resource "google_project_iam_binding" "bodleian_infrastructure_iam_binding_project" {
  #checkov:skip=CKV_GCP_117:Allow admin for this bucket
  for_each = toset([
    "roles/logging.logWriter",
    "roles/iam.serviceAccountViewer",
    "roles/run.admin",
    "roles/viewer"
  ])

  project = var.project_id
  role    = each.key

  members = [
    "serviceAccount:${google_service_account.bodleian_infrastructure_service_account.email}"
  ]
}
