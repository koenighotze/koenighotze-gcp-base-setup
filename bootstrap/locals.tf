locals {
  default_labels = {
    purpose = "koenighotze"
    owner   = "koenighotze"
  }

  common_apis = [
    "iam.googleapis.com",
    "cloudbilling.googleapis.com",
    "cloudresourcemanager.googleapis.com",
  ]

  common_roles = [
    "roles/serviceusage.serviceUsageAdmin",
    "roles/resourcemanager.projectIamAdmin"
  ]

  seed_project_id            = "${var.seed_project}-${var.postfix}"
  seed_repository            = "koenighotze/koenighotze-gcp-base-setup"
  seed_service_account_email = "koenighotze-seed-sa@${local.seed_project_id}.iam.gserviceaccount.com"
}
