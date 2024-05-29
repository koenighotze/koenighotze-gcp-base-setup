module "platform" {
  source = "./platform"

  project_id = "platform-${var.project_postfix}"
}
