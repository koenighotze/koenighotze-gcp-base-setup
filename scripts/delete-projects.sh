#!/usr/bin/env bash
set -euo pipefail

POSTFIX=72d26c895553

# since Terraform cannot create projects without an organization,
# we use gcloud cli for the time being
for name in bodleian platform; do
    echo "Project: $name"
    projectId="${name}-${POSTFIX}"

    gcloud projects delete "${projectId}"
done
