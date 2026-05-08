resource "azurerm_virtual_network" "lab-net" {
  location            = var.location
  resource_group_name = var.rg_name
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  tags                = var.common_tags



}

resource "azurerm_subnet" "subnets" {
  for_each = local.subnets

  resource_group_name  = azurerm_virtual_network.lab-net.resource_group_name
  virtual_network_name = azurerm_virtual_network.lab-net.name

  name             = each.value.name
  address_prefixes = each.value.address_prefixes
  default_outbound_access_enabled = each.value.default_outbound_access_enabled

}


