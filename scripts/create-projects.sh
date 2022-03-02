#!/usr/bin/env bash
set -euo pipefail

BILLING_ACCOUNT=${1?Billing account missing}
SERVICE_ACCOUNT_EMAIL_ADDRESS=${2?Service account email address}

# since Terraform cannot create projects without an organization,
# we use gcloud cli for the time being
for projectId in bodleian platform; do
    echo "Project: $name"
    projectId="${name}"
    gcloud projects create "${projectId}" --name="Koenighotze $name"
    gcloud beta billing projects link "${projectId}" --billing-account "${BILLING_ACCOUNT}"
    gcloud projects add-iam-policy-binding "${projectId}" \
        --member="serviceAccount:${SERVICE_ACCOUNT_EMAIL_ADDRESS}" \
        --role="roles/owner"

    gcloud services enable cloudresourcemanager.googleapis.com --project "${projectId}"
    gcloud services enable cloudbilling.googleapis.com --project "${projectId}"
    gcloud services enable iam.googleapis.com --project "${projectId}"
done
