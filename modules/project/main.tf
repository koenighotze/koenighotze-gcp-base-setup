locals {
  common_apis = [
    "cloudresourcemanager.googleapis.com",
    "billingbudgets.googleapis.com",
    "cloudbilling.googleapis.com"
  ]
}

resource "google_project" "project" {
  name       = var.project_name
  project_id = var.project_id
  org_id     = ""
}

resource "google_project_service" "common_project_services" {
  for_each                   = toset(local.common_apis)
  project                    = google_project.project.project_id
  service                    = each.value
  disable_on_destroy         = true
  disable_dependent_services = true
}