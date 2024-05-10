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
gcloud config set project koenighotze-seed-398addce

# we assume gcloud to be downloaded and initialized
# gcloud init
# gcloud auth application-default login

if bucket_exists "$SEED_PROJECT"; then
    terraform init -backend-config="bucket=$SEED_PROJECT" $*
else
    echo "Missing bucket '$SEED_PROJECT'; cannot initialize backend"
    exit 1 
fi
