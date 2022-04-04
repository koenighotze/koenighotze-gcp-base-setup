#!/usr/bin/env bash

POSTFIX=${1?Postfix missing}
SEED_PROJECT="koenighotze-seed-$POSTFIX"
SA_ID=koenighotze-seed-sa
BILLING_ACCOUNT=${2?Billing account missing}
SA_EMAIL="${SA_ID}@${SEED_PROJECT}.iam.gserviceaccount.com"
SEED_REPOSITORY=koenighotze/koenighotze-gcp-base-setup

gcloud config set project "$SEED_PROJECT"

# this needs to be refactored once I have an organization
gcloud iam service-accounts create "$SA_ID" \
    --display-name "Seed account for Koenighotze"

gcloud projects add-iam-policy-binding \
    "$SEED_PROJECT" \
    --member="serviceAccount:$SA_EMAIL" \
    --role="roles/iam.serviceAccountCreator"

gcloud projects add-iam-policy-binding \
    "$SEED_PROJECT" \
    --member="serviceAccount:$SA_EMAIL" \
    --role="roles/iam.serviceAccountDeleter"

gcloud projects add-iam-policy-binding \
    "$SEED_PROJECT" \
    --member="serviceAccount:$SA_EMAIL" \
    --role="roles/storage.admin"

gcloud beta billing accounts add-iam-policy-binding "${BILLING_ACCOUNT}"  \
    --member="serviceAccount:$SA_EMAIL" \
    --role="roles/billing.admin"

# we don't use keys anymore, but use workload identity
# gh secret set GCP_SEED_SA_KEY -R "${SEED_REPOSITORY}" < key-file.json
gh secret set SEED_SA_EMAIL_ADDRESS -R "${SEED_REPOSITORY}" -b "${SA_EMAIL}"

echo "Seed SA: $SA_EMAIL"
