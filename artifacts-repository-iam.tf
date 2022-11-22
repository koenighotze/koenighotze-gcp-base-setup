locals {
  artifact_reader_sas = [
    # module.bodleian.backend_deployer_sa_email,
    module.bodleian.backend_service_sa_email,
    # module.bodleian.frontend_deployer_sa_email,
    # module.bodleian.frontend_service_sa_email,
    module.bodleian.cloudrun_sa_email,
  ]

  artifact_writer_sas = [
    # module.bodleian.backend_deployer_sa_email,
    # module.bodleian.frontend_deployer_sa_email,
  ]
}

resource "google_artifact_registry_repository_iam_member" "artifact_registry_readers" {
  for_each = toset(local.artifact_reader_sas)

  provider   = google-beta
  project    = module.platform.project_id
  location   = module.platform.location
  repository = module.platform.repository
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${each.key}"
}

resource "google_artifact_registry_repository_iam_member" "artifact_registry_writers" {
  for_each = toset(local.artifact_writer_sas)

  provider   = google-beta
  project    = module.platform.project_id
  location   = module.platform.location
  repository = module.platform.repository
  role       = "roles/artifactregistry.writer"
  member     = "serviceAccount:${each.key}"
}
