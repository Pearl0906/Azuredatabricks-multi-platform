# Azure Databricks Multi-Environment Data Platform

## Overview

This project provisions and manages an Azure Databricks data platform using **Terraform Infrastructure as Code (IaC)**.

The project follows a **modular architecture** that promotes code reuse, environment isolation, maintainability, and consistent infrastructure deployment across development and testing environments.

## Objectives

The main objectives of this project are to:

* Provision Azure Databricks infrastructure using Terraform.
* Apply modular Infrastructure as Code principles.
* Reuse Terraform modules across Dev and Test environments.
* Separate Terraform state between environments.
* Store Terraform state remotely in Azure Storage.
* Integrate Azure Data Lake Storage Gen2 with Databricks.
* Configure Unity Catalog resources for data governance.
* Provision Databricks SQL warehouses and jobs.
* Apply permissions and access controls.
* Establish a repeatable deployment workflow.

## Architecture

```text
Azure Databricks Multi-Environment Platform
|
|-- Shared Terraform Root
|   |-- main.tf
|   |-- variables.tf
|   |-- outputs.tf
|   |-- providers.tf
|   |-- versions.tf
|   |-- backend.tf
|   |
|   |-- environments/
|   |   |-- dev/
|   |   |   |-- backend.hcl
|   |   |   |-- dev.tfvars
|   |   |
|   |   |-- test/
|   |       |-- backend.hcl
|   |       |-- test.tfvars
|   |
|   |-- modules/
|       |-- resource_group/
|       |-- storage/
|       |-- access_connector/
|       |-- storage_access/
|       |-- databricks_workspace/
|       |-- catalogue/
|       |-- storage_credential/
|       |-- external_location/
|       |-- schema/
|       |-- volume/
|       |-- sql_warehouse/
|       |-- databricks_job/
|       |-- databricks_job_permissions/
|
|-- Azure Platform
    |-- Azure Resource Group
    |-- Azure Databricks Workspace
    |-- Azure Data Lake Storage Gen2
    |-- Unity Catalog
    |   |-- Bronze Schema
    |   |-- Silver Schema
    |   |-- Gold Schema
    |-- Storage Credential
    |-- External Location
    |-- Raw Volume
    |-- SQL Warehouse
    |-- Databricks Job
```

## Technology Stack

| Technology                   | Purpose                        |
| ---------------------------- | ------------------------------ |
| Microsoft Azure              | Cloud infrastructure           |
| Azure Databricks             | Data engineering and analytics |
| Terraform                    | Infrastructure provisioning    |
| Azure Storage                | Remote Terraform state         |
| Azure Data Lake Storage Gen2 | Data lake storage              |
| Unity Catalog                | Data governance                |
| Azure CLI                    | Azure authentication           |
| PowerShell                   | Running commands               |
| Git and GitHub               | Source control                 |

### Terraform Providers

* `hashicorp/azurerm` - manages Azure resources.
* `databricks/databricks` - manages Databricks resources.

## Project Structure

### Shared Terraform Root

| File           | Responsibility                     |
| -------------- | ---------------------------------- |
| `main.tf`      | Defines resources and module calls |
| `variables.tf` | Declares input variables           |
| `outputs.tf`   | Exposes deployment information     |
| `providers.tf` | Configures providers               |
| `versions.tf`  | Defines version constraints        |
| `backend.tf`   | Configures the remote backend      |

### Environment Configuration

| File                            | Responsibility            |
| ------------------------------- | ------------------------- |
| `environments/dev/backend.hcl`  | Configures the Dev state  |
| `environments/dev/dev.tfvars`   | Contains Dev variables    |
| `environments/test/backend.hcl` | Configures the Test state |
| `environments/test/test.tfvars` | Contains Test variables   |

## Terraform Modules

### 1. Resource Group

**Responsibilities:**

* Creates the Azure resource group.
* Defines the resource group name and location.
* Applies environment-specific tags.

### 2. Storage

**Responsibilities:**

* Creates the Azure Storage Account.
* Creates the Data Lake Storage Gen2 filesystem.
* Provides storage for the data platform.

### 3. Access Connector

**Responsibilities:**

* Creates an Azure Databricks Access Connector.
* Provides a managed identity for supported storage integrations.

### 4. Storage Access

**Responsibilities:**

* Configures Azure role assignments.
* Grants the intended identity appropriate storage permissions.
* Supports identity-based storage access.

