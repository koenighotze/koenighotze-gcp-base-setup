locals {
  project_roles = [
    "roles/logging.logWriter"
  ]
}

resource "google_service_account" "service_account" {
  project      = var.project_id
  account_id   = "infra-setup-sa"
  display_name = "Service account for infrastructure activities on this project"
}

resource "google_service_account_key" "key" {
  service_account_id = google_service_account.service_account.name
}

resource "google_project_iam_binding" "iam_binding_project" {
  for_each = toset(local.project_roles)
  project  = var.project_id
  role     = each.value

  members = [
    "serviceAccount:${google_service_account.service_account.email}"
  ]
}
