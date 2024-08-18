resource "azurerm_resource_group" "VM-group" {
  name = var.rg_name
  location = var.rg_location
}

resource "azurerm_virtual_network" "main" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.VM-group.location
  resource_group_name = azurerm_resource_group.VM-group.name
}

resource "azurerm_public_ip" "main" {
  name                = "PublicIP"
  location            = azurerm_resource_group.VM-group.location
  resource_group_name = azurerm_resource_group.VM-group.name
  allocation_method   = "Dynamic"
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.VM-group.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}
resource "azurerm_network_interface" "main" {
  name                = var.network_interface_name
  location            = azurerm_resource_group.VM-group.location
  resource_group_name = azurerm_resource_group.VM-group.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.main.id
  }
}

resource "azurerm_ssh_public_key" "az_pub_key" {
  name                = "pub_keys"
  resource_group_name = azurerm_resource_group.VM-group.name
  location            = azurerm_resource_group.VM-group.location
  public_key          = file("~/.ssh/new_thuan.pub")
}
resource "azurerm_virtual_machine" "main" {
  name                  = var.VM-name
  location            = azurerm_resource_group.VM-group.location
  resource_group_name = azurerm_resource_group.VM-group.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_B2s_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "MyOSdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    disk_size_gb = 30
  }
  os_profile {
    computer_name  = "LampServer"
    admin_username = "thuan"
    admin_password = "Thuan05031301@"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = "staging"
  }
}