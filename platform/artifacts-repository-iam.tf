# #checkov:skip=CKV_GCP_84:We are fine with Google's keys
# resource "google_artifact_registry_repository_iam_binding" "service_deployer_artifact_registry_readers" {
#   provider = google-beta
#   project  = data.google_project.platform_project.project_id

#   location   = google_artifact_registry_repository.docker.location
#   repository = google_artifact_registry_repository.docker.name
#   role       = "roles/artifactregistry.reader"
#   members    = [for sa in var.artifact_reader_sas : "serviceAccount:${sa}"]
# }

# resource "google_artifact_registry_repository_iam_binding" "service_deployer_artifact_registry_writers" {
#   provider = google-beta
#   project  = data.google_project.platform_project.project_id

#   location   = google_artifact_registry_repository.docker.location
#   repository = google_artifact_registry_repository.docker.name
#   role       = "roles/artifactregistry.writer"
#   members    = [for sa in var.artifact_writer_sas : "serviceAccount:${sa}"]
# }
