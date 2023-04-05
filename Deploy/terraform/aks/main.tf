resource "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = [var.vnet_address_space]
}

module "aks_cluster" {
  source = "./modules/aks-cluster"

  name            = local.aks_name
  rg              = azurerm_resource_group.rg.name
  location        = azurerm_resource_group.rg.location
  virtual_network = azurerm_virtual_network.vnet.name

  kubernetes_version_prefix = var.kubernetes_version_prefix
  default_node_pool         = var.aks_default_node_pool
  node_pools                = var.aks_node_pools
  virtual_node_pool         = var.aks_virtual_node_pool
  ssh_public_key_path       = var.aks_ssh_public_key_path
  ad_rbac_control           = var.aks_ad_rbac_control
  log_analytics_workspace   = var.aks_log_analytics_workspace
}
