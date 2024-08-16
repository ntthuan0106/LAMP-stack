/*module "AzureVM" {
  source = "./modules/AzureVM"
  rg_name = "LAMP-stack"
  network_interface_name = "Test"
  virtual_network_name = "Test"
  VM-name = "LAMP-server"
}*/
resource "azurerm_resource_group" "name" {
  name = "testRG"
  location = "East US"
}