output "vm_public_ip" {
  description = "The public IP address of the VM from the module"
  value       = module.AzureVM.vm_public_ip
}

output "vm_username" {
  description = "VM username"
  value = module.AzureVM.vm_username
}