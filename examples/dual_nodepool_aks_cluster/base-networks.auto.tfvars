## Tags ##
tags = {
  Environment = "testing"
}

## Resource Group Variables ##
resource_group_name = "test-00007"
location            = "westeurope"

## Virtual Network Variables ##
vnet_name    = "azure_net"
network_cidr = "10.0.0.0/8"

## Public Subnet Variables ##
public_subnets = {}

## Private Subnet Variables ##
private_subnets = {
  private_subnet_compute = {
    name                       = "private_subnet_compute"
    address_prefixes           = ["10.2.0.0/16"]
    private_subnet_delegations = {}
  }
}

## NAT Gateway ##
public_subnet_gateway_ip = {
  name          = "public_subnet_ip"
  allocation    = "Static"
  sku           = "Standard"
  prefix_name   = "public_subnet_ip_prefix"
  prefix_length = 30
}

public_subnet_gateway = {
  name    = "public_subnet_gateway"
  sku     = "Standard"
  timeout = 10
}