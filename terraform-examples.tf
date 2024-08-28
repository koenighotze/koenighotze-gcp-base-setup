module "terraform_examples" {
  source = "./terraform-examples"

  project_id = local.terraform_examples_project_id

  workload_identity_provider_name = var.workload_identity_provider_name
  workload_identity_pool_name     = var.workload_identity_pool_name
  admin_sa_email                  = var.seed_sa_email
}
