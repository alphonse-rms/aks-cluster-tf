## Tags ##
variable "tags" {
  type        = map(any)
  description = "Resources Tags"
}

## Resource Group Variables ##
variable "location" {
  type        = string
  description = "Azure region where the resource group will be created"
  default     = "france central"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

## Virtual Network Variables ##
variable "network_cidr" {
  type        = string
  description = "CIDR Block for network"
}

variable "vnet_name" {
  type        = string
  description = "Virtual Network Name"
}

## Public Subnet Variables ##
variable "public_subnets" {
  type        = map(any)
  description = "Public Subnet informations map"
}

## Private Subnet Variables ##
variable "private_subnets" {
  type        = map(any)
  description = "Private Subnet  informations map"
}

## NAT Gateway ##
variable "public_subnet_gateway_ip" {
  type        = map(any)
  description = "Public IP properties for the NAT gateway"
  default = {
    name          = "public_subnet_ip"
    allocation    = "Static"
    sku           = "Standard"
    prefix_name   = "public_subnet_ip_prefix"
    prefix_length = 30
  }
}

variable "public_subnet_gateway" {
  type        = map(any)
  description = "Public subnet NAT gateway properties"
  default = {
    name    = "public_subnet_gateway"
    sku     = "Standard"
    timeout = 10
  }
}