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
        "roles/storage.admin",
        "roles/monitoring.admin",
      ]
    }

    "terraform-examples" = {
      extra_apis = [
        "billingbudgets.googleapis.com",
        "cloudasset.googleapis.com",
        "compute.googleapis.com",
        "iap.googleapis.com",
        "networkmanagement.googleapis.com",
        "run.googleapis.com",
      ]

      extra_roles = [
        "roles/iam.serviceAccountAdmin",
        "roles/storage.admin",
        "roles/monitoring.admin",
      ]
    }
  }
}
