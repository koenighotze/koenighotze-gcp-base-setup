resource "github_actions_secret" "secrets" {
  for_each = {
    "CICD_SA_EMAIL_ADDRESS"      = google_service_account.sa.email
    "CICD_SA_ID"                 = google_service_account.sa.id
    "GCP_PROJECT_ID"             = data.google_project.project.project_id
    "TERRAFORM_STATE_BUCKET"     = google_storage_bucket.state_bucket.name
    "WORKLOAD_IDENTITY_POOL_ID"  = var.workload_identity_pool_id
    "WORKLOAD_IDENTITY_PROVIDER" = var.workload_identity_provider_name
  }

  repository  = data.github_repository.repository.id
  secret_name = each.key
  #checkov:skip=CKV_GIT_4:Secrets are encrypted at rest in GitHub
  plaintext_value = each.value
}
