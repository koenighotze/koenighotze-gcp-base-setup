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


# resource "google_iam_workload_identity_pool" "main" {
#   provider                  = google-beta
#   project                   = var.project_id
#   workload_identity_pool_id = var.pool_id
#   display_name              = var.pool_display_name
#   description               = var.pool_description
#   disabled                  = false
# }

# resource "google_iam_workload_identity_pool_provider" "main" {
#   provider                           = google-beta
#   project                            = var.project_id
#   workload_identity_pool_id          = google_iam_workload_identity_pool.main.workload_identity_pool_id
#   workload_identity_pool_provider_id = var.provider_id
#   display_name                       = var.provider_display_name
#   description                        = var.provider_description
#   attribute_condition                = var.attribute_condition
#   attribute_mapping                  = var.attribute_mapping
#   oidc {
#     allowed_audiences = var.allowed_audiences
#     issuer_uri        = var.issuer_uri
#   }
# }


# module "gh_oidc" {
#   source      = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
#   project_id  = var.project_id
#   pool_id     = "example-pool"
#   provider_id = "example-gh-provider"
#   sa_mapping = {
#     "foo-service-account" = {
#       sa_name   = "projects/my-project/serviceAccounts/foo-service-account@my-project.iam.gserviceaccount.com"
#       attribute = "attribute.repository/${USER/ORG}/<repo>"
#     }
#   }
# }

# resource "google_service_account_iam_member" "wif-sa" {
#   for_each           = var.sa_mapping
#   service_account_id = each.value.sa_name
#   role               = "roles/iam.workloadIdentityUser"
#   member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.main.name}/${each.value.attribute}"
# }
