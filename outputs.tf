# output "bodleian_infrastructure_service_account_email" {
#   value = google_service_account.bodleian_infrastructure_service_account.email
# }

# output "bodleian_backend_deployer_service_account_email" {
#   value = module.backend_deployer_sa.email
# }

# output "container_registry" {
#   value = "${google_artifact_registry_repository.docker.location}-docker.pkg.dev/${data.google_project.platform_project.project_id}/${google_artifact_registry_repository.docker.name}"
# }

# output "bodleian_backend_service_service_account_email" {
#   value = google_service_account.backend_service_sa.email
# }

# output "bodleian_backend_repository_full_name" {
#   value = module.backend_repository.full_name
# }

# output "bodleian_infrastructure_repository_full_name" {
#   value = module.bodleian_project.github_repository_full_name
# }
