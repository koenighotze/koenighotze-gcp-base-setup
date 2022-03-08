#!/usr/bin/env bash
set -euo pipefail

GENERATED_ID=$(uuidgen | tr '[A-Z]' '[a-z]' | cut -c-8)
: "${POSTFIX:=$GENERATED_ID}"
BILLING_ACCOUNT=${1?Billing account missing}
SERVICE_ACCOUNT_EMAIL_ADDRESS=${2?Service account email address}
SEED_REPOSITORY=koenighotze/koenighotze-gcp-base-setup

# since Terraform cannot create projects without an organization,
# we use gcloud cli for the time being
for projectId in bodleian platform; do
    projectId="${projectId}-${POSTFIX}"
    echo "Project: $projectId"
    # TODO remove auto create default network
    gcloud projects create "${projectId}" --name="Koenighotze $projectId"
    gcloud beta billing projects link "${projectId}" --billing-account "${BILLING_ACCOUNT}"
    gcloud projects add-iam-policy-binding "${projectId}" \
        --member="serviceAccount:${SERVICE_ACCOUNT_EMAIL_ADDRESS}" \
        --role="roles/owner"

    gcloud services enable cloudresourcemanager.googleapis.com --project "${projectId}"
    gcloud services enable cloudbilling.googleapis.com --project "${projectId}"
    gcloud services enable iam.googleapis.com --project "${projectId}"
done

gh secret set GCP_PROJECT_POSTFIX -R "${SEED_REPOSITORY}" -b "${POSTFIX}"
echo "Overall id is ${POSTFIX}. Use this when deleting."
