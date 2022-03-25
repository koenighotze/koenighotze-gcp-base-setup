locals {
  artifact_reader_sas = [
    # module.bodleian.backend_deployer_service_account_email
  ]

  artifact_writer_sas = [
    # module.bodleian.backend_deployer_service_account_email
  ]
}


# #checkov:skip=CKV_GCP_84:We are fine with Google's keys
# resource "google_artifact_registry_repository_iam_binding" "service_deployer_artifact_registry_readers" {
#   provider = google-beta
#   project  = module.platform.project_id

#   location   = module.platform.location
#   repository = module.platform.repository
#   role       = "roles/artifactregistry.reader"
#   members    = [for sa in local.artifact_reader_sas : "serviceAccount:${sa}"]
# }

# resource "google_artifact_registry_repository_iam_binding" "service_deployer_artifact_registry_writers" {
#   provider = google-beta
#   project  = module.platform.project_id

#   location   = module.platform.location
#   repository = module.platform.repository
#   role       = "roles/artifactregistry.writer"
#   members    = [for sa in local.artifact_writer_sas : "serviceAccount:${sa}"]
# }
