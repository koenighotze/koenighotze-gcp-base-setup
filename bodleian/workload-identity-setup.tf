resource "google_service_account_iam_binding" "workload_identity_backend_sa_binding" {
  service_account_id = module.backend_deployer_sa.id
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "principalSet://iam.googleapis.com/${var.workload_identity_pool_id}/attribute.repository/koenighotze/infrastructure-${data.google_project.project.project_id}",
    "principalSet://iam.googleapis.com/${var.workload_identity_pool_id}/attribute.repository/koenighotze/bodleian-service"
  ]
}

resource "google_service_account_iam_binding" "workload_identity_frontend_sa_binding" {
  service_account_id = module.frontend_deployer_sa.id
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "principalSet://iam.googleapis.com/${var.workload_identity_pool_id}/attribute.repository/koenighotze/infrastructure-${data.google_project.project.project_id}",
    "principalSet://iam.googleapis.com/${var.workload_identity_pool_id}/attribute.repository/koenighotze/bodleian-frontend"
  ]
}

