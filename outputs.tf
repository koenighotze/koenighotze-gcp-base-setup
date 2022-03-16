output "overall_budget_id" {
  value = google_billing_budget.overall_budget.id
}

output "bodleian_infrastructure_service_account_email" {
  value = google_service_account.bodleian_infrastructure_service_account.email
}

output "bodleian_service_deployer_service_account_email" {
  value = module.bodleian_service_deployer_service_account.service_account_email
}

output "docker_registry" {
  value = "${google_artifact_registry_repository.docker.location}-docker.pkg.dev/${data.google_project.platform_project.project_id}"
}
