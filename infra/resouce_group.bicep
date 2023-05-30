

param app_name string
param enviroment string
param location string
param location_name string

var rg_name = 'rg-${app_name}-${enviroment}-${location_name}'

targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: rg_name
  location: location
}

output resourceGroupOutput string = rg.name
