module "bodleian" {
  source = "./bodleian"

  project_id = local.bodleian_project_id

  github_admin_token              = var.github_admin_token
  workload_identity_provider_name = var.workload_identity_provider_name
  workload_identity_pool_id       = var.workload_identity_pool_id
  codacy_api_token                = var.codacy_api_token
  container_registry              = module.platform.container_registry
}
