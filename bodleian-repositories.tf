locals {
  repository_name = "bodleian-service-${random_integer.rand.result}"
}

module "backend_repository" {
  source = "github.com/koenighotze/gcp-tf-modules/github-repository"

  target_repository_name          = local.repository_name
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
  # this list must contain all repositories and their respective service account
  for_each = {
    (module.backend_deployer_sa.name) = module.backend_repository.full_name
    # (data.google_service_account.sa.name)            = module.backend_repository.full_name
  }

  service_account_id = each.key
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "principalSet://iam.googleapis.com/${var.workload_identity_pool_id}/attribute.repository/${each.value}",
  ]
}
