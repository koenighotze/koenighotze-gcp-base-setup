# resource "google_service_account" "bodleian_infrastructure_service_account" {
#   project      = data.google_project.bodleian_project.project_id
#   account_id   = "infra-setup-sa"
#   display_name = "Infrastructure Setup Service Account"
#   description  = "Service account for infrastructure activities on this project"
# }

# # This SA needs to be able to do some privileged work
# #tfsec:ignore:google-iam-no-privileged-service-accounts
# resource "google_project_iam_binding" "bodleian_infrastructure_iam_binding_project" {
#   for_each = toset([
#     "roles/logging.logWriter",
#     "roles/iam.serviceAccountViewer",
#     "roles/run.admin",
#     "roles/viewer"
#   ])
#   project = data.google_project.bodleian_project.project_id
#   role    = each.value

#   members = [
#     "serviceAccount:${google_service_account.bodleian_infrastructure_service_account.email}"
#   ]
# }
