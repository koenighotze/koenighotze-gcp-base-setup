#!/usr/bin/env bash

set -euo

POSTFIX=${1?Postfix missing}
SEED_SA="koenighotze-seed-sa@koenighotze-seed-${POSTFIX}.iam.gserviceaccount.com"
SEED_PROJECT="koenighotze-seed-$POSTFIX"
REPO=koenighotze/koenighotze-gcp-base-setup
WORKLOAD_IDENTITY_POOL=github-cicd-pool
PROVIDER_ID=github-provider

gcloud config set project "$SEED_PROJECT"

# Setup workload pool
gcloud iam workload-identity-pools create "$WORKLOAD_IDENTITY_POOL" \
        --location="global" \
        --display-name="WIP for GitHub CI/CD"

# Link GitHub OIDC to workload pool
gcloud iam workload-identity-pools providers create-oidc "$PROVIDER_ID" \
        --location="global" \
        --workload-identity-pool="$WORKLOAD_IDENTITY_POOL"  \
        --display-name="GitHub OIDC provider" \
        --attribute-mapping="google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.repository=assertion.repository" \
        --issuer-uri="https://token.actions.githubusercontent.com"

# fetch identity pool id
WORKLOAD_IDENTITY_POOL_ID=$(gcloud iam workload-identity-pools describe "$WORKLOAD_IDENTITY_POOL" \
  --location="global" \
  --format="value(name)")

# # Allow the seed repository to use the seed service accound
gcloud iam service-accounts add-iam-policy-binding "$SEED_SA" \
    --role="roles/iam.workloadIdentityUser" \
    --member="principalSet://iam.googleapis.com/${WORKLOAD_IDENTITY_POOL_ID}/attribute.repository/${REPO}"

WORKLOAD_IDENTITY_PROVIDER=$(gcloud iam workload-identity-pools providers describe "$PROVIDER_ID" \
  --location="global" \
  --workload-identity-pool="github-cicd-pool" \
  --format="value(name)")

echo "Use the following id as the workload_identity_provider in GitHub actions workflows"
echo "$WORKLOAD_IDENTITY_PROVIDER"

gh secret set WORKLOAD_IDENTITY_PROVIDER -R "$REPO" -b "$WORKLOAD_IDENTITY_PROVIDER"
gh secret set WORKLOAD_IDENTITY_POOL_ID -R "$REPO" -b "$WORKLOAD_IDENTITY_POOL_ID"

