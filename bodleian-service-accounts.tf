locals {
  project_roles = [
    "roles/logging.logWriter",
    "roles/viewer",
    # "roles/iam.serviceAccountKeyAdmin",
    # "roles/iam.serviceAccountAdmin",
    # "roles/iam.securityAdmin"
  ]

  project_id = "bodleian-${var.project_postfix}"
}

resource "google_service_account" "bodleian_infrastructure_service_account" {
  project      = local.project_id
  account_id   = "infra-setup-sa"
  display_name = "Infrastructure Setup Service Account"
  description  = "Service account for infrastructure activities on this project"
}

# This SA needs to be able to do some privileged work
#tfsec:ignore:google-iam-no-privileged-service-accounts
resource "google_project_iam_binding" "bodleian_infrastructure_service_accountiam_binding_project" {
  for_each = toset(local.project_roles)
  project  = local.project_id
  role     = each.value

  members = [
    "serviceAccount:${google_service_account.bodleian_infrastructure_service_account.email}"
  ]
}

# This SA is used by the bodleian-service to deploy resources
module "bodleian_service_deployer_service_account" {
  source = "github.com/koenighotze/gcp-tf-modules/deployer-service-account"

  name        = "bodleian-service-tmp"
  description = "This service account handles deployments"
  project_id  = local.project_id
}

# Allow repository to use deployer service account
resource "google_service_account_iam_binding" "workload_identity_sa_binding" {
  # this list must contain all repositories and their respective service account
  for_each = {
    module.bodleian_service_deployer_service_account.service_account_id = "koenighotze/bodleian-service-tmp"
  }

  service_account_id = each.key
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "principalSet://iam.googleapis.com/${var.workload_identity_pool_id}/attribute.repository/${each.value}",
  ]
}
