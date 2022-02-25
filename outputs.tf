# Contents of the cluster kube_config
output "kube_config" {
  value     = azurerm_kubernetes_cluster.cluster_aks.kube_config_raw
  sensitive = true
}

# The id of the cluster
output "id_cluster" {
  value = azurerm_kubernetes_cluster.cluster_aks.id
}
