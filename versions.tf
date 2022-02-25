terraform {
  required_version = ">= 1.1.6"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.52.0"
    }
  }
}
