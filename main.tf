terraform {
  backend "gcs" {
    bucket = "koenighotze-seed"
    prefix = "terraform/baseline/state"
  }
}


