#tfsec:ignore:google-iam-no-privileged-service-accounts
resource "google_service_account" "sa" {
  project      = data.google_project.platform_project.project_id
  account_id   = "platform-sa"
  display_name = "Platform infrastructure admin"
  description  = "Admin service account for ${data.google_project.platform_project.project_id}"
}

resource "google_project_iam_member" "platform_iam_member_project" {
  for_each = toset([
    "roles/artifactregistry.admin",
    "roles/logging.logWriter",
    "roles/run.developer",
    "roles/storage.admin",
    "roles/viewer"
  ])
  project = data.google_project.platform_project.project_id
  #checkov:skip=CKV_GCP_117:This SA needs to be able to do some privileged work
  role = each.value

  member = "serviceAccount:${google_service_account.sa.email}"
}
