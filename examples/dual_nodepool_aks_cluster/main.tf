provider "azurerm" {
  features {
  }
}

# Create network
module "azure-base-networks" {
  source = "git::https://gitlab.com/keltiotechnology/terraform/modules/azure/azure-base-networks?ref=v1.0"
  tags   = var.tags

  ## Resource Group ##
  resource_group_name = var.resource_group_name
  location            = var.location

  ## Virtual Network Variables ##
  vnet_name    = var.vnet_name
  network_cidr = var.network_cidr

  ## Public Subnet Variables ##
  public_subnets = var.public_subnets

  ## Private Subnet Variables ##
  private_subnets = var.private_subnets

  ## NAT Gateway Variables ##
  public_subnet_gateway_ip = var.public_subnet_gateway_ip
  public_subnet_gateway    = var.public_subnet_gateway
}

# Create AKS Cluster
module "cluster_aks" {

  source = "../.."
  tags   = var.tags
  depends_on = [
    module.azure-base-networks
  ]

  ## Resource Group Variables ##
  resource_group_name = var.resource_group_name
  location            = var.location

  ## Cluster
  cluster_name = "foocluster"
  subnet_name  = module.azure-base-networks.private_subnets["private_subnet_compute"].name
  subnet_id    = module.azure-base-networks.private_subnets["private_subnet_compute"].id

  ## System Node pool
  sysnp_name            = var.sysnp_name
  sysnp_vm_size         = var.sysnp_vm_size
  sysnp_zones           = var.sysnp_zones
  sysnp_is_auto_scaling = var.sysnp_is_auto_scaling
  sysnp_max_count       = var.sysnp_max_count
  sysnp_min_count       = var.sysnp_min_count

  ## User Node pool
  enable_user_nodepool   = var.enable_user_nodepool
  usernp_name            = var.usernp_name
  usernp_vm_size         = var.usernp_vm_size
  usernp_is_auto_scaling = var.usernp_is_auto_scaling
  usernp_min_count       = var.usernp_min_count
  usernp_max_count       = var.usernp_max_count
  usernp_os_type         = var.usernp_os_type
  usernp_zones           = var.usernp_zones
  usernp_disk_type       = var.usernp_disk_type
}
