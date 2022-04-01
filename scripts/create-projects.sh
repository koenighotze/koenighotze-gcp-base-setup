#!/usr/bin/env bash
set -euo pipefail

BILLING_ACCOUNT=${1?Billing account missing}
POSTFIX=${2?Postfix missing}

create_project () {
    local projectId="${1}-${POSTFIX}"
    local -n roles=$2
    local -n apis=$3

    echo "Creating project $projectId"

    # gcloud projects create "${projectId}" --name="Koenighotze $projectId"
    gcloud beta billing projects link "${projectId}" --billing-account "${BILLING_ACCOUNT}"

    gcloud services enable cloudresourcemanager.googleapis.com --project "${projectId}"
    gcloud services enable cloudbilling.googleapis.com --project "${projectId}"
    gcloud services enable iam.googleapis.com --project "${projectId}"

    for role in ${roles[@]}; do
        gcloud projects add-iam-policy-binding "${projectId}" \
            --member="serviceAccount:koenighotze-seed-sa@koenighotze-seed-${POSTFIX}.iam.gserviceaccount.com" \
            --role="$role"
    done

    for api in ${apis[@]}; do
        gcloud services enable "$api" --project "${projectId}"
    done

    echo "$projectId"
}

platform_roles=("roles/serviceusage.serviceUsageAdmin" "roles/resourcemanager.projectIamAdmin" "roles/artifactregistry.admin")
platform_apis=("artifactregistry.googleapis.com")
create_project "platform" platform_roles platform_apis

bodleian_roles=("roles/iam.serviceAccountAdmin" "roles/resourcemanager.projectIamAdmin" "roles/storage.admin" "roles/monitoring.admin" "roles/serviceusage.serviceUsageAdmin")
bodleian_apis=("run.googleapis.com")
create_project "bodleian" bodleian_roles bodleian_apis

echo "Overall id is ${POSTFIX}. Use this when deleting."
