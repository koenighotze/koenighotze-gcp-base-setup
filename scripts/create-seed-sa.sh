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
    local SA_EMAIL="${SA_ID}@${SEED_PROJECT}.iam.gserviceaccount.com"

    create_seed_sa "$SEED_PROJECT" "$SA_ID" "$SA_EMAIL"

    create_iam_bindings "$SEED_PROJECT" "$BILLING_ACCOUNT" "$SA_EMAIL"

    setup_github_secrets "$SEED_REPOSITORY" "$SA_EMAIL"

    echo "Seed SA: $SA_EMAIL"
}

function setup_github_secrets() {
    local SEED_REPOSITORY=$1
    local SA_EMAIL=$2

    echo "Storing service account email in GitHub secrets of repository $SEED_REPOSITORY"

    gh secret set SEED_SA_EMAIL_ADDRESS -R "${SEED_REPOSITORY}" -b "${SA_EMAIL}"
}

function create_iam_bindings() {
    local SEED_PROJECT=$1
    local BILLING_ACCOUNT=$2
    local SA_EMAIL=$3

    echo "Creating IAM bindings for $SA_EMAIL in seed project $SEED_PROJECT"

    ROLES=(
        "roles/iam.serviceAccountCreator"
        "roles/iam.serviceAccountDeleter"
        "roles/storage.admin"
        "roles/storage.objectAdmin"
    )

    for role in "${ROLES[@]}"; do
        gcloud projects add-iam-policy-binding \
            "$SEED_PROJECT" \
            --member="serviceAccount:$SA_EMAIL" \
            --role="$role"
    done

    gcloud beta billing accounts add-iam-policy-binding "${BILLING_ACCOUNT}"  \
        --project="$SEED_PROJECT" \
        --member="serviceAccount:$SA_EMAIL" \
        --role="roles/billing.admin"
}

function create_seed_sa() {
    local SEED_PROJECT=$1
    local SA_ID=$2
    local SA_EMAIL=$3

    echo "Creating seed service account $SA_ID in project $SEED_PROJECT"

    if service_account_exists "$SEED_PROJECT"; then
        echo "Service account $SA_ID already exists in project $SEED_PROJECT, will not create"
    else
        echo "Creating seed service account $SA_ID in project $SEED_PROJECT"

        gcloud iam service-accounts create "$SA_ID" \
            --project="$SEED_PROJECT" \
            --display-name "Seed account for Koenighotze"
    fi
}

main 
