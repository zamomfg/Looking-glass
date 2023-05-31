#!/bin/bash


if [ "$EUID" -ne 0 ]
  then 
  echo "Root permissions required, please run with sudo"
  echo "exiting"
  exit
fi

# installing Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

chmod +x "./initial_azure_setup.sh"

# use device code login since sometime the regular login dont work in codespaces
az login --use-device-code