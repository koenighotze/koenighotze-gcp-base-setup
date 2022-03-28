# This SA is used by the bodleian-service to deploy resources
module "backend_deployer_sa" {
  source = "github.com/koenighotze/gcp-tf-modules/deployer-service-account"

  name       = "backend"
  project_id = data.google_project.project.project_id

  additional_deployer_sa_roles = [
    "roles/iam.serviceAccountUser",
    "roles/run.developer"
  ]
}
