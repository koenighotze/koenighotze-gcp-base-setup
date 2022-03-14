output "overall_budget_id" {
  value = google_billing_budget.overall_budget.id
}

output "bodleian_infrastructure_service_account_email" {
  value = google_service_account.bodleian_service_account.email
}

output "bodleian_service_deployer_service_account_email" {
  value = google_service_account.bodleian_service_deployer_service_account.email
}

# output "platform_service_account_email" {
#   value = google_service_account.platform_service_account.email
# }
