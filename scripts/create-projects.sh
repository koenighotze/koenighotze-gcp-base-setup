#!/usr/bin/env bash
set -euo pipefail

BILLING_ACCOUNT=${1?Billing account missing}

# since Terraform cannot create projects without an organization,
# we use gcloud cli for the time being
for projectId in bodleian platform; do
    echo "Project: $projectId"

    gcloud projects create "${projectId}-72d26c895553" --name="Koenighotze $projectId"
    gcloud beta billing projects link "${projectId}-72d26c895553" --billing-account "${BILLING_ACCOUNT}"
    # gcloud services enable cloudresourcemanager.googleapis.com --project "koenighotze-$projectId"
    # gcloud services enable cloudbilling.googleapis.com --project "koenighotze-$projectId"
    # gcloud services enable iam.googleapis.com --project "koenighotze-$projectId"

    # gsutil mb -l europe-west3 -p "koenighotze-$projectId" gs://"koenighotze-$projectId"
done
