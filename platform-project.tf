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

data "google_iam_policy" "deployer_policy" {
  binding {
    role = "roles/storage.legacyBucketWriter"

    members = [
      "serviceAccount:${module.bodleian_service_deployer_service_account.service_account_email}"
    ]
  }

  binding {
    role = "roles/storage.legacyBucketReader"

    members = [
      "serviceAccount:${module.bodleian_service_deployer_service_account.service_account_email}"
    ]
  }
}

resource "google_storage_bucket_iam_policy" "policy" {
  bucket      = google_container_registry.container_registry.id
  policy_data = data.google_iam_policy.deployer_policy.policy_data
}


#tfsec:ignore:google-iam-no-privileged-service-accounts
# resource "google_storage_bucket_iam_binding" "bodleian_service_deployer_gcr_iam_binding" {
#   for_each = toset([
#     "roles/storage.legacyBucketWriter",
#     "roles/storage.objectAdmin"
#   ])

#   bucket = google_container_registry.container_registry.id
#   role   = each.value
#   members = [
#     "serviceAccount:${module.bodleian_service_deployer_service_account.service_account_email}"
#   ]
# }

# get bucket via data
# set acl


