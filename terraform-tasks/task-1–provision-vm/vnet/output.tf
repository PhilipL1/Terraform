// Output the subnet IDs for the VMs
output "interface_ids" {
    value = {
        "public" = azurerm_network_interface.public.id
        "private" = azurerm_network_interface.private.id #MAP - similar to key:value
    }
}
output "subnet_id" {
    value = azurerm_subnet.main.id
}