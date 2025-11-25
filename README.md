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

terraform/
 ├── main.tf
 ├── providers.tf
 ├── variables.tf
 ├── outputs.tf
 ├── terraform.tfvars
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

## ⚙️ Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) v1.5+
- Azure CLI (`az`) installed and authenticated
- An active Azure subscription
- Service Principal or Managed Identity with required permissions

---

## 🔑 Authentication

Login to Azure

az login
Set the subscription:

bash
az account set --subscription "<SUBSCRIPTION_ID>"

**📌 Usage**
Clone the repository

bash
git clone https://github.com/<your-org>/<your-repo>.git

cd terraform
Initialize Terraform


terraform init
Validate configuration


terraform validate
Plan the deployment


terraform plan -out tfplan
Apply the configuration


terraform apply tfplan
🎯 Variables
Define variables in variables.tf or via terraform.tfvars:




**📤 Outputs**
After deployment, Terraform will output:

Resource Group name

VNet and Subnet IDs

AKS cluster kubeconfig

SQL Database connection string

ACR login server

Key Vault URI
