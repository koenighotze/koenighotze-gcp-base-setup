#!/usr/bin/env bash

SEED_PROJECT_ID=koenighotze-seed
SA_ID=koenighotze-seed-sa

# this needs to be refactored once I have an organization
gcloud iam service-accounts create "$SA_ID" --display-name "Seed account for Koenighotze"  --project "$SEED_PROJECT_ID"

# TODO: replace with custom role
gcloud projects add-iam-policy-binding "${SEED_PROJECT_ID}" \
    --member="serviceAccount:${SA_ID}@${SEED_PROJECT_ID}.iam.gserviceaccount.com" \
    --role="roles/owner"

gcloud iam service-accounts keys create key-file.json \
    --iam-account="${SA_ID}@${SEED_PROJECT_ID}.iam.gserviceaccount.com"

gh secret set GCP_SEED_SA_KEY -R koenighotze/koenighotze-gcp-base-setup < key-file.json
gh secret set SEED_SA_EMAIL_ADDRESS -R koenighotze/koenighotze-gcp-base-setup -b "${SA_ID}@${SEED_PROJECT_ID}.iam.gserviceaccount.com"
