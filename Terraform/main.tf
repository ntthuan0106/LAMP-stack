module "AzureVM" {
  source = "./modules/AzureVM"
  rg_name = "LAMP-stack-1"
  network_interface_name = "Test"
  virtual_network_name = "Test"
  VM-name = "LAMP-server"
}
