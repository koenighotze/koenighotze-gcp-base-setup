resource "google_project_iam_audit_config" "audit" {
  project = data.google_project.platform_project.project_id
  service = "allServices"

  audit_log_config {
    log_type = "ADMIN_READ"
  }

  audit_log_config {
    log_type = "DATA_READ"
  }
}

resource "google_project_service" "platform_project_services" {
  for_each = toset([
    "artifactregistry.googleapis.com"
  ])

  project = data.google_project.platform_project.project_id
  service = each.value

  disable_on_destroy = true
}
