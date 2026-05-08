locals {
  project_id = random_id.project.hex
  rg_name    = "lab-rg-${local.project_id}"

  # Ajustar para cuentas free tier
  location   = "northeurope"
  vm_size = "Standard_D2s_v3" # cost
  # vm_size = "Standard_B2ats_v2" # freetier

  # Virtual Network Variables
  vnet_name          = "lab-net-${local.project_id}"
  vnet_address_space = ["10.44.0.0/16"]

  storage_account = "storageacc${local.project_id}"

  # Tags comunes para todos los recursos
  common_tags = {
    environment = "staging"
    project     = "azlabs"
    ManagedBy   = "terraform"
    project_id  = local.project_id
  }
}
