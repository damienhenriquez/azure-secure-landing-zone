output "hub_vnet_id" {
  value = azurerm_virtual_network.hub.id
}

output "management_subnet_id" {
  value = azurerm_subnet.management.id
}

output "shared_services_subnet_id" {
  value = azurerm_subnet.shared_services.id
}