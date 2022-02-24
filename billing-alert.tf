resource "google_billing_budget" "overall_budget" {
  billing_account = data.google_billing_account.billing_account.id
  display_name    = "Overall budget"

  amount {
    specified_amount {
      currency_code = "EUR"
      units         = "20"
    }
  }

  threshold_rules {
    threshold_percent = 0.5
  }

  threshold_rules {
    threshold_percent = 0.8
  }
}

# resource "google_monitoring_notification_channel" "notification_channel" {
#   display_name = "Example Notification Channel"
#   type         = "email"

#   labels = {
#     email_address = "address@example.com"
#   }
# }