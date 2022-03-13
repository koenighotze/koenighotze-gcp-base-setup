# locals {
#   project_id = "platform-${var.project_postfix}"
# }

# module "platform_project" {
#   # tflint-ignore: terraform_module_pinned_source
#   source = "github.com/koenighotze/gcp-tf-modules/infrastructure-project"

#   project_id                      = local.project_id
#   project_name                    = "Platform"
#   github_admin_token              = ""
#   github_api_label_token          = ""
#   workload_identity_provider_name = var.workload_identity_provider_name
#   workload_identity_pool_id       = var.workload_identity_pool_id

#   codacy_api_token         = ""
#   docker_registry_username = ""
#   docker_registry_token    = ""
# }

# # GCR
# resource "google_container_registry" "registry" {
#   project  = local.project_id
#   location = "EU"
# }



# # Platform:
# # - GCR
# # - Cloud Build
# # - Monitoring?
