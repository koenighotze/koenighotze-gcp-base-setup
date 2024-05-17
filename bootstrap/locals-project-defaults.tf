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
}
