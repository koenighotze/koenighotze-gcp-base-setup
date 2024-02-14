module "terraform_examples" {
  source = "./terraform-examples"

  project_postfix = var.project_postfix

  workload_identity_provider_name = var.workload_identity_provider_name
  workload_identity_pool_id       = var.workload_identity_pool_id
}
