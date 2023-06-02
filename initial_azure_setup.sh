#!/bin/bash

if [ -z "$1" ]
then
    az account list | jq -r '.[] | [.name, .id] | @tsv'
    read -p "Subscription id: " subscription_id
else
    subscription_id=$1
fi

sp_name="GithubActionLookingGlass"


# getting name vars from params file. This is probebly a nicer way of doing this...
location=$(cat ./infra/main.parameters.json | jq -r '.parameters.location.value')
rg_enviroment=$(cat ./infra/main.parameters.json | jq -r '.parameters.enviroment.value')
rg_location_name=$(cat ./infra/main.parameters.json | jq -r '.parameters.location_name.value')
rg_app_name=$(cat ./infra/main.parameters.json | jq -r '.parameters.app_name.value')

rg_name=$(echo "rg-$rg_app_name-$rg_enviroment-$rg_location_name" | tr -d '"')

az group create -l $location -n $rg_name

sp_json=$(az ad sp create-for-rbac --name $sp_name --role contributor --scopes "/subscriptions/$subscription_id/resourceGroups/$rg_name" | jq --arg  subscriptionId "$subscription_id" '. | {clientId: .appId, clientSecret: .password, subscriptionId: $subscriptionId, tenantId: .tenant}')

echo "Github secrets:"
echo
echo "AZURE_CREDENTIALS: $sp_json"
echo
echo "AZURE_RG: $rg_name"
echo
echo "AZURE_SUBSCRIPTION: $subscription_id"