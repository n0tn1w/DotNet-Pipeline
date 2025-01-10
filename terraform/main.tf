provider "azurerm" {
  version = "~> 3.11"
  features {}
}

resource "azurerm_resource_group" "arg" {
  name     = "maingroup-terra"
  location = "West Europe"
 }

resource "azurerm_container_registry" "acr" {
  name                = "dotnetshipterra"
  resource_group_name = azurerm_resource_group.arg.name
  location            = azurerm_resource_group.arg.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_app_service_plan" "plan" {
  name                = "net-n0tn1w-app-ship-plan-terra"
  location            = azurerm_resource_group.arg.location
  resource_group_name = azurerm_resource_group.arg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_storage_account" "asa" {
  name                     = "tfstatefileterra"
  resource_group_name      = azurerm_resource_group.arg.name
  location                 = azurerm_resource_group.arg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "dev"
  }
}

resource "azurerm_app_service" "app" {
  name                = "dotnet-ship-terra"
  location            = azurerm_resource_group.arg.location
  resource_group_name = azurerm_resource_group.arg.name
  app_service_plan_id = azurerm_app_service_plan.plan.id


  app_settings = {
    "DOCKER_REGISTRY_SERVER_URL"      = "https://${azurerm_container_registry.acr.login_server}/"
    "DOCKER_REGISTRY_SERVER_USERNAME" = azurerm_container_registry.acr.admin_username
    "DOCKER_REGISTRY_SERVER_PASSWORD" = azurerm_container_registry.acr.admin_password
    "WEBSITES_PORT"                   = "5099"
    "DOCKER_ENABLE_CI"                = "true"
  }

  site_config {
    linux_fx_version = "DOCKER|${azurerm_container_registry.acr.login_server}/dotnet-pipe:latest"
  }

  depends_on = [azurerm_container_registry.acr]
}

output "web_app_ip" {
  value = azurerm_app_service.app.default_site_hostname
}
