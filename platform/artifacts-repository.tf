resource "google_artifact_registry_repository" "docker" {
  #checkov:skip=CKV_GCP_84:We are fine with Google's keys
  provider = google-beta
  project  = var.project_id

  location      = var.region
  repository_id = "platform-registry-${random_integer.rand.result}"
  description   = "Container registry for KH projects"
  format        = "DOCKER"
}
