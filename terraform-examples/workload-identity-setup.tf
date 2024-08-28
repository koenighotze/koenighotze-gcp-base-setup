locals {
  member = "principalSet://iam.googleapis.com/projects/${var.seed_project_id}/locations/global/workloadIdentityPools/${var.workload_identity_pool_id}/attribute.repository/${data.github_repository.repository.full_name}"
}

# resource "google_service_account_iam_binding" "workload_identity_sa_binding" {
#   for_each = toset([
#     "roles/iam.workloadIdentityUser",
#     "roles/iam.serviceAccountTokenCreator"
#   ])

#   service_account_id = google_service_account.sa.id
#   role               = each.value

#   members = [
#     local.member
#   ]
# }

# # Allow repository to use deployer service account
# resource "google_service_account_iam_member" "gce-default-workload_identity_sa_member" {
#   service_account_id = google_service_account.sa.id
#   role               = "roles/iam.workloadIdentityUser"
#   member             = local.member
# }

resource "google_service_account_iam_member" "workload_identity_sa_member-a" {
  service_account_id = google_service_account.sa.id
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/projects/642340482178/locations/global/workloadIdentityPools/github-cicd-pool/attribute.repository/${data.github_repository.repository.full_name}" #local.member
}

resource "google_service_account_iam_member" "workload_identity_sa_member-b" {
  service_account_id = google_service_account.sa.id
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "principalSet://iam.googleapis.com/projects/642340482178/locations/global/workloadIdentityPools/github-cicd-pool/attribute.repository/${data.github_repository.repository.full_name}" #local.member
}
