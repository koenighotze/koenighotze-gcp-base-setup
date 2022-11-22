output "container_registry" {
  value = module.platform.container_registry
}

# output "bodleian_state_bucket_url" {
#   value = module.bodleian.state_bucket_url
# }

output "bodleian_infrastructure_sa_email" {
  value = module.bodleian.infrastructure_sa_email
}

output "bodleian_backend_deployer_sa_email" {
  value = module.bodleian.backend_deployer_sa_email
}

output "bodleian_frontend_deployer_sa_email" {
  value = module.bodleian.frontend_deployer_sa_email
}
