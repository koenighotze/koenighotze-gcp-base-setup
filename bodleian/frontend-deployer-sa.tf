# This SA is used by the bodleian-service to deploy resources
#tfsec:ignore:google-iam-no-privileged-service-accounts
module "frontend_deployer_sa" {
  source = "github.com/koenighotze/gcp-tf-modules/deployer-service-account"

  name        = "bodleian-frontend"
  project_id  = data.google_project.project.project_id
  description = "Service account for CICD for the frontend part"
}

#tfsec:ignore:google-iam-no-privileged-service-accounts tfsec:ignore:google-iam-no-project-level-service-account-impersonation
resource "google_project_iam_member" "frontend_deployer_sa_binding" {
  for_each = toset([
    "roles/iam.serviceAccountUser",
    "roles/run.developer",
    "roles/viewer"
  ])

  project = data.google_project.project.project_id
  role    = each.key
  member  = "serviceAccount:${module.frontend_deployer_sa.email}"
}


