#!/usr/bin/env bash
# shellcheck disable=SC1091
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
    create_seed_sa "$SEED_PROJECT" "$SA_ID" "$SA_EMAIL"

    create_iam_bindings "$SEED_PROJECT" "$BILLING_ACCOUNT" "$SA_EMAIL"

    setup_github_secrets "$SEED_REPOSITORY" "$SA_EMAIL"

    echo "Seed SA: $SA_EMAIL"
}

function setup_github_secrets() {
    local repository=$1
    local saEmail=$2

    echo "Storing service account email in GitHub secrets of repository $repository"

    gh secret set SEED_SA_EMAIL_ADDRESS -R "${repository}" -b "${saEmail}"
}

function create_iam_bindings() {
    local seedProject=$1
    local billingAccount=$2
    local saEmail=$3

    echo "Creating IAM bindings for $saEmail in seed project $seedProject"

    ROLES=(
        "roles/iam.serviceAccountCreator"
        "roles/iam.serviceAccountDeleter"
        "roles/storage.admin"
        "roles/storage.objectAdmin"
    )

    for role in "${ROLES[@]}"; do
        gcloud projects add-iam-policy-binding \
            "$seedProject" \
            --member="serviceAccount:$saEmail" \
            --role="$role"
    done

    gcloud beta billing accounts add-iam-policy-binding "${billingAccount}"  \
        --project="$seedProject" \
        --member="serviceAccount:$saEmail" \
        --role="roles/billing.admin"
}

function create_seed_sa() {
    local project=$1
    local saId=$2

    echo "Creating seed service account $saId in project $project"

    if service_account_exists "$project"; then
        echo "Service account $saId already exists in project $project, will not create"
    else
        echo "Creating seed service account $saId in project $project"

        gcloud iam service-accounts create "$saId" \
            --project="$project" \
            --display-name "Seed account for Koenighotze"
    fi
}

main "$@"
