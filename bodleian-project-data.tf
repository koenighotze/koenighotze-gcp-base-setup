data "google_project" "bodleian_project" {
  project_id = "bodleian-${var.project_postfix}"
}
