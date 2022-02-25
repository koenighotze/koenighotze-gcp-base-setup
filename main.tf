terraform {
  backend "gcs" {
    bucket = "koenighotze-seed"
    prefix = "terraform/baseline/state"
  }
}

locals {
  common_labels = {
    environment = var.environment
  }
}
