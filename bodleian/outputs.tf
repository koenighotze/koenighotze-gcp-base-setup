output "infrastructure_sa_email" {
  value = google_service_account.bodleian_infrastructure_service_account.email
}

# output "backend_deployer_sa_email" {
#   value = google_service_account.backend_deployer_sa.email
# }

# output "backend_service_sa_email" {
#   value = google_service_account.backend_service_sa.email
# }

# output "frontend_deployer_sa_email" {
#   value = module.frontend_deployer_sa.email
# }

# output "frontend_service_sa_email" {
#   value = google_service_account.frontend_service_sa.email
# }

output "state_bucket_url" {
  value = module.bodleian_project.state_bucket_url
}

output "cloudrun_sa_email" {
  value = "service-${data.google_project.project.number}@serverless-robot-prod.iam.gserviceaccount.com"
}

