locals {
  role_config = flatten([for project, config in local.projects : [for role in concat(local.common_roles, config.extra_roles) : { project = "${project}-${var.postfix}", role = role }]])
  api_config  = flatten([for project, config in local.projects : [for api in concat(local.common_apis, config.extra_apis) : { project = "${project}-${var.postfix}", api = api }]])
}

# resource "google_billing_project_info" "billing_info" {
#   for_each = local.projects

#   project         = each.key
#   billing_account = var.billing_account_id
# }

resource "google_project_service" "additional_apis" {
  count = length(local.api_config)

  project = local.api_config[count.index].project
  service = local.api_config[count.index].api
}

resource "google_project_iam_member" "project_iam_member" {
  count = length(local.role_config)

  project = local.role_config[count.index].project
  role    = local.role_config[count.index].role
  member  = "serviceAccount:${local.seed_service_account_email}"
}
