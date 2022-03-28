# # Allow repository to use deployer service account
# resource "google_service_account_iam_binding" "bodleian_service_deployer_workload_identity_sa_binding" {
#   service_account_id = module.backend_deployer_sa.name
#   role               = "roles/iam.workloadIdentityUser"

#   members = [
#     "principalSet://iam.googleapis.com/${var.workload_identity_pool_id}/attribute.repository/${module.backend_repository.full_name}",
#   ]
# }