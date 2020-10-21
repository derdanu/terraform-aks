provider "azurerm" {
  version = "~>2.5"
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "${var.prefix}-k8s-resources"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "example" {
  name                    = "${var.prefix}-k8s"
  location                = azurerm_resource_group.example.location
  resource_group_name     = azurerm_resource_group.example.name
  dns_prefix              = "${var.prefix}-k8s"
  private_cluster_enabled = true

  network_profile {
    network_plugin = "azure"
    outbound_type  = "userDefinedRouting"
  }

  default_node_pool {
    name           = "default"
    node_count     = 1
    vm_size        = "Standard_D2_v2"
    vnet_subnet_id = azurerm_subnet.example2.id
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

