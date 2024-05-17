locals {
  seed_project_id            = "${var.seed_project}-${var.postfix}"
  seed_repository            = "koenighotze/koenighotze-gcp-base-setup"
  seed_service_account_email = "koenighotze-seed-sa@${local.seed_project_id}.iam.gserviceaccount.com"
}
