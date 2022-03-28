resource "google_service_account_iam_binding" "workload_identity_sa_binding" {
  service_account_id = module.backend_deployer_sa.id
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "principalSet://iam.googleapis.com/${var.workload_identity_pool_id}/attribute.repository/${module.bodleian_project.github_repository_full_name}",
  ]
}
