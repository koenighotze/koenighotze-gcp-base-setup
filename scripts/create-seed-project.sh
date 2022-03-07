#!/usr/bin/env bash
set -euo pipefail

BILLING_ACCOUNT=${1?Billing account missing}
SEED_PROJECT="${2:-koenighotze-seed}"

gcloud config set project "$SEED_PROJECT"

# since Terraform cannot create projects without an organization,
# we use gcloud cli for the time being
gcloud projects create koenighotze-seed --name="Koenighotze Seed" --labels=purpose=seed
gcloud beta billing projects link koenighotze-seed --billing-account "${BILLING_ACCOUNT}"
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable cloudbilling.googleapis.com
gcloud services enable billingbudgets.googleapis.com
gcloud services enable iam.googleapis.com
gcloud services enable iamcredentials.googleapis.com
gsutil mb -l europe-west3 -p koenighotze-seed gs://koenighotze-seed