resource "google_service_account" "sa" {
  project      = data.google_project.project.project_id
  account_id   = "terraform-examples-sa"
  display_name = "TF EXamples Service Account"
  description  = "Service account for handling the TF Examples"
}

#tfsec:ignore:google-iam-no-privileged-service-accounts
resource "google_project_iam_binding" "iam_binding_project" {
  for_each = toset([
    "roles/logging.logWriter",
    "roles/iam.serviceAccountViewer",
    "roles/run.admin",
    "roles/viewer"
  ])

  project = data.google_project.project.project_id
  role    = each.key

  members = [
    "serviceAccount:${google_service_account.sa.email}"
  ]
}
