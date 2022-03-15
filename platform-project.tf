resource "google_project_service" "platform_project_services" {
  for_each = toset([
    "containerregistry.googleapis.com"
  ])

  project = data.google_project.platform_project.project_id
  service = each.value
}

resource "google_container_registry" "container_registry" {
  depends_on = [
    google_project_service.platform_project_services
  ]

  project  = data.google_project.platform_project.project_id
  location = "EU"
}

#tfsec:ignore:google-iam-no-privileged-service-accounts
resource "google_storage_bucket_iam_binding" "bodleian_service_deployer_gcr_iam_binding" {
  for_each = toset([
    "roles/storage.legacyBucketReader",
    "roles/storage.objectAdmin"
  ])

  bucket = google_container_registry.container_registry.id
  role   = each.value
  members = [
    "serviceAccount:${module.bodleian_service_deployer_service_account.service_account_email}"
  ]
}

# TODO set ACL on bucket!
# get bucket via data
# set acl


