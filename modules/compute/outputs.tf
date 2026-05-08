
output "linux-vm" {
  description = "Información completa de la VM"
  value = {
    name       = azurerm_linux_virtual_machine.linux-vm.name  
    subnet_id  = azurerm_network_interface.linux-nic.ip_configuration[0].subnet_id
    private_ip = azurerm_network_interface.linux-nic.ip_configuration[0].private_ip_address
    public_ip  = azurerm_public_ip.linux-pip.ip_address
    vm_size    = var.vm_size
  }
}

