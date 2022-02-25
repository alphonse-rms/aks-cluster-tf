resource "azurerm_kubernetes_cluster" "cluster_aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.cluster_name
  tags                = var.tags
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name                = var.sysnp_name
    vm_size             = var.sysnp_vm_size
    type                = var.agent_type
    vnet_subnet_id      = var.subnet_id
    availability_zones  = var.sysnp_zones
    enable_auto_scaling = var.sysnp_is_auto_scaling
    max_count           = var.sysnp_is_auto_scaling == true ? var.sysnp_max_count : null
    min_count           = var.sysnp_is_auto_scaling == true ? var.sysnp_min_count : null
    node_count          = var.sysnp_is_auto_scaling == true ? null : var.sysnp_node_count
    tags                = var.tags
  }

  identity {
    type = var.cluster_identity_type
  }

  network_profile {
    network_plugin = var.network_plugin
    outbound_type  = var.outbound_type
  }

  addon_profile {
    aci_connector_linux {
      enabled     = var.virtual_node_addon_enabled
      subnet_name = var.subnet_name
    }

    http_application_routing {
      enabled = var.http_routing_enabled
    }
  }

  provisioner "local-exec" {
    command     = "az aks get-credentials --resource-group ${var.resource_group_name} --name ${var.cluster_name}"
    interpreter = ["bash", "-c"]
  }

  lifecycle {
    ignore_changes = [
      addon_profile.0.oms_agent
    ]
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "node_pool_cluster" {
  count = var.enable_user_nodepool == true ? 1 : 0

  name                   = var.usernp_name
  kubernetes_cluster_id  = azurerm_kubernetes_cluster.cluster_aks.id
  vm_size                = var.usernp_vm_size
  availability_zones     = var.usernp_zones
  enable_auto_scaling    = var.usernp_is_auto_scaling
  node_count             = var.usernp_is_auto_scaling == true ? null : var.usernp_node_count
  max_count              = var.usernp_is_auto_scaling == true ? var.usernp_max_count : null
  min_count              = var.usernp_is_auto_scaling == true ? var.usernp_min_count : null
  os_type                = var.usernp_os_type
  enable_host_encryption = var.usernp_is_host_encrypted
  os_disk_type           = var.usernp_disk_type
  tags                   = var.tags

  lifecycle {
    ignore_changes = [vnet_subnet_id]
  }

  depends_on = [azurerm_kubernetes_cluster.cluster_aks]
}