locals {
  // Define a map of default projects with their associated APIs and roles
  default_projects = {
    "platform" = {
      // List of extra APIs to be enabled for the project
      extra_apis = [
        "artifactregistry.googleapis.com",
      ]

      // List of extra roles to be assigned to the service account for the project
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

  // If no project configuration is provided, use the default projects. Otherwise, use the provided configuration.
  projects = length(var.projects_config) == 0 ? local.default_projects : var.projects_config
}
