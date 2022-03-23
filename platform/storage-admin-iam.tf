# This SA needs to be able to do some privileged work
#tfsec:ignore:google-iam-no-privileged-service-accounts
resource "google_project_iam_binding" "seed_platform_iam_binding_project" {
  for_each = toset([
    "roles/storage.admin"
  ])
  project = data.google_project.platform_project.project_id
  role    = each.value

  members = [
    "serviceAccount:${var.admin_sa_email}"
  ]
}
