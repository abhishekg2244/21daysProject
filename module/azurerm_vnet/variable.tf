
variable "vnets" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    address_space       = list(string)
    dns_servers         = optional(list(string))

    subnets = list(object({
      name           = string
      address_prefixes = list(string)
    }))

    tags = optional(map(string))
  }))
  description = "Map of Virtual Networks"
}
    
  