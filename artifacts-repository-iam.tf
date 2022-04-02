locals {
  artifact_reader_sas = [
    module.bodleian.backend_deployer_sa_email,
    module.bodleian.backend_service_sa_email
  ]

  artifact_writer_sas = [
    module.bodleian.backend_deployer_sa_email
  ]
}

resource "google_artifact_registry_repository_iam_binding" "service_deployer_artifact_registry_readers" {
  provider = google-beta
  project  = module.platform.project_id

  location   = module.platform.location
  repository = module.platform.repository
  role       = "roles/artifactregistry.admin"
  members    = [for sa in local.artifact_reader_sas : "serviceAccount:${sa}"]
}

resource "google_artifact_registry_repository_iam_binding" "service_deployer_artifact_registry_writers" {
  provider = google-beta
  project  = module.platform.project_id

  location   = module.platform.location
  repository = module.platform.repository
  role       = "roles/artifactregistry.admin"
  members    = [for sa in local.artifact_writer_sas : "serviceAccount:${sa}"]
}
