locals {
  project_roles = [
    "roles/logging.logWriter",
    "roles/viewer",
    "roles/iam.serviceAccountKeyAdmin",
    "roles/iam.serviceAccountAdmin",
    "roles/iam.securityAdmin"
  ]

  bodleian_project_id = data.google_project.bodleian_project.project_id
}

resource "google_service_account" "bodleian_infrastructure_service_account" {
  project      = local.bodleian_project_id
  account_id   = "infra-setup-sa"
  display_name = "Infrastructure Setup Service Account"
  description  = "Service account for infrastructure activities on this project"
}

# This SA needs to be able to do some privileged work
#tfsec:ignore:google-iam-no-privileged-service-accounts
resource "google_project_iam_binding" "bodleian_infrastructure_iam_binding_project" {
  for_each = toset(local.project_roles)
  project  = local.bodleian_project_id
  role     = each.value

  members = [
    "serviceAccount:${google_service_account.bodleian_infrastructure_service_account.email}"
  ]
}
