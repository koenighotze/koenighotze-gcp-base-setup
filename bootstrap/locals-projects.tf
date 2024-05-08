locals {
  projects = {
    "platform" = {
      extra_apis = [
        "artifactregistry.googleapis.com",
      ]

      extra_roles = [
        "roles/artifactregistry.admin",
      ]
    }

    "bodleian" = {
      extra_apis = [
        "run.googleapis.com",
      ]

      extra_roles = [
        "roles/iam.serviceAccountAdmin",
        "roles/resourcemanager.projectIamAdmin",
        "roles/storage.admin",
        "roles/monitoring.admin",
        "roles/serviceusage.serviceUsageAdmin"
      ]
    }

    "terraform-example" = {
      extra_apis = [
        "run.googleapis.com",
      ]

      extra_roles = [
        "roles/iam.serviceAccountAdmin",
        "roles/resourcemanager.projectIamAdmin",
        "roles/storage.admin",
        "roles/monitoring.admin",
        "roles/serviceusage.serviceUsageAdmin"
      ]
    }
  }
}
