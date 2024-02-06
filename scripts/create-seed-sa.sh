#!/usr/bin/env bash
# when a command fails, bash exits instead of continuing with the rest of the script
set -o errexit
# make the script fail, when accessing an unset variable
set -o nounset
# pipeline command is treated as failed, even if one command in the pipeline fails
set -o pipefail
# enable debug mode, by running your script as TRACE=1
if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi

MY_DIR="$(dirname "$0")"
source "$MY_DIR/common.sh"
source "$MY_DIR/functions.sh"

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

    gh secret set SEED_SA_EMAIL_ADDRESS -R "${SEED_REPOSITORY}" -b "${SA_EMAIL}"
}

function create_iam_bindings() {
    local SEED_PROJECT=$1
    local BILLING_ACCOUNT=$2
    local SA_EMAIL=$3

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

    if service_account_exists "$SEED_PROJECT"; then
        echo "Service account $SA_ID already exists in project $SEED_PROJECT"
    else
        echo "Creating seed service account $SA_ID in project $SEED_PROJECT"

        gcloud iam service-accounts create "$SA_ID" \
            --display-name "Seed account for Koenighotze"
    fi
}

main 
