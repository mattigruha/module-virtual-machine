## Azure Windows Virtual Machine
This Terraform module deploys a Windows Virtual Machine with: Resource Group, Image (latest Windows Server), Managed Disk, Storage Account, NIC, Public IP, Network Security Group, NSG rules and Key Vault to store the generated VM password.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0.0, < 4.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.75.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_secret.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_managed_disk.windows_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk) | resource |
| [azurerm_network_interface.nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_security_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.nsg_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_public_ip.pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.sa_windows_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_subnet.snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_machine_data_disk_attachment.disk_attachment_windows_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_windows_virtual_machine.windows_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [random_password.password_vm](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | The username of the local administrator used for the Virtual Machine. | `string` | `"azureadmin"` | no |
| <a name="input_create_key_vault"></a> [create\_key\_vault](#input\_create\_key\_vault) | Create a Key Vault to store secrets (optional) | `bool` | `false` | no |
| <a name="input_create_network_interface_card"></a> [create\_network\_interface\_card](#input\_create\_network\_interface\_card) | Determine whether a NIC needs to be created for the VM | `bool` | `true` | no |
| <a name="input_create_option_vm"></a> [create\_option\_vm](#input\_create\_option\_vm) | Which method to use when creating the managed disk. Possible values are Import, ImportSecure, Empty, Copy, FromImage, Restore and Upload | `string` | `"Empty"` | no |
| <a name="input_create_vnet_and_subnet"></a> [create\_vnet\_and\_subnet](#input\_create\_vnet\_and\_subnet) | Determine whether a new VNET and subnet need to be created | `bool` | `true` | no |
| <a name="input_data_disk_size"></a> [data\_disk\_size](#input\_data\_disk\_size) | Amount of disk space for the data disk. This disk gets created when this is numeric in GB | `string` | `"0"` | no |
| <a name="input_data_disk_type"></a> [data\_disk\_type](#input\_data\_disk\_type) | Type of disk for the data disk. Defaults to standard | `string` | `"Standard_LRS"` | no |
| <a name="input_enable_public_ip_address"></a> [enable\_public\_ip\_address](#input\_enable\_public\_ip\_address) | Reference to a Public IP Address to associate with the NIC | `any` | `null` | no |
| <a name="input_ipconfig_name"></a> [ipconfig\_name](#input\_ipconfig\_name) | Name for the IP configuration on the NIC | `string` | `""` | no |
| <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name) | Provide a name for the key vault | `string` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | The location where the resource group is located | `string` | `"West Europe"` | no |
| <a name="input_nsg_rules"></a> [nsg\_rules](#input\_nsg\_rules) | The NSG rules that will be used for inbound and outbound trafic | <pre>map(object({<br>    name                       = string<br>    priority                   = number<br>    access                     = string<br>    protocol                   = string<br>    direction                  = string<br>    source_port_range          = string<br>    destination_port_range     = number<br>    source_address_prefix      = string<br>    destination_address_prefix = string<br>  }))</pre> | `{}` | no |
| <a name="input_object_id"></a> [object\_id](#input\_object\_id) | The object ID used for the key vault and access policy | `string` | `false` | no |
| <a name="input_os_disk_storage_account_type"></a> [os\_disk\_storage\_account\_type](#input\_os\_disk\_storage\_account\_type) | The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard\_LRS, StandardSSD\_LRS and Premium\_LRS. | `string` | `"StandardSSD_LRS"` | no |
| <a name="input_private_ip_address_allocation_type"></a> [private\_ip\_address\_allocation\_type](#input\_private\_ip\_address\_allocation\_type) | The allocation method used for the Private IP Address. Possible values are Dynamic and Static. | `string` | `"Dynamic"` | no |
| <a name="input_public_ip_allocation_method"></a> [public\_ip\_allocation\_method](#input\_public\_ip\_allocation\_method) | Defines the allocation method for this IP address. Possible values are `Static` or `Dynamic` | `string` | `"Static"` | no |
| <a name="input_public_ip_sku"></a> [public\_ip\_sku](#input\_public\_ip\_sku) | The SKU of the Public IP. Accepted values are `Basic` and `Standard` | `string` | `"Standard"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | A group that holds related resources for an Azure solution | `string` | n/a | yes |
| <a name="input_snet_address_prefixes"></a> [snet\_address\_prefixes](#input\_snet\_address\_prefixes) | The address prefixes that will be used for the subnet | `list(string)` | <pre>[<br>  "10.0.1.0/24"<br>]</pre> | no |
| <a name="input_source_image"></a> [source\_image](#input\_source\_image) | Provide the custom image to this module if the default variants are not sufficient | <pre>object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  })</pre> | <pre>{<br>  "offer": "WindowsServer",<br>  "publisher": "MicrosoftWindowsServer",<br>  "sku": "2022-Datacenter",<br>  "version": "latest"<br>}</pre> | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | The name for the storage account related to the Windows Virtual Machine | `string` | `"storageaccountforvm"` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | The name of the subnet to use in VM scale set | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The tenant ID used for the key vault and access policy | `string` | `false` | no |
| <a name="input_virtual_machine_name"></a> [virtual\_machine\_name](#input\_virtual\_machine\_name) | The name of the virtual machine. | `string` | n/a | yes |
| <a name="input_virtual_machine_size"></a> [virtual\_machine\_size](#input\_virtual\_machine\_size) | The Virtual Machine SKU for the Virtual Machine, Default is Standard\_A2\_V2 | `string` | `"Standard_A2_v2"` | no |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | The name of the virtual network | `string` | n/a | yes |
| <a name="input_vnet_address_space"></a> [vnet\_address\_space](#input\_vnet\_address\_space) | The address space for the vnet | `list(string)` | <pre>[<br>  "10.0.0.0/16"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_public_ip_vm"></a> [public\_ip\_vm](#output\_public\_ip\_vm) | n/a |
| <a name="output_vm_name"></a> [vm\_name](#output\_vm\_name) | n/a |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0.0, < 4.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.75.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_secret.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_managed_disk.windows_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk) | resource |
| [azurerm_network_interface.nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_security_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.nsg_rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_public_ip.pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.sa_windows_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_virtual_machine_data_disk_attachment.disk_attachment_windows_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |
| [azurerm_windows_virtual_machine.windows_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |
| [random_password.password_vm](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | The username of the local administrator used for the Virtual Machine. | `string` | `"azureadmin"` | no |
| <a name="input_create_key_vault"></a> [create\_key\_vault](#input\_create\_key\_vault) | Create a Key Vault to store secrets (optional) | `bool` | `false` | no |
| <a name="input_create_option_vm"></a> [create\_option\_vm](#input\_create\_option\_vm) | Which method to use when creating the managed disk. Possible values are Import, ImportSecure, Empty, Copy, FromImage, Restore and Upload | `string` | `"Empty"` | no |
| <a name="input_data_disk_size"></a> [data\_disk\_size](#input\_data\_disk\_size) | Amount of disk space for the data disk. This disk gets created when this is numeric in GB | `string` | `"0"` | no |
| <a name="input_data_disk_type"></a> [data\_disk\_type](#input\_data\_disk\_type) | Type of disk for the data disk. Defaults to standard | `string` | `"Standard_LRS"` | no |
| <a name="input_enable_public_ip_address"></a> [enable\_public\_ip\_address](#input\_enable\_public\_ip\_address) | Reference to a Public IP Address to associate with the NIC | `any` | `null` | no |
| <a name="input_ipconfig_name"></a> [ipconfig\_name](#input\_ipconfig\_name) | Name for the IP configuration on the NIC | `string` | `""` | no |
| <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name) | Provide a name for the key vault | `string` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | The location where the resource group is located | `string` | `"West Europe"` | no |
| <a name="input_nsg_rules"></a> [nsg\_rules](#input\_nsg\_rules) | The NSG rules that will be used for inbound and outbound trafic | <pre>map(object({<br>    name                       = string<br>    priority                   = number<br>    access                     = string<br>    protocol                   = string<br>    direction                  = string<br>    source_port_range          = string<br>    destination_port_range     = number<br>    source_address_prefix      = string<br>    destination_address_prefix = string<br>  }))</pre> | `{}` | no |
| <a name="input_object_id"></a> [object\_id](#input\_object\_id) | The object ID used for the key vault and access policy | `string` | `false` | no |
| <a name="input_os_disk_storage_account_type"></a> [os\_disk\_storage\_account\_type](#input\_os\_disk\_storage\_account\_type) | The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard\_LRS, StandardSSD\_LRS and Premium\_LRS. | `string` | `"StandardSSD_LRS"` | no |
| <a name="input_private_ip_address_allocation_type"></a> [private\_ip\_address\_allocation\_type](#input\_private\_ip\_address\_allocation\_type) | The allocation method used for the Private IP Address. Possible values are Dynamic and Static. | `string` | `"Dynamic"` | no |
| <a name="input_public_ip_allocation_method"></a> [public\_ip\_allocation\_method](#input\_public\_ip\_allocation\_method) | Defines the allocation method for this IP address. Possible values are `Static` or `Dynamic` | `string` | `"Static"` | no |
| <a name="input_public_ip_sku"></a> [public\_ip\_sku](#input\_public\_ip\_sku) | The SKU of the Public IP. Accepted values are `Basic` and `Standard` | `string` | `"Standard"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | A group that holds related resources for an Azure solution | `string` | n/a | yes |
| <a name="input_source_image"></a> [source\_image](#input\_source\_image) | Provide the custom image to this module if the default variants are not sufficient | <pre>object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  })</pre> | <pre>{<br>  "offer": "WindowsServer",<br>  "publisher": "MicrosoftWindowsServer",<br>  "sku": "2022-Datacenter",<br>  "version": "latest"<br>}</pre> | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | The name for the storage account related to the Windows Virtual Machine | `string` | `"storageaccountforvm"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The subnet ID of the IP configuration for the NIC that will be attached to the VM | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The tenant ID used for the key vault and access policy | `string` | `false` | no |
| <a name="input_virtual_machine_name"></a> [virtual\_machine\_name](#input\_virtual\_machine\_name) | The name of the virtual machine. | `string` | n/a | yes |
| <a name="input_virtual_machine_size"></a> [virtual\_machine\_size](#input\_virtual\_machine\_size) | The Virtual Machine SKU for the Virtual Machine, Default is Standard\_A2\_V2 | `string` | `"Standard_A2_v2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_ip_vm"></a> [private\_ip\_vm](#output\_private\_ip\_vm) | n/a |
| <a name="output_public_ip_vm"></a> [public\_ip\_vm](#output\_public\_ip\_vm) | n/a |
| <a name="output_vm_name"></a> [vm\_name](#output\_vm\_name) | n/a |


## Example Usage
```hcl
module "sql_database_module" {
  source = "../.." # Replace with the actual module source
  # Input variables for the RG and location
  resource_group_name = "rg-test-vm"       # Provide the proper resource group
  location            = "West Europe"      # West Europe is default, change if needed

  # Input for the IP and NSG rules
  virtual_network_name               = "test-vnet"
  subnet_name                        = "test-subnet"
  vnet_address_space                 = ["10.0.0.0/16"]      # Default, change if needed
  snet_address_prefixes              = ["10.0.1.0/24"]      # Default, change if needed
  private_ip_address_allocation_type = "Dynamic"            # or "Static" if needed
  enable_public_ip_address           = true                 # or false if not needed
  public_ip_allocation_method        = "Static"             # or "Dynamic" if needed
  public_ip_sku                      = "Standard"           # or "Basic" if needed
  ipconfig_name                      = "ip_name"            # Provide your custom IP name

  # The nsg rules are optional, the default is empty. Please don't forget to specify the source address prefix when using nsg rules to prevent
  # any to any ports to be left open.
  nsg_rules = {
    RDP = {
      name                       = "RDP"
      priority                   = 100
      access                     = "Allow"
      protocol                   = "Tcp"
      direction                  = "Inbound"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
    # You can add more rules if needed in the configuration
  }

  # Input for the storage account and datadisk
  os_disk_storage_account_type = "StandardSSD_LRS" # Choose the desired storage type
  storage_account_name         = "sabatmantest"    # Provide the correct name
  data_disk_size               = "1024"            # Set to 0 if no data disk is needed
  data_disk_type               = "Standard_LRS"    # Choose the desired data disk type

  # Input for the Windows Virtual Machine
  virtual_machine_name = "batman-test"
  virtual_machine_size = "Standard_DS2_v2"         # Choose the desired VM size
  admin_username       = "myadmin"
  create_option_vm     = "Empty"                   # Choose the desired method

  # Creation of the keyvault and access policy (optional)
  create_key_vault = true       # Default is false. If set to true, the random generated password will be stored in this keyvault
  tenant_id        = "*"        # Use data.azurerm_client_config.current.tenant_id to retrieve the ID
  object_id        = "*"        # Use data.azurerm_client_config.current.object_id to retrieve the ID

  tags = {                      # Change the tagging to the proper ones
    "environment" = "sbx"
    "owner"       = "batman"
  }
}
