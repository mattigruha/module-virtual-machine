output "vm_name" {
  value = azurerm_windows_virtual_machine.windows_vm.id
}

output "public_ip_vm" {
  value = azurerm_public_ip.pip[*].ip_address
}

output "private_ip_vm" {
  value = azurerm_network_interface.nic.private_ip_address
}
