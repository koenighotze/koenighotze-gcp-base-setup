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
    platform_roles=("roles/serviceusage.serviceUsageAdmin" "roles/resourcemanager.projectIamAdmin" "roles/artifactregistry.admin")
    platform_apis=("artifactregistry.googleapis.com")

    create_project "platform" platform_roles platform_apis

    bodleian_roles=("roles/iam.serviceAccountAdmin" "roles/resourcemanager.projectIamAdmin" "roles/storage.admin" "roles/monitoring.admin" "roles/serviceusage.serviceUsageAdmin")
    bodleian_apis=("run.googleapis.com")

    create_project "bodleian" bodleian_roles bodleian_apis
}

function enable_billing() {
    local projectId="${1}"
    gcloud beta billing projects link "${projectId}" --billing-account="${BILLING_ACCOUNT}"
}

function enable_services() {
    local projectId="${1}"
    local -n apis=$2

    gcloud services enable cloudresourcemanager.googleapis.com --project "${projectId}"
    gcloud services enable cloudbilling.googleapis.com --project "${projectId}"
    gcloud services enable iam.googleapis.com --project "${projectId}"

    for api in ${apis[@]}; do
        gcloud services enable "$api" --project "${projectId}"
    done
}

function enable_iam_binding() {
    local projectId="${1}"
    local -n roles=$2

    for role in ${roles[@]}; do
        gcloud projects add-iam-policy-binding "${projectId}" \
            --member="serviceAccount:koenighotze-seed-sa@koenighotze-seed-${POSTFIX}.iam.gserviceaccount.com" \
            --role="$role"
    done
}

function create_project () {
    local projectId="${1}-${POSTFIX}"
    local -n roles=$2
    local -n apis=$3

    create_project "${projectId}"

    enable_billing "${projectId}"
    
    enable_services "${projectId}"

    enable_iam_binding "${projectId}" "${roles[@]}"

    echo "Finished with project $projectId"
}

main "$@"