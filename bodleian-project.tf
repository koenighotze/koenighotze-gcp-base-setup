module "bodleian_project" {
  # tflint-ignore: terraform_module_pinned_source
  source = "github.com/koenighotze/gcp-tf-modules/infrastructure-project"

  project_id                      = data.google_project.bodleian_project.project_id
  project_name                    = "bodleian"
  github_admin_token              = var.github_admin_token
  github_api_label_token          = var.github_api_label_token
  workload_identity_provider_name = var.workload_identity_provider_name
  workload_identity_pool_id       = var.workload_identity_pool_id
  codacy_api_token                = var.codacy_api_token
  docker_registry_username        = var.docker_registry_username
  docker_registry_token           = var.docker_registry_token
  container_registry              = "${google_artifact_registry_repository.docker.location}-docker.pkg.dev/${data.google_project.platform_project.project_id}/${google_artifact_registry_repository.docker.name}"
  service_account_email           = google_service_account.bodleian_infrastructure_service_account.email
  # additional_project_apis         = ["run.googleapis.com"]
}

# resource "github_actions_secret" "bodleian_project_extra_secrets" {
#   for_each = {
#     "BODLEIAN_BACKEND_SERVICE_SERVICE_ACCOUNT_EMAIL_ADDRESS" = google_service_account.bodleian_backend_service_service_account.email
#   }

#   repository      = module.bodleian_project.github_repository_full_name
#   secret_name     = each.key
#   plaintext_value = each.value
# }






