# output "bodleian_infrastructure_service_account_email" {
#   value = google_service_account.bodleian_infrastructure_service_account.email
# }

# output "bodleian_backend_deployer_service_account_email" {
#   value = module.backend_deployer_sa.email
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

output "container_registry" {
  value = module.platform.container_registry
}

output "bodleian_state_bucket_url" {
  value = module.bodleian.state_bucket_url
}

output "bodleian_infrastructure_sa_email" {
  value = module.bodleian.infrastructure_sa_email
}

output "bodleian_backend_deployer_sa_email" {
  value = module.bodleian.backend_deployer_sa_email
}
