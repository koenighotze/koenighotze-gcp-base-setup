output "container_registry" {
  value = "${google_artifact_registry_repository.docker.location}-docker.pkg.dev/${data.google_project.platform_project.project_id}/${google_artifact_registry_repository.docker.name}"
}

output "project_id" {
  value = data.google_project.platform_project.project_id
}

output "location" {
  value = google_artifact_registry_repository.docker.location
}

output "repository" {
  value = google_artifact_registry_repository.docker.name
}
