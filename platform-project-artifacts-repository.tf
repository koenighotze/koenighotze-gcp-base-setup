#checkov:skip=CKV_GCP_84:We are fine with Google's keys
resource "google_artifact_registry_repository" "docker" {
  provider = google-beta
  project  = data.google_project.platform_project.project_id

  location      = var.region
  repository_id = "platform-registry-${random_integer.rand.result}"
  description   = "Docker registry for KH projects"
  format        = "DOCKER"
}

resource "google_artifact_registry_repository_iam_binding" "service_deployer_artifact_registry_iam_binding" {
  provider = google-beta
  project  = data.google_project.platform_project.project_id

  for_each = toset([
    "roles/artifactregistry.reader",
    "roles/artifactregistry.writer"
  ])

  location   = google_artifact_registry_repository.docker.location
  repository = google_artifact_registry_repository.docker.name
  role       = each.value
  members = [
    "serviceAccount:${module.backend_deployer_sa.email}",
    "serviceAccount:${google_service_account.backend_service_sa.email}"
  ]
}
