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
    local platform_roles
    platform_roles=("roles/serviceusage.serviceUsageAdmin" "roles/resourcemanager.projectIamAdmin" "roles/artifactregistry.admin")
    local platform_apis
    platform_apis=("artifactregistry.googleapis.com")

    create_and_setup_project "platform" "$SA_EMAIL" "$BILLING_ACCOUNT" platform_roles platform_apis

    local bodleian_roles
    bodleian_roles=("roles/iam.serviceAccountAdmin" "roles/resourcemanager.projectIamAdmin" "roles/storage.admin" "roles/monitoring.admin" "roles/serviceusage.serviceUsageAdmin")
    local bodleian_apis
    bodleian_apis=("run.googleapis.com")

    create_and_setup_project "bodleian" "$SA_EMAIL" "$BILLING_ACCOUNT" bodleian_roles bodleian_apis
}

function enable_billing() {
    local projectId="$1"
    local billingAccount="$2"

    echo "Enabling billing account $billingAccount for project $projectId"

    gcloud beta billing projects link "${projectId}" --billing-account="${billingAccount}"
}

function enable_services() {
    local projectId="$1"; shift
    local apis=("$@")

    echo "Enabling common services for project $projectId"

    gcloud services enable cloudresourcemanager.googleapis.com --project "${projectId}"
    gcloud services enable cloudbilling.googleapis.com --project "${projectId}"
    gcloud services enable iam.googleapis.com --project "${projectId}"

    for api in ${apis[@]}; do
        echo "Enabling service $api for project $projectId"
        gcloud services enable "$api" --project "${projectId}"
    done
}

function enable_iam_binding() {
    local projectId="${1}"
    local saEmail="${2}"; shift 2
    local roles=("$@")

    echo "Enabling IAM binding for project $projectId and $saEmail"

    for role in ${roles[@]}; do
        echo "Enabling role $role for project $projectId"
        gcloud projects add-iam-policy-binding "${projectId}" \
            --member="serviceAccount:$saEmail" \
            --role="$role"
    done
}

function create_and_setup_project () {
    local projectId="${1}-${POSTFIX}"
    local saEmail="$2" 
    local billingAccount="$3"
    local -n _roles=$4
    local -n _apis=$5

    echo "Creating project $projectId with billing account $billingAccount and service account $saEmail"

    create_project "$projectId"

    enable_billing "$projectId" "$billingAccount"
    
    enable_services "$projectId" "${_apis[@]}"

    enable_iam_binding "$projectId" "$saEmail" "${_roles[@]}"

    echo "Finished with project $projectId"
}

main "$@"