# AKS Cluster TF

A Terraform module to create AKS Cluster.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


## Usage

```hcl
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

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent_type"></a> [agent\_type](#input\_agent\_type) | The type of Node Pool which should be created | `string` | `"VirtualMachineScaleSets"` | no |
| <a name="input_cluster_identity_type"></a> [cluster\_identity\_type](#input\_cluster\_identity\_type) | Identity type | `string` | `"SystemAssigned"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Cluster name that will be created | `string` | n/a | yes |
| <a name="input_enable_user_nodepool"></a> [enable\_user\_nodepool](#input\_enable\_user\_nodepool) | Sets whether to enable the user nodepool | `bool` | `false` | no |
| <a name="input_http_routing_enabled"></a> [http\_routing\_enabled](#input\_http\_routing\_enabled) | Is HTTP Application Routing Enabled? | `bool` | `true` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | the version of Kubernetes that will be used | `string` | `"1.21.9"` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region where the resource group will be created | `string` | n/a | yes |
| <a name="input_network_plugin"></a> [network\_plugin](#input\_network\_plugin) | Network plugin to use for networking | `string` | `"kubenet"` | no |
| <a name="input_outbound_type"></a> [outbound\_type](#input\_outbound\_type) | The egress outbound  routing method which should be used for the Kubernetes Cluster | `string` | `"loadBalancer"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of a Subnet where the Kubernetes Node Pool should exist | `string` | n/a | yes |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | The subnet name for the virtual nodes to run | `string` | n/a | yes |
| <a name="input_sysnp_is_auto_scaling"></a> [sysnp\_is\_auto\_scaling](#input\_sysnp\_is\_auto\_scaling) | Sets whether to enable the autoscaling on the system nodepool | `bool` | `false` | no |
| <a name="input_sysnp_max_count"></a> [sysnp\_max\_count](#input\_sysnp\_max\_count) | The maximum number of nodes when autoscaling is enabled | `string` | `"1"` | no |
| <a name="input_sysnp_min_count"></a> [sysnp\_min\_count](#input\_sysnp\_min\_count) | The minimum number of nodes when autoscaling is enabled | `string` | `"1"` | no |
| <a name="input_sysnp_name"></a> [sysnp\_name](#input\_sysnp\_name) | The name of the default system nodepool (changing this will force the cluster recreation) | `string` | `"systemnodes"` | no |
| <a name="input_sysnp_node_count"></a> [sysnp\_node\_count](#input\_sysnp\_node\_count) | The number of nodes in the default system nodepool if autoscaling is disabled | `string` | `"1"` | no |
| <a name="input_sysnp_vm_size"></a> [sysnp\_vm\_size](#input\_sysnp\_vm\_size) | The size of the default system nodepool VM: Standard\_DS2\_v2 or Standard\_E2as\_v4 recommended (changing this will force the cluster recreation) | `string` | `"Standard_DS2_v2"` | no |
| <a name="input_sysnp_zones"></a> [sysnp\_zones](#input\_sysnp\_zones) | The list of the avalaibility usernp\_zones for the system nodepool (changing this will force the cluster recreation) | `list(string)` | <pre>[<br>  "1",<br>  "2",<br>  "3"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Resources Tags | `map(any)` | n/a | yes |
| <a name="input_usernp_disk_type"></a> [usernp\_disk\_type](#input\_usernp\_disk\_type) | The type of disk which should be used for the Operating System | `string` | `"Managed"` | no |
| <a name="input_usernp_is_auto_scaling"></a> [usernp\_is\_auto\_scaling](#input\_usernp\_is\_auto\_scaling) | Is the Kubernetes auto scaler enabled on for the user nodepool | `bool` | `false` | no |
| <a name="input_usernp_is_host_encrypted"></a> [usernp\_is\_host\_encrypted](#input\_usernp\_is\_host\_encrypted) | Is host encryption enabled | `bool` | `false` | no |
| <a name="input_usernp_max_count"></a> [usernp\_max\_count](#input\_usernp\_max\_count) | The maximum number of nodes which should exist within the Node Pool | `number` | `3` | no |
| <a name="input_usernp_min_count"></a> [usernp\_min\_count](#input\_usernp\_min\_count) | The maximum number of nodes which should exist within the Node Pool | `number` | `1` | no |
| <a name="input_usernp_name"></a> [usernp\_name](#input\_usernp\_name) | Name of the User Node pool | `string` | `"usernodepl"` | no |
| <a name="input_usernp_node_count"></a> [usernp\_node\_count](#input\_usernp\_node\_count) | The initial number of nodes which should exist within the Node Pool | `number` | `1` | no |
| <a name="input_usernp_os_type"></a> [usernp\_os\_type](#input\_usernp\_os\_type) | The Operating System which should be used for the Node Pool | `string` | `"Linux"` | no |
| <a name="input_usernp_vm_size"></a> [usernp\_vm\_size](#input\_usernp\_vm\_size) | The SKU which used for the Virtual Machines used in the User Node Pool | `string` | `"Standard_D2_v2"` | no |
| <a name="input_usernp_zones"></a> [usernp\_zones](#input\_usernp\_zones) | A list of Availability Zones across which the Node Pool should be spread | `list(string)` | <pre>[<br>  "1",<br>  "2",<br>  "3"<br>]</pre> | no |
| <a name="input_virtual_node_addon_enabled"></a> [virtual\_node\_addon\_enabled](#input\_virtual\_node\_addon\_enabled) | Enable virtual node addon | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id_cluster"></a> [id\_cluster](#output\_id\_cluster) | The id of the cluster |
| <a name="output_kube_config"></a> [kube\_config](#output\_kube\_config) | Contents of the cluster kube\_config |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
