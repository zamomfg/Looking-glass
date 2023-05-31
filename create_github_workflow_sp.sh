#!/bin/bash

read -p "Subscription id: " subscription_id

sp_name="GithubAction"

az ad sp create-for-rbac --name $sp_name --role contributor --scopes "/subscriptions/$subscription_id" --sdk-auth | jq '. | {clientId: .clientId, clientSecret: .clientSecret, subscriptionId: .subscriptionId,tenantId: .tenantId}'