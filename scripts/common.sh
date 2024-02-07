#!/usr/bin/env bash
# when a command fails, bash exits instead of continuing with the rest of the script
set -o errexit
# make the script fail, when accessing an unset variable
set -o nounset
# pipeline command is treated as failed, even if one command in the pipeline fails
set -o pipefail
# enable debug mode, by running your script as TRACE=1
if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi

MY_DIR="$(dirname "$0")"
source "$MY_DIR/local.sh"
source "$MY_DIR/functions.sh"

: ${POSTFIX}
: ${BILLING_ACCOUNT}

SEED_PROJECT="koenighotze-seed-$POSTFIX"
SEED_REPOSITORY=koenighotze/koenighotze-gcp-base-setup
SA_ID=koenighotze-seed-sa
SA_EMAIL="${SA_ID}@${SEED_PROJECT}.iam.gserviceaccount.com"