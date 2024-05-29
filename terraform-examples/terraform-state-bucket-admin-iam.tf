# This SA needs to be able to do some privileged work
#checkov:skip=CKV_GCP_117:Allow admin for this bucket
#trivy:ignore:avd-gcp-0007
resource "google_project_iam_binding" "project_iam_binding" {
  for_each = toset([
    "roles/storage.admin"
  ])
  project = data.google_project.project.project_id
  role    = "roles/storage.admin"

  members = [
    "serviceAccount:${google_service_account.sa.email}",
    "serviceAccount:${var.admin_sa_email}"
  ]
}
