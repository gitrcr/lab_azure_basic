## Network Config WIN0

# Create a Public IP
resource "azurerm_public_ip" "linux-pip" {
  name                = "pip-${var.project_id}"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
}

# Create a Network Interface LIN0
resource "azurerm_network_interface" "linux-nic" {
  name                = "nic-${var.project_id}"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_ids["gtw-vnet"] 
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux-pip.id
  }

  # depends_on = [ azurerm_windows_virtual_machine.lin0 ]

}

# Create a Network Security Group and rules
resource "azurerm_network_security_group" "linux-nsg" {
  name                = "nsg-${var.project_id}"
  location            = var.location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

# Associate the Network Security Group with the Subnet
resource "azurerm_subnet_network_security_group_association" "linux-nsg-aso" {

  subnet_id                 = var.subnet_ids["gtw-vnet"]
  network_security_group_id = azurerm_network_security_group.linux-nsg.id
}


#### LINUX SRV

# Create a Virtual Machine

resource "azurerm_linux_virtual_machine" "linux-vm" {
  name                = "linux-${var.project_id}"
  location            = var.location
  resource_group_name = var.rg_name
  size                = var.vm_size
  admin_username      = "labadmin"

  network_interface_ids = [
    azurerm_network_interface.linux-nic.id
  ]

  admin_ssh_key {
    username   = "labadmin"
    public_key = file("${path.module}/${var.ssh_key_path}")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

}










