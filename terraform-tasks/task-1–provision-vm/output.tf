// Public IP Output
output "public_ip" {
  value =module.vm.public_ip
}

// Private IP Output
output "private_ip" {
   value = module.vm.private_ip
}

// VM Name Output
output "vm_name" {
  value = module.vm.vm_name
}

// Admin User Output
output "admin_user" {
  value = module.vm.admin_user
}

# // output 
# output "client_certificate" {
#   value = azurerm_kubernetes_cluster.main.kube_config.0.client_certificate
# }

# output "kube_config" {
#   value = azurerm_kubernetes_cluster.main.kube_config_raw
# }
