locals {
  common_apis = [
    "cloudresourcemanager.googleapis.com",
    "billingbudgets.googleapis.com",
    "cloudbilling.googleapis.com",
    "compute.googleapis.com",
    "cloudasset.googleapis.com",
  ]
}

# This is created by gcloud cli, because Terraform / Service accounts need an organization
# resource "google_project" "project" {
#   name       = var.project_name
#   project_id = var.project_id
#   org_id     = ""
#   auto_create_network   = false
# }

resource "google_project_service" "common_project_services" {
  for_each                   = toset(local.common_apis)
  project                    = data.google_project.project.project_id
  service                    = each.value
  disable_dependent_services = true
}
