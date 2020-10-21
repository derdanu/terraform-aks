output "id" {
  value = azurerm_kubernetes_cluster.example.id
}
output "kube_config" {
  value = azurerm_kubernetes_cluster.example.kube_config_raw
}
output "kubectl" {
    value = "kubectl --kubeconfig ${path.module}${azurerm_kubernetes_cluster.example.id}/kubeconfig get nodes"
}
output "kubectl_alias" {
    value = "alias k='kubectl --kubeconfig ${path.module}${azurerm_kubernetes_cluster.example.id}/kubeconfig'"
}
resource "local_file" "kubeconfig" {
    content     = azurerm_kubernetes_cluster.example.kube_config_raw
    filename = "${path.module}${azurerm_kubernetes_cluster.example.id}/kubeconfig"
}