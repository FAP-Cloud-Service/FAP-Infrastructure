resource "azurerm_kubernetes_cluster" "fap-frontend-application-kubernetes-cluster" {
  name                = "fap-frontend-application"
  location            = var.azure_location
  resource_group_name = var.prod-resource-group.name
  dns_prefix          = "fap-server"
  node_resource_group = "fap-frontend-application"

  default_node_pool {
    name                = "default"
    max_count           = 1
    min_count           = 3
    max_pods            = 2
    vm_size             = "Standard_B1S"
    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = true
  }
  identity {
    type = "SystemAssigned"
  }

  tags = {
    tfmanaged = "true"
  }
}
