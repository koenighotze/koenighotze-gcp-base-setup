resource "google_service_account_iam_binding" "workload_identity_sa_binding" {
  for_each = toset([
    "roles/iam.workloadIdentityUser",
    "roles/iam.serviceAccountTokenCreator"
  ])

  service_account_id = google_service_account.sa.id
  role               = each.value

  members = [
    "principalSet://iam.googleapis.com/${var.workload_identity_pool_id}/attribute.repository/${data.github_repository.repository.full_name}"
  ]
}

# Allow repository to use deployer service account
resource "google_service_account_iam_member" "gce-default-workload_identity_sa_member" {
  service_account_id = google_service_account.sa.id
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${var.workload_identity_pool_id}/attribute.repository/${data.github_repository.repository.full_name}"
}

