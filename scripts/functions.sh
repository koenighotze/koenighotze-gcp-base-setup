#!/usr/bin/env bash
# when a command fails, bash exits instead of continuing with the rest of the script
set -o errexit
# make the script fail, when accessing an unset variable
set -o nounset
# pipeline command is treated as failed, even if one command in the pipeline fails
set -o pipefail
# enable debug mode, by running your script as TRACE=1
if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi

function service_account_exists() {
  local PROJECT_ID=$1
  local EXISTING_SA=$(gcloud iam service-accounts list --project=$PROJECT_ID --format="value(name)")

  if [ -z "$EXISTING_SA" ] 
  then
    return 1
  else
    return 0
  fi
}

function project_exists() {
  local PROJECT_ID=$1
  local EXISTING_PROJECT=$(gcloud projects list --filter=PROJECT_ID=$PROJECT_ID --format="value(PROJECT_ID)")

  if [ -z "$EXISTING_PROJECT" ] 
  then
    return 1
  else
    return 0
  fi
}

function bucket_exists() {
  local BUCKET_NAME=$1
  local EXISTING_BUCKET=$(gcloud storage buckets list --filter=name=$BUCKET_NAME --format="value(name)")

  if [ -z "$EXISTING_BUCKET" ] 
  then
    return 1
  else
    return 0
  fi
}