### 5. Databricks Workspace

**Responsibilities:**

* Provisions the Azure Databricks workspace.
* Configures the workspace name, region, and SKU.
* Provides the environment for Databricks resources.

### 6. Catalogue

**Responsibilities:**

* Creates the Unity Catalog catalog.
* Configures catalog-level permissions.
* Supports centralized data governance.

### 7. Storage Credential

**Responsibilities:**

* Creates a Databricks storage credential.
* Connects Unity Catalog to the configured Azure identity.
* Supports governed access to external storage.

### 8. External Location

**Responsibilities:**

* Associates a cloud storage path with a storage credential.
* Provides governed access to external data.
* Supports external storage permissions.

### 9. Schema

The project uses three data layers:

* **Bronze:** Raw or minimally processed data.
* **Silver:** Cleaned and transformed data.
* **Gold:** Curated data for reporting and analytics.

### 10. Volume

**Responsibilities:**

* Creates a Unity Catalog volume.
* Provides governed file-based data access.
* Organizes raw data files.

### 11. SQL Warehouse

**Responsibilities:**

* Provides compute for SQL queries.
* Configures scaling and performance settings.
* Supports cost-conscious compute management.

### 12. Databricks Job

**Responsibilities:**

* Defines data-processing tasks.
* Configures notebook paths and task dependencies.
* Supports repeatable workflow execution.

### 13. Databricks Job Permissions

**Responsibilities:**

* Configures job access permissions.
* Defines which users, groups, or service principals can manage or run jobs.

## Environment Isolation

| Setting               | Dev                      | Test                      |
| --------------------- | ------------------------ | ------------------------- |
| Shared Terraform root | Yes                      | Yes                       |
| Variable file         | `dev.tfvars`             | `test.tfvars`             |
| Backend configuration | `dev/backend.hcl`        | `test/backend.hcl`        |
| State key             | `azure-data-dev.tfstate` | `azure-data-test.tfstate` |

Both environments use the same Azure Storage backend infrastructure:

* **Resource group:** `rg-adp-tfstate`
* **Storage account:** `stadptfstate03`
* **Container:** `tfstate`

Each environment uses a different state key.

**Important:** Separate state files do not automatically guarantee separate infrastructure. Resource names and environment-specific configurations must also be isolated.

## Terraform Remote State Management

Terraform state records the infrastructure resources managed by Terraform.

### Backend Configuration

The `backend.tf` file contains:

```hcl
terraform {
  backend "azurerm" {}
}
```

### Dev Backend

File: `environments/dev/backend.hcl`

```hcl
use_cli          = true
use_azuread_auth = true

resource_group_name  = "rg-adp-tfstate"
storage_account_name = "stadptfstate03"
container_name       = "tfstate"

key = "azure-data-dev.tfstate"
```

### Test Backend

File: `environments/test/backend.hcl`

```hcl
use_cli          = true
use_azuread_auth = true

resource_group_name  = "rg-adp-tfstate"
storage_account_name = "stadptfstate03"
container_name       = "tfstate"

key = "azure-data-test.tfstate"
```

### Why Separate State Files Matter

* Separate state files maintain independent records of Dev and Test resources.
* They reduce the risk of unintended updates or deletions across environments.
* Each environment must use the correct backend and variable file.

### State Recovery

The recovery process involved:

1. Inspecting the Dev and Test state files.
2. Backing up the state using `terraform state pull`.
3. Restoring the correct state using `terraform state push`.
4. Removing duplicate records from the Test state.
5. Verifying the resulting state.

**Warning:** `terraform state rm` removes resource records from state but does not delete actual cloud resources. Always back up state before making changes.

## Prerequisites

Before deploying the platform, ensure that you have:

* An Azure subscription with appropriate permissions.
* An Azure Storage account and container for Terraform state.
* Terraform CLI installed.
* Azure CLI installed.
* Appropriate Azure Databricks permissions.
* Git installed.

## Authentication

### 1. Sign in to Azure

```powershell
az login
```

### 2. Check the Active Subscription

```powershell
az account show
```

### 3. Select the Correct Subscription

```powershell
az account set --subscription "<SUBSCRIPTION_ID>"
```

**Security best practices:**

* Never commit secrets or access tokens to GitHub.
* Use supported identity-based authentication where practical.
* Ensure both Terraform providers are configured to authenticate.
* Restrict access to remote state storage.

