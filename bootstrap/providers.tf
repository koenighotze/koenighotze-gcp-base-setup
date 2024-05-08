# provider "google-beta" {
#   region = var.region
# }

provider "github" {
}

provider "google" {
  default_labels = local.default_labels
}

provider "random" {
}
