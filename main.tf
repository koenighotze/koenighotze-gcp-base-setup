terraform {
  backend "gcs" {
    prefix = "terraform/baseline/state"
  }
}

locals {
  common_labels = {
    environment = var.environment
  }
}
