locals {
  project_names = [
    "bodleian"
  ]
}

module "koenighotze_baseline" {
  for_each = toset(local.project_names)
  # tflint-ignore: terraform_module_pinned_source
  source = "github.com/koenighotze/gcp-tf-modules/infrastructure-project"

  project_id                      = "${each.value}-${var.project_postfix}"
  project_name                    = each.value
  github_admin_token              = var.github_admin_token
  github_api_label_token          = var.github_api_label_token
  workload_identity_provider_name = var.workload_identity_provider_name
  workload_identity_pool_id       = var.workload_identity_pool_id
}
