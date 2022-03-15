# This SA is used by the bodleian-service to deploy resources
module "bodleian_service_deployer_service_account" {
  source = "github.com/koenighotze/gcp-tf-modules/deployer-service-account"

  name        = "bodleian-service-tmp"
  description = "This service account handles deployments"
  project_id  = data.google_project.bodleian_project.project_id
}

# Allow repository to use deployer service account
resource "google_service_account_iam_binding" "bodleian_service_deployer_workload_identity_sa_binding" {
  # this list must contain all repositories and their respective service account
  for_each = {
    (module.bodleian_service_deployer_service_account.service_account_id) = "koenighotze/bodleian-service-tmp"
  }

  service_account_id = each.key
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "principalSet://iam.googleapis.com/${var.workload_identity_pool_id}/attribute.repository/${each.value}",
  ]
}
