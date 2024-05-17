#tfsec:ignore:google-iam-no-privileged-service-accounts
resource "google_service_account" "sa" {
  project     = data.google_project.platform_project.project_id
  account_id  = "platform-sa"
  description = "Admin service account for ${data.google_project.platform_project.project_id}"
}

# This SA needs to be able to do some privileged work
resource "google_project_iam_member" "seed_platform_iam_member_project" {
  for_each = toset([
    "roles/artifactregistry.admin",
    "roles/logging.logWriter",
    "roles/run.developer",
    "roles/storage.admin",
    "roles/viewer"
  ])
  project = data.google_project.platform_project.project_id
  role    = each.value

  member = "serviceAccount:${google_service_account.sa.email}"
}
