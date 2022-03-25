#!/usr/bin/env bash
set -euo pipefail

POSTFIX=${1?Postfix missing}
SEED_PROJECT_ID="koenighotze-seed-$POSTFIX"
# since Terraform cannot create projects without an organization,
# we use gcloud cli for the time being
gcloud projects delete "$SEED_PROJECT_ID"