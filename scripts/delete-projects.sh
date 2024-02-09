#!/usr/bin/env bash
# shellcheck disable=SC1091
set -euo pipefail

source "$(dirname "$0")/common.sh"

confirm "Really delete the projects?" || exit

# since Terraform cannot create projects without an organization,
# we use gcloud cli for the time being
for projectId in bodleian platform; do
    echo "Project: ${projectId}-${POSTFIX}"

    gcloud projects delete "${projectId}-${POSTFIX}"
done
