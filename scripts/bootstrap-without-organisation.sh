#!/usr/bin/env bash
set -euo pipefail

BILLING_ACCOUNT=${1?Billing account missing}

# since Terraform cannot create projects without an organization,
# we use gcloud cli for the time being
gcloud projects create koenighotze-baseline --name="Baseline" --labels=purpose=baseline
gcloud beta billing projects link koenighotze-baseline --billing-account "${BILLING_ACCOUNT}"
gsutil mb -l europe-west3 -p koenighotze-baseline gs://koenighotze-baseline

gcloud projects create koenighotze-bodleian --name="Bodleian" --labels=purpose=project
gcloud beta billing projects link koenighotze-bodleian --billing-account "${BILLING_ACCOUNT}"
