provider "github" {
}

provider "google" {
  default_labels = merge(local.default_labels, var.extra_labels)
}
