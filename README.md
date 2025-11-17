# 21daysProject
Generic Module terraform


README.md – Terraform Infrastructure Setup (Azure)
Overview

This Terraform project provisions a complete Azure infrastructure including:

Resource Group

Virtual Network (VNet)

Subnets

Azure Kubernetes Service (AKS)

Azure SQL Database

Azure Container Registry (ACR)

Azure Key Vault

The project follows a modular design to ensure reusability, clarity, and scalability.

Project Structure
terraform/
 ├── main.tf
 ├── providers.tf
 ├── variables.tf
 ├── outputs.tf
 ├── backend.tf
 ├── modules/
 │     ├── rg/
 │     ├── vnet/
 │     ├── subnet/
 │     ├── aks/
 │     ├── sql/
 │     ├── acr/
 │     └── keyvault/
 ├── env/
 │     ├── dev.tfvars
 │     ├── test.tfvars
 │     └── prod.tfvars

Prerequisites

Before running Terraform, ensure you have:

Tools Required

Terraform ≥ 1.5+

Azure CLI

Access to Azure Subscription

Storage Account for Remote Backend (Terraform State)

Azure Login
az login

Backend Configuration (Remote State)

State is stored in Azure Storage for safe locking and collaboration.

backend.tf

terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstateaccount123"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}

How to Use
1. Initialize Terraform
terraform init

2. Validate Configuration
terraform validate

3. See Planned Changes
terraform plan -var-file="env/dev.tfvars"

4. Apply Infrastructure
terraform apply -var-file="env/dev.tfvars"

5. Destroy (if needed)
terraform destroy -var-file="env/dev.tfvars"

Modules
### 1. Resource Group Module

Creates a resource group.

resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location
}

2. Virtual Network Module

Creates VNet with address space.

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
}

3. Subnet Module

Creates multiple subnets under the VNet.

resource "azurerm_subnet" "subnet" {
  for_each            = var.subnets
  name                = each.value.name
  resource_group_name = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes    = [each.value.cidr]
}

4. ACR (Azure Container Registry)
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  sku                 = "Standard"
  admin_enabled       = false
  resource_group_name = var.resource_group_name
  location            = var.location
}

5. Key Vault

Stores secrets securely.

resource "azurerm_key_vault" "kv" {
  name                = var.keyvault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  sku_name            = "standard"
}

6. Azure SQL Database
resource "azurerm_sql_server" "sql" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  administrator_login          = var.admin_user
  administrator_login_password = var.admin_password
}

resource "azurerm_sql_database" "sql_db" {
  name                = var.db_name
  resource_group_name = var.resource_group_name
  location            = var.location
  server_name         = azurerm_sql_server.sql.name
  sku_name            = "GP_Gen5_2"
}

7. AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "nodepool"
    node_count = var.node_count
    vm_size    = var.node_vm_size
    vnet_subnet_id = var.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
  }
}

Variables

Example:

variable "location" {}
variable "project" {}
variable "environment" {}
variable "address_space" {}
variable "subnets" {
  type = list(object({
    name = string
    cidr = string
  }))
}

Outputs
output "aks_kubeconfig" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "acr_login" {
  value = azurerm_container_registry.acr.login_server
}

Environment Files
Example: dev.tfvars
project        = "todoapp"
environment    = "dev"
location       = "eastus"

address_space  = ["10.10.0.0/16"]

subnets = [
  { name = "aks-subnet", cidr = "10.10.1.0/24" },
  { name = "db-subnet",  cidr = "10.10.2.0/24" }
]

node_count = 2
node_vm_size = "Standard_D2s_v3"

Security Best Practices

Use Key Vault for all sensitive secrets

Enable Managed Identity for AKS

Use RBAC + Azure AD Integration

Enable Firewall on SQL & Key Vault

Use private endpoints for ACR, SQL, Key Vault

CI/CD Integration

Terraform can be automated via:

Azure DevOps

GitHub Actions

GitOps (FluxCD/ArgoCD after AKS deployment)

Pipeline includes:

terraform fmt
terraform init
terraform validate
terraform plan
terraform apply

Support

For enhancements or issues, raise a PR or create an issue in the repository.
