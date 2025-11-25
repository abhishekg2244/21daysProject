## subscription variable
variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
}


## rg variable

variable "rg" {
  type = map(object({
    name       = string
    location   = string
    managed_by = optional(string)
    tags       = optional(map(string))
  }))

  description = "A map of resource groups to create."
}

## Vnet variable



variable "vnets" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    address_space       = list(string)
    dns_servers         = optional(list(string))

    subnets = list(object({
      name             = string
      address_prefixes = list(string)
    }))

    tags = optional(map(string))
  }))
  description = "Map of Virtual Networks"
}

## ACR variable
variable "acr" {
  type = map(object({
    name                = string
    resource_group_name = string
    sku                 = string
    location            = string
    admin_enabled      =  optional(bool, false)
    
  }))
    description = "Map of Azure Container Registries"
}



