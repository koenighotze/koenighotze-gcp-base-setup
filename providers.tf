provider "google" {
  region = var.region
}

provider "github" {
  token = var.github_admin_token
}