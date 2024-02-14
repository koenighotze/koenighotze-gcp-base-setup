output "project_id" {
  value = data.google_project.project.project_id
}

output "service_account_email" {
  value = google_service_account.sa.email
}
