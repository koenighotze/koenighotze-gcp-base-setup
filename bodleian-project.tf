module "bodleian_project" {
  # tflint-ignore: terraform_module_pinned_source
  source = "github.com/koenighotze/gcp-tf-modules/infrastructure-project"

  project_id                      = data.google_project.bodleian_project.project_id
  project_name                    = "bodleian"
  github_admin_token              = var.github_admin_token
  github_api_label_token          = var.github_api_label_token
  workload_identity_provider_name = var.workload_identity_provider_name
  workload_identity_pool_id       = var.workload_identity_pool_id

  codacy_api_token         = var.codacy_api_token
  docker_registry_username = var.docker_registry_username
  docker_registry_token    = var.docker_registry_token
  container_registry       = "eu.gcr.io/${data.google_project.platform.project_id}"

  service_account_email = google_service_account.bodleian_infrastructure_service_account.email
}

resource "google_project_service" "bodleian_project_services" {
  for_each = toset([
    "run.googleapis.com"
  ])

  project = data.google_project.bodleian_project.project_id
  service = each.value
}






