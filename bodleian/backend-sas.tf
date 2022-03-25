# This SA is used by the bodleian-service to deploy resources
module "backend_deployer_sa" {
  source = "github.com/koenighotze/gcp-tf-modules/deployer-service-account"

  name       = "backend"
  project_id = data.google_project.bodleian_project.project_id

  additional_deployer_sa_roles = [
    "roles/iam.serviceAccountUser",
    "roles/run.developer",
  ]
}

resource "google_service_account" "backend_service_sa" {
  project     = data.google_project.bodleian_project.project_id
  account_id  = "backend-service"
  description = "Service account for running the backend part"
}

# This service must be able to run the backend as part of cloud run
resource "google_project_iam_binding" "bodleian_backend_service_iam_binding" {
  for_each = toset([
    "roles/logging.logWriter",
    "roles/iam.serviceAccountViewer",
    "roles/run.developer",
    "roles/viewer"
  ])
  project = data.google_project.bodleian_project.project_id
  role    = each.value

  members = [
    "serviceAccount:${google_service_account.backend_service_sa.email}"
  ]
}

resource "google_service_account_iam_binding" "backend_service_sa_user_iam_binding" {
  service_account_id = google_service_account.backend_service_sa.name
  role               = "roles/iam.serviceAccountUser"

  members = [
    "serviceAccount:${google_service_account.bodleian_infrastructure_service_account.email}"
  ]
}

# Allow repository to use deployer service account
resource "google_service_account_iam_binding" "bodleian_service_deployer_workload_identity_sa_binding" {
  service_account_id = module.backend_deployer_sa.name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "principalSet://iam.googleapis.com/${var.workload_identity_pool_id}/attribute.repository/${module.backend_repository.full_name}",
  ]
}