#checkov:skip=CKV_GCP_84:We are fine with Google's keys
resource "google_artifact_registry_repository" "docker" {
  provider = google-beta
  project  = data.google_project.platform_project.project_id

  location      = var.region
  repository_id = "platform-registry-${random_integer.rand.result}"
  description   = "Container registry for KH projects"
  format        = "DOCKER"
}

# This SA needs to be able to do some privileged work
#tfsec:ignore:google-iam-no-privileged-service-accounts
resource "google_project_iam_binding" "admin_platform_iam_binding_project" {
  project = data.google_project.platform_project.project_id
  role    = "roles/storage.admin"

  members = [
    "serviceAccount:${var.admin_sa_email}"
  ]
}