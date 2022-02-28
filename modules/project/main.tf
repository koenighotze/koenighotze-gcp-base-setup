locals {
  common_apis = [
    "cloudresourcemanager.googleapis.com",
    "billingbudgets.googleapis.com",
    "cloudbilling.googleapis.com"
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
  project                    = var.project_id
  service                    = each.value
  disable_on_destroy         = true
  disable_dependent_services = true
}

resource "google_project_iam_audit_config" "audit" {
  project = var.project_id
  service = "allServices"

  audit_log_config {
    log_type = "ADMIN_READ"
  }

  audit_log_config {
    log_type = "DATA_READ"
  }
}

resource "google_storage_bucket" "state_bucket" {
  #checkov:skip=CKV_GCP_62:Logging deactivated for now
  project                     = var.project_id
  name                        = "${var.project_id}-state"
  location                    = var.location
  uniform_bucket_level_access = true

  versioning {
    enabled = false
  }

  # labels = merge(local.common_labels, { name = "${var.environment}-rtb" })
}

resource "google_service_account" "service_account" {
  project      = var.project_id
  account_id   = "infra-setup-sa"
  display_name = "Service account for infrastructure activities on this project"
}

resource "google_service_account_key" "key" {
  service_account_id = google_service_account.service_account.name
}

resource "google_project_iam_binding" "iam_binding_project" {
  project = var.project_id
  role    = "roles/editor"

  members = [
    "serviceAccount:${google_service_account.service_account.email}"
  ]
}

esource "google_service_account_iam_member" "gce-default-account-iam" {
  service_account_id = data.google_compute_default_service_account.default.name
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${google_service_account.sa.email}"
}
