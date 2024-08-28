terraform {
  backend "gcs" {
    # bucket = "koenighotze-seed-398addce"
    prefix = "terraform/baseline/state"
  }
}
