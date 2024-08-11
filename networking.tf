#----------------------------------------------------
# Network Interface Card for Windows Virtual Machine
#----------------------------------------------------
resource "azurerm_network_interface" "nic" {
  name                = "nic-${lower(var.virtual_machine_name)}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = var.tags

  ip_configuration {
    name                          = var.ipconfig_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation_type
  }
}

#----------------------------------------
# Public IP for the Windows VM (optional)
#----------------------------------------
resource "azurerm_public_ip" "pip" {
  count               = var.enable_public_ip_address == true ? 1 : 0
  name                = "pip-${lower(var.virtual_machine_name)}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
  tags                = var.tags
}

#------------------------------------------------------------------------------------------------------------------------------------------------
# Monitoring extension for New Relic (optional) - Michael is working on a script for this one. Once it's finished we can implement this later on
#------------------------------------------------------------------------------------------------------------------------------------------------

#--------------------------------------------------------------
# Network Security Group for the Virtual Machine NIC (optional)
#--------------------------------------------------------------
resource "azurerm_network_security_group" "nsg" {
  name                = lower("nsg_${var.virtual_machine_name}")
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = var.tags
}

resource "azurerm_network_security_rule" "nsg_rule" {
  for_each                    = var.nsg_rules
  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}
