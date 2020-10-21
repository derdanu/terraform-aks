resource "azurerm_route_table" "example" {
  name                = "example-routetable"
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name

  route {
    name                   = "example"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.1.254.4"
  }
}

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  address_space       = ["10.1.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example1" {
  name                 = "private-zone"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.1.254.0/24"]
}

resource "azurerm_subnet" "example2" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.1.0.0/23"]
}

resource "azurerm_subnet_route_table_association" "example" {
  subnet_id      = azurerm_subnet.example2.id
  route_table_id = azurerm_route_table.example.id
}