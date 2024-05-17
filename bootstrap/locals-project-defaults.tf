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

  # which common roles should the seed SA have in the child project
  common_roles = [
    "roles/iam.serviceAccountAdmin",
    "roles/serviceusage.serviceUsageAdmin",
    "roles/resourcemanager.projectIamAdmin"
  ]
}
