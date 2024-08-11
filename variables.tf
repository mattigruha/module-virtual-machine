variable "resource_group_name" {
  description = "A group that holds related resources for an Azure solution"
  type        = string
}

variable "location" {
  description = "The location where the resource group is located"
  default     = "West Europe"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID of the IP configuration for the NIC that will be attached to the VM"
  type        = string
}

variable "virtual_machine_name" {
  description = "The name of the virtual machine."
  type        = string
}

variable "virtual_machine_size" {
  description = "The Virtual Machine SKU for the Virtual Machine, Default is Standard_A2_V2"
  default     = "Standard_A2_v2"
  type        = string
}

variable "private_ip_address_allocation_type" {
  description = "The allocation method used for the Private IP Address. Possible values are Dynamic and Static."
  default     = "Dynamic"
  type        = string
}

variable "enable_public_ip_address" {
  description = "Reference to a Public IP Address to associate with the NIC"
  default     = null
  type        = any
}

variable "public_ip_allocation_method" {
  description = "Defines the allocation method for this IP address. Possible values are `Static` or `Dynamic`"
  default     = "Static"
  type        = string
}

variable "public_ip_sku" {
  description = "The SKU of the Public IP. Accepted values are `Basic` and `Standard`"
  default     = "Standard"
  type        = string
}

variable "source_image" {
  description = "Provide the custom image to this module if the default variants are not sufficient"
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest" # currently the latest 20348.1906.230803
  }
}

variable "os_disk_storage_account_type" {
  description = "The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS and Premium_LRS."
  default     = "StandardSSD_LRS"
  type        = string
}

variable "storage_account_name" {
  description = "The name for the storage account related to the Windows Virtual Machine"
  type        = string
  default     = "storageaccountforvm"
}

variable "data_disk_size" {
  description = "Amount of disk space for the data disk. This disk gets created when this is numeric in GB"
  default     = "0"
  type        = string
}

variable "data_disk_type" {
  description = "Type of disk for the data disk. Defaults to standard"
  default     = "Standard_LRS"
  type        = string
}

variable "admin_username" {
  description = "The username of the local administrator used for the Virtual Machine."
  default     = "azureadmin"
  type        = string
}

variable "create_key_vault" {
  description = "Create a Key Vault to store secrets (optional)"
  default     = false
  type        = bool
}

variable "key_vault_name" {
  description = "Provide a name for the key vault"
  default     = false
  type        = string
}

variable "tenant_id" {
  description = "The tenant ID used for the key vault and access policy"
  default     = false
  type        = string
}

variable "object_id" {
  description = "The object ID used for the key vault and access policy"
  default     = false
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "ipconfig_name" {
  description = "Name for the IP configuration on the NIC"
  default     = ""
  type        = string
}

variable "create_option_vm" {
  description = "Which method to use when creating the managed disk. Possible values are Import, ImportSecure, Empty, Copy, FromImage, Restore and Upload"
  type        = string
  default     = "Empty"
}

variable "nsg_rules" {
  description = "The NSG rules that will be used for inbound and outbound trafic"
  type = map(object({
    name                       = string
    priority                   = number
    access                     = string
    protocol                   = string
    direction                  = string
    source_port_range          = string
    destination_port_range     = number
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = {}
}
