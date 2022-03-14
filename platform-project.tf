resource "google_container_registry" "container_registry" {
  project  = data.google_project.platform_project
  location = "EU"
}

#tfsec:ignore:google-iam-no-privileged-service-accounts
resource "google_storage_bucket_iam_binding" "bodleian_service_deployer_gcr_iam_binding" {
  bucket = google_container_registry.container_registry.id
  role   = "roles/storage.objectAdmin"
  members = [
    "serviceAccount:${module.bodleian_service_deployer_service_account.service_email}"
  ]
}


