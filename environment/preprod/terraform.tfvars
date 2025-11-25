subscription_id = "dcb52f24-3382-4902-9301-084ebd8ec819"

# rg configuraton 

rg = {
  "rg1" = {
    name       = "todo-preprod-rg1"
    location   = "East US"
    managed_by = "devops-team"

    tags = {
      environment = "preprod"
      project     = "todo21daysProject"
    }

  }
}


# vnet configuration

vnets = {
  vnet1 = {
    name                = "todo-preprod-vnet"
    resource_group_name = "todo-preprod-rg1"
    location            = "East US"
    address_space       = ["10.0.0.0/16"]

    subnets = [
      {
        name             = "subnet1"
        address_prefixes = ["10.0.1.0/24"]
      }
    ]

    tags = {
      environment = "preprod"
      project     = "todo21daysProject"
    }
  }
}


# ACR configuration
acr = {
    acr1 = {
      name                = "todopreprodacr01"
      resource_group_name = "todo-preprod-rg1"
      location            = "East US"
      sku                 = "Basic"
      admin_enabled       = false
    }
}