resource "random_id" "project" {
  byte_length = 4
}

resource "azurerm_resource_group" "lab-rg" {
  name     = local.rg_name
  location = local.location
  tags     = local.common_tags
}

# remove the rows between "====" if use local state file and review outputs.tf
# ====
resource "azurerm_storage_account" "storageacc" {

  name                     = local.storage_account
  resource_group_name      = azurerm_resource_group.lab-rg.name
  location                 = azurerm_resource_group.lab-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.common_tags
}
# ====

module "network" {
  source             = "./modules/network"
  rg_name            = azurerm_resource_group.lab-rg.name
  location           = local.location
  vnet_name          = local.vnet_name
  vnet_address_space = local.vnet_address_space
  common_tags        = local.common_tags
}

module "compute" {
  source     = "./modules/compute"
  rg_name    = azurerm_resource_group.lab-rg.name
  location   = local.location
  vm_size    = local.vm_size 
  subnet_ids = module.network.subnet_ids
  project_id = local.project_id 
}
