#!/usr/bin/env bash
set -euo pipefail

# since Terraform cannot create projects without an organization,
# we use gcloud cli for the time being
gcloud projects create koenighotze-baseline --name="Baseline" --labels=purpose=baseline
gcloud projects create koenighotze-bodleian --name="Bodleian" --labels=purpose=project
