# This SA is used by the bodleian-service to deploy resources
module "backend_deployer_sa" {
  source = "github.com/koenighotze/gcp-tf-modules/deployer-service-account"

  name       = "backend"
  project_id = data.google_project.bodleian_project.project_id
}

resource "google_service_account" "backend_service_sa" {
  project     = data.google_project.bodleian_project.project_id
  account_id  = "backend-service"
  description = "Service account for running the backend part"
}

# This service must be able to run the backend as part of cloud run
resource "google_project_iam_binding" "bodleian_backend_service_iam_binding" {
  for_each = toset([
    "roles/viewer",
  ])
  project = data.google_project.bodleian_project.project_id
  role    = each.value

  members = [
    "serviceAccount:${google_service_account.backend_service_sa.email}"
  ]
}
