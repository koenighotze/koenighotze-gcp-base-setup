# This SA needs to be able to do some privileged work
#tfsec:ignore:google-iam-no-privileged-service-accounts
resource "google_project_iam_binding" "project_iam_binding" {
  for_each = toset([
    "roles/storage.admin"
  ])
  project = data.google_project.project.project_id
  role    = "roles/storage.admin"

  members = [
    "serviceAccount:${google_service_account.sa.email}",
  ]
}
