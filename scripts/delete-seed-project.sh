#!/usr/bin/env bash
set -euo pipefail

# since Terraform cannot create projects without an organization,
# we use gcloud cli for the time being
gcloud projects delete koenighotze-seed