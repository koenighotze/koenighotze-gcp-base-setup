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
    "roles/run.developer"
  ])
  project = data.google_project.bodleian_project.project_id
  role    = each.value

  members = [
    "serviceAccount:${google_service_account.backend_service_sa.email}"
  ]
}

module "backend_repository" {
  source = "github.com/koenighotze/gcp-tf-modules/github-repository"

  target_repository_name          = "bodleian-service-${random_integer.rand.result}"
  codacy_api_token                = var.codacy_api_token
  docker_registry_username        = "" # does not use docker hub
  docker_registry_token           = "" # does not use docker hub
  project_id                      = data.google_project.bodleian_project.project_id
  workload_identity_provider_name = var.workload_identity_provider_name
  workload_identity_pool_id       = var.workload_identity_pool_id
  deployer_service_account_email  = module.backend_deployer_sa.email
  github_admin_token              = var.github_admin_token
  github_non_admin_token          = var.github_api_label_token
  terraform_state_bucket          = module.bodleian_project.state_bucket_url
  container_registry              = "${google_artifact_registry_repository.docker.location}-docker.pkg.dev/${data.google_project.platform_project.project_id}/${google_artifact_registry_repository.docker.name}"
}

# Allow repository to use deployer service account
resource "google_service_account_iam_binding" "bodleian_service_deployer_workload_identity_sa_binding" {
  service_account_id = module.backend_deployer_sa.name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "principalSet://iam.googleapis.com/${var.workload_identity_pool_id}/attribute.repository/${module.backend_repository.full_name}",
  ]
}
