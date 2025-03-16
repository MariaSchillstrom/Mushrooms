#!/bin/bash
set -e  # Avbryt vid första felet
set -x  # Debugging: visar alla kommandon när de körs

# 1. Definiera variabler
RESOURCE_GROUP="MushroomRG"
LOCATION="northeurope"
VM_NAME="MushroomVM"
VM_SIZE="Standard_B1s"
ADMIN_USER="azureuser"
IMAGE="Ubuntu2204"
PORT="5000"
PROJECT_NAME="WeLoveMushrooms"

# 2. Skapa resursgrupp om den inte finns
echo "Skapar resursgrupp MushroomRG om den inte finns..."
az group create --name $RESOURCE_GROUP --location $LOCATION

# 3. Skapa VM om den inte finns
echo "Kollar om VM:n finns..."
if ! az vm show --resource-group $RESOURCE_GROUP --name $VM_NAME; then
    echo "Skapar VM $VM_NAME..."
    az vm create --resource-group $RESOURCE_GROUP --name $VM_NAME --image $IMAGE --admin-username $ADMIN_USER --generate-ssh-keys --size $VM_SIZE
else
    echo "VM $VM_NAME finns redan!"
fi

# 4. Öppna portar på VM:n
echo "Öppnar portar på VM:n..."

# Skapa de öppna portarna (utan port 22)
az vm open-port --resource-group $RESOURCE_GROUP --name $VM_NAME --port 5000 --priority 1010
az vm open-port --resource-group $RESOURCE_GROUP --name $VM_NAME --port 80 --priority 1020

echo "✅ VM och portarna är nu öppna!"