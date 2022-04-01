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
