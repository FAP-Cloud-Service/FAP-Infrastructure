resource "azurerm_kubernetes_cluster" "example" {
  name                = "example-aks1"
  location            = var.azure_location
  resource_group_name = var.prod-resource-group-name
  dns_prefix          = "fap-server"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.example.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.example.kube_config_raw
  sensitive = true
}
