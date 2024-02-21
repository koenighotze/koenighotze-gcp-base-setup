resource "google_service_account" "sa" {
  project      = data.google_project.project.project_id
  account_id   = "terraform-examples-sa"
  display_name = "TF EXamples Service Account"
  description  = "Service account for handling the TF Examples"
}

resource "google_project_iam_member" "iam_member_project" {
  for_each = toset([
    "roles/compute.admin",
    "roles/iam.serviceAccountAdmin",
    "roles/iam.securityAdmin",
    "roles/logging.logWriter",
    "roles/run.admin",
    "roles/viewer"
  ])

  project = data.google_project.project.project_id
  #checkov:skip=CKV_GCP_117:Allow admin for this
  #checkov:skip=CKV_GCP_49:Allow admin for this sa
  role = each.key

  member = "serviceAccount:${google_service_account.sa.email}"
}
