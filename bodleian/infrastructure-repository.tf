#trivy:ignore:avd-gcp-0066
#trivy:ignore:avd-git-0001
module "bodleian_project" {
  # tflint-ignore: terraform_module_pinned_source
  #checkov:skip=CKV_TF_1:No version for the module ref.
  #checkov:skip=CKV_TF_2:No version for the module ref.
  source = "git::https://github.com/koenighotze/gcp-tf-modules.git//infrastructure-project"

  project_id                      = data.google_project.project.project_id
  project_name                    = "bodleian"
  github_admin_token              = var.github_admin_token
  github_api_label_token          = var.github_api_label_token
  workload_identity_provider_name = var.workload_identity_provider_name
  workload_identity_pool_id       = var.workload_identity_pool_id
  codacy_api_token                = var.codacy_api_token
  container_registry              = var.container_registry
  service_account_email           = google_service_account.bodleian_infrastructure_service_account.email
}
