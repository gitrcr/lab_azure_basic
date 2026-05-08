output "project_id" {
  description = "Project ID"
  value       = local.project_id
}

output "location" {
  description = "Location of the Resource Group created"
  value       = local.location
}

output "rg_name" {
  description = "Name of the Resource Group created"
  value       = local.rg_name
}

output "subnet_name_cidr" {
  description = "Subnet name and cidr"
  value       = module.network.subnet_name_cidr
}

# remove the rows between "====" if use local state file and review main.tf
# ====
output "storage_account" {
  description = "Storage Account, remove if no use"
  value       = azurerm_storage_account.storageacc.name
}
# ====

output "linux-vm" {
  description = "Linux server info"
  value       = module.compute.linux-vm
}
