#!/usr/bin/env bash
# shellcheck disable=SC1091
# when a command fails, bash exits instead of continuing with the rest of the script
set -o errexit
# make the script fail, when accessing an unset variable
set -o nounset
# pipeline command is treated as failed, even if one command in the pipeline fails
set -o pipefail
# enable debug mode, by running your script as TRACE=1
if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi

source "$(dirname "$0")/common.sh"

# function workload_identity_pool_exists() {
#   local project_id=$1
#   local workload_identity_pool="$2"

#   local existing_pool
#   existing_pool=$(
#     gcloud iam workload-identity-pools describe "$workload_identity_pool" \
#       --project="$project_id" \
#       --location="global" \
#       --format="value(name)" 2>/dev/null
#   )

#   if [ -z "$existing_pool" ]
#   then
#     return 1
#   else
#     return 0
#   fi
# }

# function setup_workload_pool() {
#   local project_id="$1"
#   local workload_identity_pool="$2"

#   if workload_identity_pool_exists "$project_id" "$workload_identity_pool";
#   then
#     echo "Workload identity pool $workload_identity_pool already exists in project $project_id"
#     return
#   fi

#   echo "Creating workload identity pool $workload_identity_pool in project $project_id"

#   gcloud iam workload-identity-pools create "$workload_identity_pool" \
#           --project="$project_id" \
#           --location="global" \
#           --display-name="WIP for GitHub CI/CD"
# }

# function fetch_workload_identity_pool_id() {
#   local workload_identity_pool="$1"

#   gcloud iam workload-identity-pools describe "$workload_identity_pool" \
#     --location="global" \
#     --format="value(name)"
# }

# function fetch_workload_identity_pool_provider_id() {
#   local provider_id="$1"
#   local workload_identity_pool="$2"

#   gcloud iam workload-identity-pools providers describe "$provider_id" \
#     --workload-identity-pool="$workload_identity_pool" \
#     --location="global" \
#     --format="value(name)"
# }

# function workload_identity_pool_provider_exists() {
#   local provider_id="$1"
#   local workload_identity_pool="$2"

#   local existing_provider
#   existing_provider=$(
#     gcloud iam workload-identity-pools providers describe "$provider_id" \
#       --workload-identity-pool="$workload_identity_pool" \
#       --location="global" \
#       --format="value(name)" 2>/dev/null
#   )

#   if [ -z "$existing_provider" ]
#   then
#     return 1
#   else
#     return 0
#   fi
# }

# function link_github_oidc_to_workload_pool() {
#   local provider_id="$1"
#   local workload_identity_pool="$2"

#   if workload_identity_pool_provider_exists "$provider_id" "$workload_identity_pool";
#   then
#     echo "GitHub OIDC provider already linked to workload identity pool $workload_identity_pool"
#     return
#   fi

#   echo "Linking GitHub OIDC provider to workload identity pool $workload_identity_pool"

#   gcloud iam workload-identity-pools providers create-oidc "$provider_id" \
#           --location="global" \
#           --workload-identity-pool="$workload_identity_pool"  \
#           --display-name="GitHub OIDC provider" \
#           --attribute-mapping="google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.repository=assertion.repository" \
#           --issuer-uri="https://token.actions.githubusercontent.com"
# }

# function allow_seed_repository_access_to_the_seed_account() {
#   local sa_email="$1"
#   local workload_identity_pool_id="$2"
#   local repository="$3"

#   echo "Allowing seed repository $repository to access the seed service account $sa_email"

#   gcloud iam service-accounts add-iam-policy-binding "$sa_email" \
#       --role="roles/iam.workloadIdentityUser" \
#       --member="principalSet://iam.googleapis.com/${workload_identity_pool_id}/attribute.repository/${repository}"
# }

# function setup_github_secrets() {
#   local workload_identity_provider="$1"
#   local workload_identity_pool_id="$2"
#   local repository="$3"

#   echo "Setting up GitHub secrets for repository $repository"

#   gh secret set WORKLOAD_IDENTITY_PROVIDER -R "$repository" -b "$workload_identity_provider"
#   gh secret set WORKLOAD_IDENTITY_POOL_ID -R "$repository" -b "$workload_identity_pool_id"
# }

# function main() {
#   # shellcheck disable=SC2153
#   setup_workload_pool "$SEED_PROJECT" "$WORKLOAD_IDENTITY_POOL"

#   workload_identity_pool_id=$(fetch_workload_identity_pool_id "$WORKLOAD_IDENTITY_POOL")
#   workload_identity_pool_provider_id=$(fetch_workload_identity_pool_provider_id "$PROVIDER_ID" "$WORKLOAD_IDENTITY_POOL")

#   # shellcheck disable=SC2153
#   link_github_oidc_to_workload_pool "$PROVIDER_ID" "$WORKLOAD_IDENTITY_POOL"

#   # shellcheck disable=SC2153
#   allow_seed_repository_access_to_the_seed_account "$SA_EMAIL" "$workload_identity_pool_id" "$SEED_REPOSITORY"

#   setup_github_secrets "$workload_identity_pool_provider_id" "$workload_identity_pool_id" "$SEED_REPOSITORY"
# }

main "$@"


