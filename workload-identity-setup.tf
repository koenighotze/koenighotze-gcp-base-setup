# Allow repository to use seed service account
# resource "google_service_account_iam_binding" "workload_identity_sa_binding" {
#   service_account_id = data.google_service_account.sa.id
#   role               = "roles/iam.workloadIdentityUser"

#   members = [
#     "principalSet://iam.googleapis.com/${var.workload_identity_pool_id}/attribute.repository/${github_repository.infrastructure_repository.full_name}",
#   ]
# }

# # Allow repository to use deployer service account
# resource "google_service_account_iam_binding" "bodleian_service_deployer_workload_identity_sa_binding" {
#   # this list must contain all repositories and their respective service account
#   for_each = {
#     (data.google_service_account.sa.id)                                    = module.bodleian_project.github_repository_full_name
#     (google_service_account.bodleian_infrastructure_service_account.email) = module.bodleian_project.github_repository_full_name
#     (module.bodleian_service_deployer_service_account.service_account_id)  = "koenighotze/bodleian-service-tmp"
#   }

#   service_account_id = each.key
#   role               = "roles/iam.workloadIdentityUser"

#   members = [
#     "principalSet://iam.googleapis.com/${var.workload_identity_pool_id}/attribute.repository/${each.value}",
#   ]
# }
