# This SA needs to be able to do some privileged work
resource "google_project_iam_member" "seed_platform_iam_member_project" {
  for_each = toset([
    "roles/storage.admin"
  ])
  project = data.google_project.platform_project.project_id
  role    = "roles/storage.admin"

  member = "serviceAccount:${var.admin_sa_email}"
}
