terraform {
  required_version = "~> 1.8.0"

  backend "gcs" {
    # bucket = "" passed via cli
    prefix = "terraform/projects/state"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }

    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}
