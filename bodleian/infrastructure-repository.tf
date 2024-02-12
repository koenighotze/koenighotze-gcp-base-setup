# module "bodleian_project" {
#   # tflint-ignore: terraform_module_pinned_source
#   source = "github.com/koenighotze/gcp-tf-modules/infrastructure-project"

#   project_id                      = data.google_project.project.project_id
#   project_name                    = "bodleian"
#   github_admin_token              = var.github_admin_token
#   github_api_label_token          = var.github_api_label_token
#   workload_identity_provider_name = var.workload_identity_provider_name
#   workload_identity_pool_id       = var.workload_identity_pool_id
#   codacy_api_token                = var.codacy_api_token
#   container_registry              = var.container_registry
#   service_account_email           = google_service_account.bodleian_infrastructure_service_account.email
# }
# # 