## Getting Started

### Step 1: Clone the Repository

```bash
git clone <REPOSITORY_URL>
cd <REPOSITORY_DIRECTORY>
```

### Step 2: Initialize the Dev Backend

```bash
terraform init -reconfigure -backend-config="environments/dev/backend.hcl"
```

### Step 3: Validate the Configuration

```bash
terraform validate
```

### Step 4: Review the Dev State

```bash
terraform state list
```

### Step 5: Create a Dev Plan

```bash
terraform plan -var-file="environments/dev/dev.tfvars" -out="dev.tfplan"
```

### Step 6: Apply the Dev Plan

```bash
terraform apply "dev.tfplan"
```

### Step 7: Initialize the Test Backend

```bash
terraform init -reconfigure -backend-config="environments/test/backend.hcl"
```

### Step 8: Review the Test State

```bash
terraform state list
```

### Step 9: Create a Test Plan

```bash
terraform plan -var-file="environments/test/test.tfvars" -out="test.tfplan"
```

### Step 10: Apply the Test Plan

```bash
terraform apply "test.tfplan"
```

**Important:** Review every Terraform plan before applying it. Confirm that the selected backend and environment variables are correct.

## Useful Terraform Commands

| Command                          | Purpose                         |
| -------------------------------- | ------------------------------- |
| `terraform init`                 | Initializes Terraform           |
| `terraform fmt -recursive`       | Formats Terraform files         |
| `terraform validate`             | Validates configuration         |
| `terraform plan`                 | Previews infrastructure changes |
| `terraform apply`                | Applies infrastructure changes  |
| `terraform output`               | Displays outputs                |
| `terraform state list`           | Lists resources in state        |
| `terraform state show <ADDRESS>` | Shows a resource's state        |
| `terraform state pull`           | Retrieves state as JSON         |
| `terraform state push <FILE>`    | Pushes a local state file       |

## Security and Best Practices

* **Infrastructure as Code:** Manage infrastructure through version-controlled configuration.
* **Modular design:** Use reusable Terraform modules.
* **Environment isolation:** Maintain separate state files and variables.
* **Least privilege:** Grant only the permissions required.
* **Identity-based authentication:** Prefer managed identities and federated authentication where appropriate.
* **Remote state protection:** Restrict access to state storage.
* **State backups:** Back up state before recovery operations.
* **Plan review:** Review proposed changes before deployment.
* **Version control:** Exclude secrets, state files, and local Terraform artifacts.
* **Cost management:** Configure compute sizing and automatic termination.
* **Data governance:** Use Unity Catalog permissions to control data access.

## Troubleshooting

### Backend Initialization Issues

Check:

* The active Azure subscription.
* The storage account and container names.
* The configured state key.
* The identity's access to the state container.
* The backend selected during initialization.

### Azure Authentication Failures

```powershell
az account show
```

Confirm that the signed-in identity has the necessary permissions.

### Databricks Authentication Failures

Verify that the Databricks provider has a supported authentication method and that the identity can access the intended workspace.

### Unexpected Resource Changes

**Do not apply the plan immediately.**

Check the selected backend, variable file, resource names, provider configuration, and current state before proceeding.

## Future Improvements

* Automate Terraform validation using GitHub Actions.
* Implement identity federation for CI/CD.
* Add automated infrastructure testing.
* Introduce policy-as-code controls.
* Improve monitoring and budget alerts.
* Implement private networking where required.
* Automate deployment promotion from Dev to Test and Production.
* Add more environments using reusable modules.

## Learning Outcomes

This project demonstrates practical experience with:

* Terraform modularization.
* Azure resource provisioning.
* Azure Databricks workspace management.
* Unity Catalog configuration.
* Azure Storage integration.
* Remote backend and state management.
* Environment isolation.
* Authentication and authorization.
* Infrastructure planning and deployment.
* State recovery and troubleshooting.

## Conclusion

The **Azure Databricks Multi-Environment Data Platform** demonstrates how Terraform can manage cloud infrastructure through reusable modules and environment-specific configuration.

The shared-root approach reduces duplicated code, while separate backend state files establish a foundation for independent Dev and Test lifecycle management.

Future improvements include automated CI/CD, identity federation, governance controls, monitoring, and additional environments.

---

**Project Status:** The remote-state separation and recovery steps have been performed. Verify the Dev state and provider authentication before proceeding with the independent Test deployment.

---


