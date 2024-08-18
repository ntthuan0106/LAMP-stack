output "vm_public_ip" {
  description = "The public IP address of the VM"
  value       = azurerm_public_ip.main.ip_address
}
output "vm_username" {
  description = "username of the VM"
  value = var.admin_username
}