# # This SA needs to be able to do some privileged work
# #tfsec:ignore:google-iam-no-privileged-service-accounts
# #checkov:skip=CKV_GCP_117:Allow admin for this bucket
# resource "google_project_iam_binding" "project_iam_binding" {
#   for_each = toset([
#     "roles/storage.admin"
#   ])
#   project = data.google_project.project.project_id
#   role    = "roles/storage.admin"

#   #tfsec:ignore:google-iam-no-privileged-service-accounts
#   members = [
#     "serviceAccount:${google_service_account.sa.email}",
#     "serviceAccount:${var.admin_sa_email}"
#   ]
# }
