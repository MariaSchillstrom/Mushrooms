#!/bin/bash

# Skapa Storage Account
az storage account create \
  --name mymushroomstorageaccount \
  --resource-group MushroomRG \
  --location northeurope \
  --sku Standard_LRS

# Skapa Blob Container
az storage container create \
  --name myblobmushroomcontainer \
  --account-name mymushroomstorageaccount

# Hämta connection string
az storage account show-connection-string \
  --name mymushroomstorageaccount \
  --resource-group MushroomRG
