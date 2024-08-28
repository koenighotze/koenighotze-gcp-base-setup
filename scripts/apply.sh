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

terraform apply \
    -var "billing_account_id=$BILLING_ACCOUNT" \
    -var "seed_sa_email=$SA_EMAIL" \
    -var "github_admin_token=$ADMIN_GITHUB_TOKEN" \
    -var "project_postfix=$POSTFIX" \
    -var "workload_identity_provider_name=$PROVIDER_ID" \
    -var "workload_identity_pool_name=$WORKLOAD_IDENTITY_POOL_NAME" \
    -var "codacy_api_token=$CODACY_API_TOKEN" \
    "$@"
