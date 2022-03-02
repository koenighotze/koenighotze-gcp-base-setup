#!/usr/bin/env bash
set -euo pipefail

POSTFIX=${1?Postfix missing}

# since Terraform cannot create projects without an organization,
# we use gcloud cli for the time being
for projectId in bodleian platform; do
    echo "Project: ${projectId}-${POSTFIX}"

    gcloud projects delete "${projectId}-${POSTFIX}"
done
