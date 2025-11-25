variable "rg" {
  type      = map(object({
        name =  string
        location = string
        managed_by = optional(string)
        tags = optional(map(string))
  }))

   description = "A map of resource groups to create."
}