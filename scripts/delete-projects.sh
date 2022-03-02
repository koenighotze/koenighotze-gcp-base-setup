#!/usr/bin/env bash
set -euo pipefail

# since Terraform cannot create projects without an organization,
# we use gcloud cli for the time being
for projectId in bodleian platform; do
    echo "Project: $projectId"

    gcloud projects delete "${projectId}"
done
