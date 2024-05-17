#tfsec:ignore:google-iam-no-privileged-service-accounts
resource "google_service_account" "sa" {
  project     = data.google_project.platform_project.project_id
  account_id  = "platform-sa"
  description = "Admin service account for ${data.google_project.platform_project.project_id}"
}

# # This SA needs to be able to do some privileged work
# resource "google_project_iam_member" "iam_member_project" {
#   #checkov:skip=CKV_GCP_117:Allow
#   for_each = toset([
#     "roles/logging.logWriter",
#     "roles/run.developer",
#     "roles/viewer"
#   ])
#   project = data.google_project.project.project_id
#   role    = each.value
#   member  = "serviceAccount:${google_service_account.backend_deployer_sa.email}"
# }

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
