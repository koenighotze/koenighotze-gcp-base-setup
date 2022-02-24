terraform {
  backend "gcs" {
    bucket = "koenighotze"
    prefix = "terraform/organization/state"
  }
}


