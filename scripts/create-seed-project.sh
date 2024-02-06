#!/usr/bin/env bash
# when a command fails, bash exits instead of continuing with the rest of the script
set -o errexit
# make the script fail, when accessing an unset variable
set -o nounset
# pipeline command is treated as failed, even if one command in the pipeline fails
set -o pipefail
# enable debug mode, by running your script as TRACE=1
if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi

BILLING_ACCOUNT=${1?Billing account missing}
POSTFIX=${2?Postfix missing}
SEED_PROJECT="koenighotze-seed-$POSTFIX"
SEED_REPOSITORY=koenighotze/koenighotze-gcp-base-setup

function main() {
    if project_exists "$SEED_PROJECT"
    then
        echo "Project $SEED_PROJECT already exists"
    else
        # since Terraform cannot create projects without an organization,
        # we use gcloud cli for the time being
        gcloud projects create "koenighotze-seed-$POSTFIX" --name="Koenighotze Seed" --labels=purpose=seed
    fi

    enable_billing "$SEED_PROJECT" "$BILLING_ACCOUNT"
    enable_services

    if bucket_exists "$SEED_PROJECT"
    then
        echo "Bucket gs://$SEED_PROJECT already exists"
    else
        gsutil mb -l europe-west3 -p "$SEED_PROJECT" "gs://${SEED_PROJECT}"
    fi

    setup_github_secrets "$SEED_REPOSITORY" "$SEED_PROJECT" "$BILLING_ACCOUNT" "$POSTFIX" "$SEED_PROJECT"

    echo "Generated postfix: $POSTFIX"
}

function setup_github_secrets() {
    local SEED_REPOSITORY=$1
    local SEED_PROJECT=$2
    local BILLING_ACCOUNT=$3
    local POSTFIX=$4
    local TERRAFORM_STATE_BUCKET=$5

    gh secret set GCP_PROJECT_ID -R "$SEED_REPOSITORY" -b "$SEED_PROJECT"
    gh secret set BILLING_ACCOUNT_ID -R "$SEED_REPOSITORY" -b "$BILLING_ACCOUNT"
    gh secret set GCP_PROJECT_POSTFIX -R "$SEED_REPOSITORY" -b "$POSTFIX"
    gh secret set TERRAFORM_STATE_BUCKET -R "$SEED_REPOSITORY" -b "$TERRAFORM_STATE_BUCKET"
}

function project_exists() {
  local PROJECT_ID=$1
  local EXISTING_PROJECT=$(gcloud projects list --filter=PROJECT_ID=$PROJECT_ID --format="value(PROJECT_ID)")

  if [ -z "$EXISTING_PROJECT" ] 
  then
    return 1
  else
    return 0
  fi
}

function bucket_exists() {
  local BUCKET_NAME=$1
  local EXISTING_BUCKET=$(gcloud storage buckets list --filter=name=$BUCKET_NAME --format="value(name)")

  if [ -z "$EXISTING_BUCKET" ] 
  then
    return 1
  else
    return 0
  fi
}

function enable_services() {
    echo "Enabling required services"
    gcloud services enable cloudresourcemanager.googleapis.com
    gcloud services enable cloudbilling.googleapis.com
    gcloud services enable billingbudgets.googleapis.com
    gcloud services enable iam.googleapis.com
    gcloud services enable iamcredentials.googleapis.com
}

function enable_billing() {
    local PROJECT=$1
    local ACCOUNT=$2
    gcloud config set project "$PROJECT"
    gcloud beta billing projects link  "$PROJECT" --billing-account "$ACCOUNT"
}

main "$@"; exit
