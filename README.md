# Base infrastructure for Koenighotze on Google Cloud Platform

[![Plan](https://github.com/koenighotze/koenighotze-gcp-base-setup/actions/workflows/plan.yml/badge.svg)](https://github.com/koenighotze/koenighotze-gcp-base-setup/actions/workflows/plan.yml)
[![.github/workflows/apply.yml](https://github.com/koenighotze/koenighotze-gcp-base-setup/actions/workflows/apply.yml/badge.svg)](https://github.com/koenighotze/koenighotze-gcp-base-setup/actions/workflows/apply.yml)


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
