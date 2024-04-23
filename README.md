# Entra PIM Group Demo

This repo intent to demonstrate the use of Entra PIM for Group using Infrastructure as Code (IaC).

## Setup

The Service Principal (SP) used by Terraform need the following permissions:

- `Group.ReadWrite.All`
- `Directory.ReadWrite.All`

## Notes

We will use the [Microsoft Graph API documentation](https://learn.microsoft.com/en-us/graph/api/resources/privilegedidentitymanagement-for-groups-api-overview?view=graph-rest-1.0) to make API requests and programmatically setup PIM for Groups.

## Pre-commit hooks for terraform files (optional)

❗ The pre-commit hooks are only running on staged files.

To set up pre-commit hooks for terraform files, run the following commands:
    
```bash
brew install pre-commit
pre-commit install
```

If you want to uninstall the pre-commit hooks, run the following command:

```bash
pre-commit uninstall
```

## Build

[![Terraform](https://github.com/fredrkl/entra-pim-group-demo/actions/workflows/terraform.yaml/badge.svg)](https://github.com/fredrkl/entra-pim-group-demo/actions/workflows/terraform.yaml)
