# This SA is used by the bodleian-service to deploy resources
module "bodleian_service_deployer_service_account" {
  source = "github.com/koenighotze/gcp-tf-modules/deployer-service-account"

  name       = "bodleian-service-tmp"
  project_id = data.google_project.bodleian_project.project_id
}

resource "google_service_account" "bodleian_backend_service_service_account" {
  project     = data.google_project.bodleian_project.project_id
  account_id  = "bodleian-backend-service"
  description = "Service account for running the backend part on Cloud Run"
}

# This SA needs to be able to do some privileged work
#tfsec:ignore:google-iam-no-privileged-service-accounts
resource "google_project_iam_binding" "bodleian_backend_service_iam_binding" {
  for_each = toset([
    "roles/viewer"
  ])
  project = data.google_project.bodleian_project.project_id
  role    = each.value

  members = [
    "serviceAccount:${google_service_account.bodleian_backend_service_service_account.email}"
  ]
}
