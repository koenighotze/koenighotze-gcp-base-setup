# This SA is used by the bodleian-service to deploy resources
#tfsec:ignore:google-iam-no-privileged-service-accounts
module "backend_deployer_sa" {
  source = "github.com/koenighotze/gcp-tf-modules/deployer-service-account"

  name        = "bodleian-backend"
  project_id  = data.google_project.project.project_id
  description = "Service account for CICD for the backend part"
}

resource "google_project_iam_member" "cloud_run_deployer_binding" {
  for_each = toset([
    "roles/iam.serviceAccountUser",
    "roles/run.developer",
    "roles/viewer"
  ])

  project = data.google_project.project.project_id
  role    = each.key

  members = [
    "serviceAccount:${module.backend_deployer_sa.email}"
  ]
}


