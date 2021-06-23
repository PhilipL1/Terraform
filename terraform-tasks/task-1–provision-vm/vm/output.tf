// Output the VM IPs and admin user
output "private_ip" {
    value = azurerm_linux_virtual_machine.private.private_ip_address
}
output "public_ip" {
    value = azurerm_linux_virtual_machine.public.public_ip_address
}
// VM Name Output
output "vm_name" {
  value = azurerm_linux_virtual_machine.public.name
}

// Admin User Output
output "admin_user" {
  value = azurerm_linux_virtual_machine.public.admin_username
}