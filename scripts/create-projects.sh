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
source "$(dirname "$0")/projects.sh"

function main() {
    for project in "${PROJECTS[@]}"; do
        create_project "$project" "$BILLING_ACCOUNT"
    done
}

function create_project () {
    local projectId="${1}-${POSTFIX}"
    local billingAccount="$2"

    echo "Creating project $projectId"

    create_project "$projectId"
    enable_billing "$projectId" "$billingAccount"

    echo "Finished with project $projectId"
}

function enable_billing() {
    local projectId="$1"
    local billingAccount="$2"

    echo "Enabling billing account $billingAccount for project $projectId"

    gcloud beta billing projects link "${projectId}" --billing-account="${billingAccount}"
}

main "$@"