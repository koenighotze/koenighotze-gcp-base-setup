terraform {
  backend "gcs" {
    # bucket = "koenighotze-seed-398addce"
    prefix = "terraform/baseline/state"
  }
}

locals {
  common_labels = {
    environment = var.environment
  }
}
