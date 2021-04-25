output "fap-kubernetes-secrets" {
  value = {
    kubernetes-client-certificate = azurerm_kubernetes_cluster.fap-frontend-application-kubernetes-cluster.kube_config.0.client_certificate,
    kubernetes-config-raw = azurerm_kubernetes_cluster.fap-frontend-application-kubernetes-cluster.kube_config_raw
  }
}
