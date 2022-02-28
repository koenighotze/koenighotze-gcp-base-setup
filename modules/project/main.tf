locals {
  common_apis = [
    "cloudresourcemanager.googleapis.com",
    "billingbudgets.googleapis.com",
    "cloudbilling.googleapis.com"
  ]

  project_roles = [
    "roles/logging.logWriter"
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
}

resource "google_storage_bucket_iam_member" "bucket_iam_member" {
  bucket = google_storage_bucket.state_bucket.name
  role = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.service_account.email}"
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
  for_each = toset(local.project_roles)
  project  = var.project_id
  role     = each.value

  members = [
    "serviceAccount:${google_service_account.service_account.email}"
  ]
}
