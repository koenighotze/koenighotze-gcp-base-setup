data "google_project" "project" {
  project_id = "bodleian-${var.project_postfix}"
}
