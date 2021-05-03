resource "azurerm_kubernetes_cluster" "fap-frontend-application-kubernetes-cluster" {
  name                = "fap-frontend-application"
  location            = var.azure_location
  resource_group_name = var.prod_resource_group.name
  dns_prefix          = "fap-server"
  node_resource_group = "fap-frontend-application"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B1ms"
  }
  identity {
    type = "SystemAssigned"
  }

  tags = var.azure_tags
}
