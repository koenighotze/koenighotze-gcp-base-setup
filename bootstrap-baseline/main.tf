terraform {
  backend "gcs" {
    bucket = "koenighotze-baseline"
    prefix = "terraform/baseline-bootstrap/state"
  }
}


