#!/usr/bin/env bash
set -euo pipefail

BILLING_ACCOUNT=${1?Billing account missing}
POSTFIX=${2?Postfix missing}
SEED_PROJECT="koenighotze-seed-$POSTFIX"
SEED_REPOSITORY=koenighotze/koenighotze-gcp-base-setup

gcloud config set project "$SEED_PROJECT"

# since Terraform cannot create projects without an organization,
# we use gcloud cli for the time being
# gcloud projects create "koenighotze-seed-$POSTFIX" --name="Koenighotze Seed" --labels=purpose=seed
gcloud beta billing projects link  "$SEED_PROJECT" --billing-account "$BILLING_ACCOUNT"
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable cloudbilling.googleapis.com
gcloud services enable billingbudgets.googleapis.com
gcloud services enable iam.googleapis.com
gcloud services enable iamcredentials.googleapis.com
gsutil mb -l europe-west3 -p "$SEED_PROJECT" "gs://${SEED_PROJECT}"

gh secret set GCP_PROJECT_ID -R "${SEED_REPOSITORY}" -b "${SEED_PROJECT}"
gh secret set BILLING_ACCOUNT_ID -R "${SEED_REPOSITORY}" -b "${BILLING_ACCOUNT}"
gh secret set GCP_PROJECT_POSTFIX -R "${SEED_REPOSITORY}" -b "${POSTFIX}"
gh secret set TERRAFORM_STATE_BUCKET -R "${SEED_REPOSITORY}" -b "gs://${SEED_PROJECT}"

echo "Generated postfix: $POSTFIX"