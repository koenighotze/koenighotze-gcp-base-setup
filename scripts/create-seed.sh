#!/usr/bin/env bash
set -euo pipefail

BILLING_ACCOUNT=${1?Billing account missing}

# since Terraform cannot create projects without an organization,
# we use gcloud cli for the time being
gcloud projects create koenighotze-seed --name="Koenighotze Seed" --labels=purpose=seed
gcloud beta billing projects link koenighotze-seed --billing-account "${BILLING_ACCOUNT}"
gcloud services enable cloudresourcemanager.googleapis.com  --project koenighotze-seed
gsutil mb -l europe-west3 -p koenighotze-seed gs://koenighotze-seed