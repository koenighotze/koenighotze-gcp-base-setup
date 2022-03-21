resource "google_service_account" "bodleian_infrastructure_service_account" {
  project      = data.google_project.bodleian_project.project_id
  account_id   = "infra-setup-sa"
  display_name = "Infrastructure Setup Service Account"
  description  = "Service account for infrastructure activities on this project"
}

# This SA needs to be able to do some privileged work
#tfsec:ignore:google-iam-no-privileged-service-accounts
resource "google_project_iam_binding" "bodleian_infrastructure_iam_binding_project" {
  for_each = toset([
    "roles/logging.logWriter",
    "roles/viewer"
    # "roles/iam.serviceAccountAdmin"
    # "roles/iam.securityAdmin"
  ])
  project = data.google_project.bodleian_project.project_id
  role    = each.value

  members = [
    "serviceAccount:${google_service_account.bodleian_infrastructure_service_account.email}"
  ]
}

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
  additional_project_apis         = ["run.googleapis.com"]
}

