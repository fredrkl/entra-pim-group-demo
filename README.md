# Entra PIM Group Demo

This repo intent to demonstrate the use of Entra PIM for Group using Infrastructure as Code (IaC).

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
