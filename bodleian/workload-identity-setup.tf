resource "google_service_account_iam_binding" "workload_identity_sa_binding" {
  for_each = toset([
    "roles/iam.workloadIdentityUser",
    "roles/iam.serviceAccountTokenCreator"
  ])

  service_account_id = google_service_account.backend_deployer_sa.id
  role               = each.value

  members = [
    "principalSet://iam.googleapis.com/${var.workload_identity_pool_id}/attribute.repository/koenighotze/bodleian-service"
  ]
}

resource "google_service_account_iam_binding" "workload_identity_frontend_deployer_sa_binding" {
  for_each = toset([
    "roles/iam.workloadIdentityUser",
    "roles/iam.serviceAccountTokenCreator"
  ])

  service_account_id = google_service_account.frontend_deployer_sa.id
  role               = each.value

  members = [
    "principalSet://iam.googleapis.com/${var.workload_identity_pool_id}/attribute.repository/koenighotze/bodleian-frontend"
  ]
}
