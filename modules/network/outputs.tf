# Output solo con los IDs de las subredes
output "subnet_ids" {
  description = "IDs de las subredes creadas en el módulo network"
  value       = { for k, s in azurerm_subnet.subnets : k => s.id }
}

# Output nombre = rango_ip
output "subnet_name_cidr" {
  description = "Mapa con nombre de subred y su rango CIDR"
  value = {
    for k, s in azurerm_subnet.subnets : s.name => s.address_prefixes[0]
  }
}

