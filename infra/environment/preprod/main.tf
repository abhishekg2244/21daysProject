module "rg" {
  source = "../../module/azurerm_resource_group"
  rg     = var.rg
}

module "vnet" {
  depends_on = [module.rg]
  source     = "../../module/azurerm_vnet"
  vnets      = var.vnets
}   

module "acr" {
  depends_on = [module.rg]
  source     = "../../module/azurerm_acr"
  acr        = var.acr  
}