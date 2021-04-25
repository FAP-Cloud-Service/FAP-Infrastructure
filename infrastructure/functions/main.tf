resource "azurerm_resource_group" "fap-function-store" {
  name     = "fap-backend-application"
  location = var.azure_location
}

resource "random_id" "storage_name" {
  byte_length = 2
}

resource "random_id" "app_service_plan_name" {
  byte_length = 2
}

resource "azurerm_storage_account" "fap-backend-application-storage-account" {
  name                     = random_id.storage_name.id
  resource_group_name      = azurerm_resource_group.fap-function-store.name
  location                 = azurerm_resource_group.fap-function-store.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "fap-backend-application-storage-container" {
  name                  = "function-storage-container"
  storage_account_name  = azurerm_storage_account.fap-backend-application-storage-account.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "fap-backend-application-storage-blob" {
  name                   = "friends-and-places-server.zip"
  storage_account_name   = azurerm_storage_account.fap-backend-application-storage-account.name
  storage_container_name = azurerm_storage_container.fap-backend-application-storage-container.name
  type                   = "Block"
  source                 = var.function_zip_path
}

data "azurerm_storage_account_sas" "fap-backend-application-storage-account-sas" {
  connection_string = azurerm_storage_account.fap-backend-application-storage-account.primary_connection_string
  https_only        = true

  resource_types {
    service   = false
    container = false
    object    = true
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }

  start  = "2021-03-21T00:00:00Z"
  expiry = "2021-07-21T00:00:00Z"

  permissions {
    read    = true
    write   = false
    delete  = false
    list    = false
    add     = false
    create  = false
    update  = false
    process = false
  }
}

resource "azurerm_app_service_plan" "fap-backend-application-service-plan" {
  name                = random_id.app_service_plan_name.id
  location            = azurerm_resource_group.fap-function-store.location
  resource_group_name = azurerm_resource_group.fap-function-store.name
  kind                = "functionapp"
  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "fap-backend-application-function" {
  name                       = var.azure_function_app_name
  location                   = azurerm_resource_group.fap-function-store.location
  resource_group_name        = azurerm_resource_group.fap-function-store.name
  app_service_plan_id        = azurerm_app_service_plan.fap-backend-application-service-plan.id
  storage_account_name       = azurerm_storage_account.fap-backend-application-storage-account.name
  storage_account_access_key = azurerm_storage_account.fap-backend-application-storage-account.primary_access_key
  version                    = "~3"
  app_settings = {
    GOOGLE_API_KEY             = var.google_api_key
    DATABASE_CONNECTION_STRING = azurerm_storage_account.fap-backend-application-storage-account.primary_connection_string
    FUNCTIONS_WORKER_RUNTIME   = "dotnet"
    FUNCTION_APP_EDIT_MODE     = "readonly"
    https_only                 = true
    HASH                       = filebase64sha256(var.function_zip_path)
    WEBSITE_RUN_FROM_PACKAGE   = "https://${azurerm_storage_account.fap-backend-application-storage-account.name}.blob.core.windows.net/${azurerm_storage_container.fap-backend-application-storage-container.name}/${azurerm_storage_blob.fap-backend-application-storage-blob.name}${data.azurerm_storage_account_sas.fap-backend-application-storage-account-sas.sas}"
  }
}
