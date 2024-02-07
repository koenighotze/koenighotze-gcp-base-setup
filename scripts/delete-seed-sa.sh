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

confirm "Really delete the service account?" || exit

# this needs to be refactored once I have an organization
gcloud iam service-accounts delete "$SA_ID"

gh secret delete GCP_SEED_SA_KEY -R "${SEED_REPOSITORY}"
gh secret delete SEED_SA_EMAIL_ADDRESS -R "${SEED_REPOSITORY}"
