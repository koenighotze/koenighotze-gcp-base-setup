
locals {
  activate_apis = [
    "cloudresourcemanager.googleapis.com",
    "billingbudgets.googleapis.com"
  ]
}

resource "google_project_service" "baseline_project_services" {
  for_each                   = toset(local.activate_apis)
  project                    = data.google_project.project_baseline.project_id
  service                    = each.value
  disable_on_destroy         = true
  disable_dependent_services = true
}