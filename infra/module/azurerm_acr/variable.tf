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