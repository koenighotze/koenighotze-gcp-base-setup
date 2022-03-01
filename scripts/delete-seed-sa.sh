#!/usr/bin/env bash

SEED_PROJECT_ID=koenighotze-seed
SA_ID=koenighotze-seed-sa
SEED_REPOSITORY=koenighotze/koenighotze-gcp-base-setup

# this needs to be refactored once I have an organization
gcloud iam service-accounts delete "$SA_ID"

gh secret delete GCP_SEED_SA_KEY -R "${SEED_REPOSITORY}"
gh secret delete SEED_SA_EMAIL_ADDRESS -R "${SEED_REPOSITORY}"
