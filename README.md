# Base infrastructure for Koenighotze on Google Cloud Platform

[![Plan](https://github.com/koenighotze/koenighotze-gcp-base-setup/actions/workflows/plan.yml/badge.svg)](https://github.com/koenighotze/koenighotze-gcp-base-setup/actions/workflows/plan.yml)
[![Apply](https://github.com/koenighotze/koenighotze-gcp-base-setup/actions/workflows/apply.yml/badge.svg)](https://github.com/koenighotze/koenighotze-gcp-base-setup/actions/workflows/apply.yml)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/246d19dc8b6e4c9ca83d371b079c96c8)](https://www.codacy.com/gh/koenighotze/koenighotze-gcp-base-setup/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=koenighotze/koenighotze-gcp-base-setup&amp;utm_campaign=Badge_Grade)


Target structure is as follows:

```mermaid
graph LR;
    Seedproject-- hosts -->SeedStateBucket;
    Seedproject-- hosts -->SeedSA;

    SeedSA-. creates .->ProjectSAs;
    SeedSA-. creates .->Projects;
    SeedSA-. creates .->ProjectStateBuckets;

    ProjectSAs-. edits .->Projects;
    ProjectSAs-. edits .->ProjectStateBuckets;
```

The automation works as follows

```mermaid
graph LR;
    CLI-- creates -->Seedproject & SeedSA;

    SeedSA-- usedIn -->GitHubActions;
    GitHubActions-- terraforms -->Billing;
    GitHubActions-- terraforms -->ProjectSAs & Projects & ProjectStateBuckets & ProjectInfraRepository;
```

## Setup instructions

Setup billing account and export its id to $BILLING_ACCOUNT. Generate a unique id and export it as $POSTFIX. E.g.,:

```bash
export BILLING_ACCOUNT=134
export POSTFIX=414xb1

./scripts/create-seed-project.sh $BILLING_ACCOUNT $POSTFIX
./scripts/create-seed-sa.sh $POSTFIX
./scripts/create-projects.sh $BILLING_ACCOUNT $POSTFIX
```

Set GH secrets on this repo manually:

- ADMIN_GITHUB_TOKEN
- GH_TOKEN_FOR_LABELING
- CODACY_API_TOKEN
- DOCKER_REGISTRY_TOKEN
- DOCKER_REGISTRY_USERNAME
