locals {
  roles = [
    "roles/iam.workloadIdentityUser",
    "roles/iam.serviceAccountTokenCreator"
  ]

  repositories = [
    "koenighotze/bodleian-frontend",
    "koenighotze/bodleian-service"
  ]

  workload_identity_config = flatten([for repository in local.repositories : [for role in local.roles : { repository = repository, role = role }]])
}

resource "google_service_account_iam_binding" "workload_identity_frontend_deployer_sa_binding" {
  for_each = { for config in local.workload_identity_config : "${config.repository}-${config.role}" => config }

  service_account_id = google_service_account.frontend_deployer_sa.id
  role               = each.value.role

  members = [
    "principalSet://iam.googleapis.com/${var.workload_identity_pool_id}/attribute.repository/${each.value.repository}"
  ]
}
