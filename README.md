# Terraform Azure Infrastructure Setup

This project provisions a complete Azure infrastructure using **Terraform**.  
The setup includes:

- Resource Group (RG)
- Virtual Network (VNet)
- Subnets
- Azure Kubernetes Service (AKS)
- Azure SQL Database
- Azure Container Registry (ACR)
- Azure Key Vault

The project follows a modular design to ensure **reusability, clarity, and scalability**.

---

## 📂 Project Structure

terraform/ ├── main.tf ├── providers.tf ├── variables.tf ├── outputs.tf ├── backend.tf └── modules/ ├── rg/ ├── vnet/ ├── subnet/ ├── aks/ ├── sql/ ├── acr/ └── keyvault/

Code

---

## ⚙️ Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) v1.5+
- Azure CLI (`az`) installed and authenticated
- An active Azure subscription
- Service Principal or Managed Identity with required permissions

---

## 🔑 Authentication

Login to Azure:

```bash
az login
Set the subscription:

bash
az account set --subscription "<SUBSCRIPTION_ID>"
📌 Usage
Clone the repository

bash
git clone https://github.com/<your-org>/<your-repo>.git
cd terraform
Initialize Terraform

bash
terraform init
Validate configuration

bash
terraform validate
Plan the deployment

bash
terraform plan -out tfplan
Apply the configuration

bash
terraform apply tfplan
🎯 Variables
Define variables in variables.tf or via terraform.tfvars:

hcl
variable "resource_group_name" {
  type        = string
  description = "Name of the Resource Group"
}

variable "location" {
  type        = string
  description = "Azure region for deployment"
  default     = "eastus"
}

variable "aks_cluster_name" {
  type        = string
  description = "Name of the AKS cluster"
}

variable "sql_admin_user" {
  type        = string
  description = "SQL Database admin username"
}

variable "sql_admin_password" {
  type        = string
  description = "SQL Database admin password"
  sensitive   = true
}
📤 Outputs
After deployment, Terraform will output:

Resource Group name

VNet and Subnet IDs

AKS cluster kubeconfig

SQL Database connection string

ACR login server

Key Vault URI
