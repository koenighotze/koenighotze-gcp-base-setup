terraform {
  required_version = ">= 1.1.6"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0"
    }

    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.0"
    }

    github = {
      source  = "integrations/github"
      version = ">= 4.0"
    }
  }
}
