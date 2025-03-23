#!/bin/bash 
set -e  # Avbryt vid första felet
set -x  # Debugging: visar alla kommandon när de körs

# 1. Definiera variabler
RESOURCE_GROUP="MushroomRG"          # Samma resursgrupp om du vill
LOCATION="northeurope"              # Välj din region
VM_NAME="NginxMushroomVM"                   # Nytt namn för Reverse Proxy VM 
VM_SIZE="Standard_B1s"              # VM-storlek (ändra vid behov)
ADMIN_USER="azureuser"              # Adminanvändare
IMAGE="Ubuntu2204"                  # Välj en Ubuntu-Image för Nginx-server
PORT="80"                           # Nginx använder port 80
PROJECT_NAME="WeLoveMushrooms"       # Projektets namn (om du vill)

# 2. Skapa resursgrupp om den inte finns
echo "Skapar resursgrupp MushroomRG om den inte finns..."
az group create --name $RESOURCE_GROUP --location $LOCATION

# 3. Skapa VM för Nginx Reverse Proxy
echo "Kollar om VM:n finns..."
if ! az vm show --resource-group $RESOURCE_GROUP --name $VM_NAME; then
    echo "Skapar VM $VM_NAME för Nginx Reverse Proxy..."
    az vm create --resource-group $RESOURCE_GROUP --name $VM_NAME --image $IMAGE --admin-username $ADMIN_USER --generate-ssh-keys --size $VM_SIZE
else
    echo "VM $VM_NAME finns redan!"
fi

# 4. Öppna portar för Nginx
echo "Öppnar portar på Reverse Proxy VM..."
az vm open-port --resource-group $RESOURCE_GROUP --name $VM_NAME --port 80 --priority 1010  # Port 80 för Nginx
az vm open-port --resource-group $RESOURCE_GROUP --name $VM_NAME --port 22 --priority 1020  # Port 22 för SSH