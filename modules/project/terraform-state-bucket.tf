resource "google_storage_bucket" "state_bucket" {
  #checkov:skip=CKV_GCP_62:Logging deactivated for now
  project                     = var.project_id
  name                        = "${var.project_id}-state"
  location                    = var.location
  uniform_bucket_level_access = true

  versioning {
    enabled = false
  }
}

resource "google_storage_bucket_iam_member" "bucket_iam_member" {
  bucket = google_storage_bucket.state_bucket.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.service_account.email}"
}
