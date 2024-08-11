#---------------------------------
# Resource Group, VNet and Subnet
#---------------------------------
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

#---------------------------------
# Generate random password for VM
#---------------------------------
resource "random_password" "password_vm" {
  length           = 32
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

#----------------------------------------------------
# Create key vault to store VM password in (optional)
#----------------------------------------------------
resource "azurerm_key_vault" "kv" {
  count               = var.create_key_vault ? 1 : 0
  name                = var.key_vault_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku_name            = "standard"
  tenant_id           = var.tenant_id
  access_policy {
    tenant_id = var.tenant_id
    object_id = var.object_id

    key_permissions = [
      "Get",
      "List",
      "Create",
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
    ]
  }
}

# Store the VM password in keyvault
resource "azurerm_key_vault_secret" "example" {
  count        = var.create_key_vault ? 1 : 0
  name         = "${azurerm_windows_virtual_machine.windows_vm.name}-password"
  value        = random_password.password_vm.result
  key_vault_id = azurerm_key_vault.kv[count.index].id
}

#-------------------------
# Windows Virtual Machine
#-------------------------
resource "azurerm_windows_virtual_machine" "windows_vm" {
  name                  = var.virtual_machine_name
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = var.virtual_machine_size
  admin_username        = var.admin_username
  admin_password        = random_password.password_vm.result
  network_interface_ids = [azurerm_network_interface.nic[*].id]

  os_disk {
    name                 = "${var.virtual_machine_name}-osdiskname"
    storage_account_type = var.os_disk_storage_account_type
    caching              = "ReadWrite"
  }

  boot_diagnostics {
    storage_account_uri = trimsuffix(tostring(azurerm_storage_account.sa_windows_vm.primary_blob_endpoint), "/")
  }

  source_image_reference {
    publisher = var.source_image["publisher"]
    offer     = var.source_image["offer"]
    sku       = var.source_image["sku"]
    version   = var.source_image["version"]
  }
}

#------------------------------------------------------------------
# Azure managed disk, disk attachment (optional) & storage account
#------------------------------------------------------------------
resource "azurerm_managed_disk" "windows_vm" {
  count                = var.data_disk_size != 0 ? 1 : 0
  name                 = "${var.virtual_machine_name}-data"
  resource_group_name  = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location
  storage_account_type = var.data_disk_type
  create_option        = var.create_option_vm
  disk_size_gb         = var.data_disk_size
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk_attachment_windows_vm" {
  count              = var.data_disk_size != 0 ? 1 : 0
  managed_disk_id    = azurerm_managed_disk.windows_vm[count.index].id
  virtual_machine_id = azurerm_windows_virtual_machine.windows_vm.id
  lun                = "1"
  caching            = "ReadWrite"
}

resource "azurerm_storage_account" "sa_windows_vm" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  min_tls_version          = "TLS1_2"
  tags                     = var.tags
}
