# locals {
#   github_issuer_uri = "https://token.actions.githubusercontent.com"
#   attribute_mapping = {
#     "google.subject"       = "assertion.sub",
#     "attribute.actor"      = "assertion.actor",
#     "attribute.repository" = "assertion.repository"
#   }
# }

# resource "google_iam_workload_identity_pool" "github_cicd" {
#   project = local.seed_project_id

#   workload_identity_pool_id = var.workload_identity_pool_id
#   display_name              = "WIP for GitHub CI/CD"
#   disabled                  = false
# }

# resource "google_iam_workload_identity_pool_provider" "github_cicd_oidc" {
#   project = local.seed_project_id

#   workload_identity_pool_id          = google_iam_workload_identity_pool.github_cicd.workload_identity_pool_id
#   workload_identity_pool_provider_id = var.workload_identity_pool_provider_id
#   display_name                       = "GitHub OIDC provider"
#   disabled                           = false
#   attribute_mapping                  = local.attribute_mapping

#   oidc {
#     issuer_uri = local.github_issuer_uri
#   }
# }

# resource "google_project_iam_member" "workload_identity_user" {
#   project = local.seed_project_id

#   role   = "roles/iam.workloadIdentityUser"
#   member = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_cicd.id}/attribute.repository/${local.seed_repository}"
# }


# locals {
#   secrets = {
#     "WORKLOAD_IDENTITY_PROVIDER" = var.workload_identity_pool_provider_id,
#     "WORKLOAD_IDENTITY_POOL_ID"  = var.workload_identity_pool_id
#   }
# }

# resource "github_actions_secret" "secrets" {
#   for_each = local.secrets

#   repository      = local.seed_repository
#   secret_name     = each.key
#   plaintext_value = each.value
# }
