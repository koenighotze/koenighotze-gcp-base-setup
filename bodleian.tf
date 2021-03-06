module "bodleian" {
  source = "./bodleian"

  project_postfix = var.project_postfix

  github_admin_token              = var.github_admin_token
  github_api_label_token          = var.github_api_label_token
  workload_identity_provider_name = var.workload_identity_provider_name
  workload_identity_pool_id       = var.workload_identity_pool_id
  codacy_api_token                = var.codacy_api_token
  container_registry              = module.platform.container_registry
}
