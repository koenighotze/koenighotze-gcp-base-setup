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

source "$MY_DIR/1password-ids.sh"

POSTFIX=398addce
BILLING_ACCOUNT=$(gcloud billing accounts list --filter="displayName=DSchmitz-Training-Billing" --format="value(name)")
CODACY_API_TOKEN=$(op read "$CODACY_API_TOKEN_ID")
# Github / KH_GCP_SETUP_ADMIN_GITHUB_TOKEN
ADMIN_GITHUB_TOKEN=$(op read "$ADMIN_GITHUB_TOKEN_ID")
DOCKER_REGISTRY_USERNAME=$(op read "$DOCKER_REGISTRY_USERNAME_ID")
DOCKER_REGISTRY_TOKEN=$(op read "$DOCKER_REGISTRY_TOKEN_ID")
