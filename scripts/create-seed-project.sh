#!/usr/bin/env bash
# when a command fails, bash exits instead of continuing with the rest of the script
set -o errexit
# make the script fail, when accessing an unset variable
set -o nounset
# pipeline command is treated as failed, even if one command in the pipeline fails
set -o pipefail
# enable debug mode, by running your script as TRACE=1
if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi

source "$(dirname "$0")/common.sh"

function main() {
    create_seed_project "$SEED_PROJECT"

    enable_services "$SEED_PROJECT"

    enable_billing "$SEED_PROJECT" "$BILLING_ACCOUNT"

    create_tf_state_bucket "$SEED_PROJECT"

    setup_github_secrets "$SEED_REPOSITORY" "$SEED_PROJECT" "$BILLING_ACCOUNT" "$POSTFIX" "$SEED_PROJECT"

    echo "Generated project $SEED_PROJECT with postfix: $POSTFIX"
}

function create_seed_project() {
    local SEED_PROJECT=$1

    echo "Creating seed project $SEED_PROJECT"

    if project_exists "$SEED_PROJECT"
    then
        echo "Project $SEED_PROJECT already exists, will not create"
    else
        # since Terraform cannot create projects without an organization,
        # we use gcloud cli for the time being
        gcloud projects create "$SEED_PROJECT" --name="Koenighotze Seed" --labels=purpose=seed
    fi
}

function create_tf_state_bucket() {
    local SEED_PROJECT=$1

    echo "Creating Terraform state bucket for $SEED_PROJECT"

    if bucket_exists "$SEED_PROJECT"
    then
        echo "Bucket gs://$SEED_PROJECT already exists"
    else
        gsutil mb -l europe-west3 -p "$SEED_PROJECT" "gs://${SEED_PROJECT}"
    fi
}

# Set up GitHub secrets for the seed project
function setup_github_secrets() {
    local SEED_REPOSITORY=$1
    local SEED_PROJECT=$2
    local BILLING_ACCOUNT=$3
    local POSTFIX=$4
    local TERRAFORM_STATE_BUCKET=$5

    echo "Setting up GitHub secrets for $SEED_REPOSITORY"

    gh secret set GCP_PROJECT_ID -R "$SEED_REPOSITORY" -b "$SEED_PROJECT"
    gh secret set BILLING_ACCOUNT_ID -R "$SEED_REPOSITORY" -b "$BILLING_ACCOUNT"
    gh secret set GCP_PROJECT_POSTFIX -R "$SEED_REPOSITORY" -b "$POSTFIX"
    gh secret set TERRAFORM_STATE_BUCKET -R "$SEED_REPOSITORY" -b "$TERRAFORM_STATE_BUCKET"
}

# Enable required services for the seed project
function enable_services() {
    local PROJECT=$1

    echo "Enabling required services"

    gcloud services enable --project="$PROJECT" cloudresourcemanager.googleapis.com
    gcloud services enable --project="$PROJECT" cloudbilling.googleapis.com
    gcloud services enable --project="$PROJECT" billingbudgets.googleapis.com
    gcloud services enable --project="$PROJECT" iam.googleapis.com
    gcloud services enable --project="$PROJECT" iamcredentials.googleapis.com
}

# Enable billing for the seed project
function enable_billing() {
    local PROJECT=$1
    local ACCOUNT=$2

    echo "Enabling billing for $PROJECT"

    gcloud beta billing projects link  "$PROJECT" --billing-account "$ACCOUNT"
}

main "$@"
