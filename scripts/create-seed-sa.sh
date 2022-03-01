#!/usr/bin/env bash

SEED_PROJECT_ID=koenighotze-seed
SA_ID=koenighotze-seed-sa
BILLING_ACCOUNT=${1?Billing account missing}
SA_EMAIL="${SA_ID}@${SEED_PROJECT_ID}.iam.gserviceaccount.com"
SEED_REPOSITORY=koenighotze/koenighotze-gcp-base-setup

# this needs to be refactored once I have an organization
gcloud iam service-accounts create "$SA_ID" --display-name "Seed account for Koenighotze"  --project "$SEED_PROJECT_ID"

# TODO: replace with custom role
gcloud projects add-iam-policy-binding "${SEED_PROJECT_ID}" \
    --member="serviceAccount:${SA_EMAIL}" \
    --role="roles/owner"

gcloud iam service-accounts keys create key-file.json \
    --iam-account="${SA_EMAIL}"

gcloud beta billing accounts add-iam-policy-binding "${BILLING_ACCOUNT}"  \
    --member="serviceAccount:koenighotze-seed-sa@koenighotze-seed.iam.gserviceaccount.com" \
    --role="roles/billing.admin"

gh secret set GCP_SEED_SA_KEY -R "${SEED_REPOSITORY}" < key-file.json
gh secret set SEED_SA_EMAIL_ADDRESS -R "${SEED_REPOSITORY}" -b "${SA_EMAIL}"
