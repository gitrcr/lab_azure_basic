# locals.tf network module
locals {
  # Subnets
  subnets = {
    gtw-vnet = {
      name             = "gtw-vnet"
      address_prefixes = ["10.44.1.0/27"]
      default_outbound_access_enabled = true
    }
    srv-vnet = {
      name             = "srv-vnet"
      address_prefixes = ["10.44.2.0/24"]
      default_outbound_access_enabled = true
    }
    db-vnet = {
      name             = "db-vnet"
      address_prefixes = ["10.44.3.0/24"]
      default_outbound_access_enabled = false
    }
  }
}