#!/usr/bin/env bash
set -euo pipefail

BILLING_ACCOUNT=${1?Billing account missing}
POSTFIX=${2?Postfix missing}

# since Terraform cannot create projects without an organization,
# we use gcloud cli for the time being
for projectId in bodleian platform; do
    projectId="${projectId}-${POSTFIX}"
    echo "Project: $projectId"
    # TODO remove auto create default network
    # gcloud projects create "${projectId}" --name="Koenighotze $projectId"
    gcloud beta billing projects link "${projectId}" --billing-account "${BILLING_ACCOUNT}"
    gcloud projects add-iam-policy-binding "${projectId}" \
        --member="serviceAccount:koenighotze-seed-sa@koenighotze-seed-${POSTFIX}.iam.gserviceaccount.com" \
        --role="roles/owner"

    gcloud services enable cloudresourcemanager.googleapis.com --project "${projectId}"
    gcloud services enable cloudbilling.googleapis.com --project "${projectId}"
    gcloud services enable iam.googleapis.com --project "${projectId}"
done

echo "Overall id is ${POSTFIX}. Use this when deleting."
