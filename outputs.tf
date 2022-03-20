output "overall_budget_id" {
  value = google_billing_budget.overall_budget.id
}

output "bodleian_infrastructure_service_account_email" {
  value = google_service_account.bodleian_infrastructure_service_account.email
}

output "backend_deployer_service_account_email" {
  value = module.backend_deployer_sa.email
}

output "container_registry" {
  value = "${google_artifact_registry_repository.docker.location}-docker.pkg.dev/${data.google_project.platform_project.project_id}/${google_artifact_registry_repository.docker.name}"
}

output "bodleian_backend_service_service_account_email" {
  value = google_service_account.backend_service_sa.email
}

