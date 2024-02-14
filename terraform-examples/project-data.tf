data "google_project" "project" {
  project_id = "terraform-examples-${var.project_postfix}"
}
