terraform {
  backend "gcs" {
    # bucket = passed in via commandline
    prefix = "terraform/bodleian/state"
  }
}
