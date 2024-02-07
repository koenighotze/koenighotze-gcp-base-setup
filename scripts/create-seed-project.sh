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
    local project=$1

    echo "Creating seed project $project"

    if project_exists "$project"
    then
        echo "Project $project already exists, will not create"
    else
        # since Terraform cannot create projects without an organization,
        # we use gcloud cli for the time being
        gcloud projects create "$project" --name="Koenighotze Seed" --labels=purpose=seed
    fi
}

function create_tf_state_bucket() {
    local project=$1

    echo "Creating Terraform state bucket for $project"

    if bucket_exists "$project"
    then
        echo "Bucket gs://$project already exists"
    else
        gsutil mb -l europe-west3 -p "$project" "gs://${project}"
    fi
}

# Set up GitHub secrets for the seed project
function setup_github_secrets() {
    local repository=$1
    local project=$2
    local billingAccount=$3
    local postfix=$4
    local tfStateBucket=$5

    echo "Setting up GitHub secrets for $repository"

    gh secret set GCP_PROJECT_ID -R "$repository" -b "$project"
    gh secret set BILLING_ACCOUNT_ID -R "$repository" -b "$billingAccount"
    gh secret set GCP_PROJECT_POSTFIX -R "$repository" -b "$postfix"
    gh secret set TERRAFORM_STATE_BUCKET -R "$repository" -b "$tfStateBucket"
}

# Enable required services for the seed project
function enable_services() {
    local project=$1

    echo "Enabling required services"

    gcloud services enable --project="$project" cloudresourcemanager.googleapis.com
    gcloud services enable --project="$project" cloudbilling.googleapis.com
    gcloud services enable --project="$project" billingbudgets.googleapis.com
    gcloud services enable --project="$project" iam.googleapis.com
    gcloud services enable --project="$project" iamcredentials.googleapis.com
}

# Enable billing for the seed project
function enable_billing() {
    local project=$1
    local billingAccount=$2

    echo "Enabling billing for $project"

    gcloud beta billing projects link "$project" --billing-account "$billingAccount"
}

main "$@"
