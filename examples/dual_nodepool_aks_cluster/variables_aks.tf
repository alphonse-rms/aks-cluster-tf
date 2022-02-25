## AKS Cluster
variable "cluster_name" {
  type        = string
  description = "Cluster name that will be created"
}

variable "cluster_identity_type" {
  type        = string
  description = "Identity type"
  default     = "SystemAssigned"
}

variable "kubernetes_version" {
  type        = string
  description = "the version of Kubernetes that will be used"
  default     = "1.21.9"
}

variable "network_plugin" {
  type        = string
  description = " Network plugin to use for networking"
  default     = "azure"
}

variable "outbound_type" {
  type        = string
  description = "The egress outbound  routing method which should be used for the Kubernetes Cluster"
  default     = "loadBalancer"
}

variable "virtual_node_addon_enabled" {
  type        = bool
  description = "Enable virtual node addon "
  default     = false
}

variable "http_routing_enabled" {
  type        = bool
  description = "Is HTTP Application Routing Enabled?"
  default     = true
}

variable "agent_type" {
  type        = string
  description = "The type of Node Pool which should be created"
  default     = "VirtualMachineScaleSets"
}

## User Nodepool ##

variable "enable_user_nodepool" {
  type        = bool
  description = "Sets whether to enable the user nodepool"
  default     = false
}

variable "usernp_name" {
  type        = string
  description = "Name of the User Node pool"
  default     = "usernodepl"
}

variable "usernp_vm_size" {
  type        = string
  description = "The SKU which used for the Virtual Machines used in the User Node Pool"
  default     = "Standard_D2_v2"
}

variable "usernp_zones" {
  type        = list(string)
  description = "A list of Availability Zones across which the Node Pool should be spread"
  default     = ["1", "2", "3"]
}

variable "usernp_is_auto_scaling" {
  type        = bool
  description = "Is the Kubernetes auto scaler enabled on for the user nodepool"
  default     = false
}

variable "usernp_node_count" {
  type        = number
  description = "The initial number of nodes which should exist within the Node Pool"
  default     = 1
}

variable "usernp_max_count" {
  type        = number
  description = "The maximum number of nodes which should exist within the Node Pool"
  default     = 3
}

variable "usernp_min_count" {
  type        = number
  description = "The maximum number of nodes which should exist within the Node Pool"
  default     = 1
}

variable "usernp_os_type" {
  type        = string
  description = "The Operating System which should be used for the Node Pool"
  default     = "Linux"
}

variable "usernp_is_host_encrypted" {
  type        = bool
  description = "Is host encryption enabled"
  default     = false
}

variable "usernp_disk_type" {
  type        = string
  description = "The type of disk which should be used for the Operating System"
  default     = "Managed"
}

## Default system nodepool

variable "sysnp_name" {
  type        = string
  description = "The name of the default system nodepool (changing this will force the cluster recreation)"
  default     = "systemnodes"
}

variable "sysnp_vm_size" {
  type        = string
  description = "The size of the default system nodepool VM: Standard_DS2_v2 or Standard_E2as_v4 recommended (changing this will force the cluster recreation)"
  default     = "Standard_DS2_v2"
}

variable "sysnp_zones" {
  type        = list(string)
  description = "The list of the avalaibility usernp_zones for the system nodepool (changing this will force the cluster recreation)"
  default     = ["1", "2", "3"]
}

variable "sysnp_is_auto_scaling" {
  type        = bool
  description = "Sets whether to enable the autoscaling on the system nodepool"
  default     = false
}

variable "sysnp_node_count" {
  type        = string
  description = "The number of nodes in the default system nodepool if autoscaling is disabled"
  default     = "1"
}

variable "sysnp_max_count" {
  type        = string
  description = "The maximum number of nodes when autoscaling is enabled"
  default     = "1"
}

variable "sysnp_min_count" {
  type        = string
  description = "The minimum number of nodes when autoscaling is enabled"
  default     = "1"
}