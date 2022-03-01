locals {
  repository_name = "${var.github_org_name}/${var.project_name}-infrastructure-tmp"
}

resource "github_repository" "infrastructure_repository" {
  name        = local.repository_name
  description = "Infrastructure for ${var.project_name}"

  #tfsec:ignore:github-repositories-private
  visibility = "public"
}

resource "github_actions_secret" "cicd_cloudrun_sa_secret" {
  repository      = github_repository.infrastructure_repository.id
  secret_name     = "GCP_SA_KEY"
  plaintext_value = google_service_account_key.key.private_key
}

resource "github_actions_secret" "gcp_projectid_secret" {
  repository      = github_repository.infrastructure_repository.id
  secret_name     = "GCP_PROJECT_ID"
  plaintext_value = var.project_id
}

# resource "github_actions_secret" "docker_registry_token" {
#   repository      = github_repository.infrastructure_repository.id
#   secret_name     = "DOCKER_REGISTRY_TOKEN"
#   plaintext_value = var.docker_registry_token
# }

# resource "github_actions_secret" "docker_registry_username" {
#   repository      = github_repository.infrastructure_repository.id
#   secret_name     = "DOCKER_REGISTRY_USERNAME"
#   plaintext_value = var.docker_registry_username
# }

# resource "github_actions_secret" "codacy_api_token" {
#   repository      = github_repository.infrastructure_repository.id
#   secret_name     = "CODACY_API_TOKEN"
#   plaintext_value = var.codacy_api_token
# }
