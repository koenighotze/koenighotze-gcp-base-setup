module "koenighotze_baseline" {
  source = "./modules/project"

  project_id   = "koenighotze-baseline-${random_integer.rand.result}"
  project_name = "Koenighotze Baseline"
}