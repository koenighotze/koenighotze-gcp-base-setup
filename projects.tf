locals {
  project_names = [
    "platform",
    "bodleian"
  ]
}

module "koenighotze_baseline" {
  for_each = toset(local.project_names)
  source   = "./modules/project"

  project_id         = "${each.value}-${var.postfix}"
  project_name       = each.value
  github_admin_token = var.github_admin_token
}
