locals {
  member = "principalSet://iam.googleapis.com/${var.workload_identity_pool_name}/attribute.repository/${data.github_repository.repository.full_name}"
}

resource "google_service_account_iam_member" "workload_identity_sa_member" {
  for_each = toset([
    "roles/iam.workloadIdentityUser",
    "roles/iam.serviceAccountTokenCreator"
  ])

  service_account_id = google_service_account.sa.id
  role               = each.value

  member = local.member
}
