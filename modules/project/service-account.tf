locals {
  project_roles = [
    "roles/logging.logWriter",
    "roles/viewer",
    "roles/iam.serviceAccountCreator",
    "roles/iam.serviceAccountKeyAdmin"
  ]
}

resource "google_service_account" "service_account" {
  project      = var.project_id
  account_id   = "infra-setup-sa"
  display_name = "Service account for infrastructure activities on this project"
}

resource "time_rotating" "key_rotation" {
  rotation_days = 30
}

resource "google_service_account_key" "key" {
  service_account_id = google_service_account.service_account.name

  keepers = {
    rotation_time = time_rotating.key_rotation.rotation_rfc3339
  }
}

resource "google_project_iam_binding" "iam_binding_project" {
  for_each = toset(local.project_roles)
  project  = var.project_id
  role     = each.value

  members = [
    "serviceAccount:${google_service_account.service_account.email}"
  ]
}
