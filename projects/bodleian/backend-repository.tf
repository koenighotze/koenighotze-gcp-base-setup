# module "backend_repository" {
#   source = "github.com/koenighotze/gcp-tf-modules/github-repository"

#   target_repository_name          = "bodleian-service-${random_integer.rand.result}"
#   codacy_api_token                = var.codacy_api_token
#   docker_registry_username        = "" # does not use docker hub
#   docker_registry_token           = "" # does not use docker hub
#   project_id                      = data.google_project.bodleian_project.project_id
#   workload_identity_provider_name = var.workload_identity_provider_name
#   workload_identity_pool_id       = var.workload_identity_pool_id
#   deployer_service_account_email  = module.backend_deployer_sa.email
#   github_admin_token              = var.github_admin_token
#   github_non_admin_token          = var.github_api_label_token
#   terraform_state_bucket          = module.bodleian_project.state_bucket_url
#   container_registry              = var.container_registry
# }
