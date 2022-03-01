# Base infrastructure for Koenighotze on Google Cloud Platform

Target structure is as follows:

```mermaid
graph LR;
    CLI-- creates -->Seedproject & SeedSA;
    GitHubActions-- uses -->SeedSA;
    GitHubActions-- terraforms -->Billing;
    GitHubActions-- terraforms -->ProjectSAs & Projects & ProjectStateBuckets;
```
