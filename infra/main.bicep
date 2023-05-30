

var name = 'looking_glass'

param enviroment string
param location string
param location_name string

param web_app_sku string

var rg_name = 'rg-${name}-${enviroment}-${location_name}'

targetScope = 'subscription'

module resource_group 'resouce_group.bicep' = {
  name: 'rg'
  scope: subscription()
  params: {
    app_name: name
    enviroment: enviroment
    location: location
    location_name: location_name
  }
}

module static_web_app 'looking_glass_web_app.bicep' = {
  name: 'swa'
  scope:  resourceGroup(rg_name)
  params: {
    app_name: name
    enviroment: enviroment
    location: location
    location_name: location_name
    sku: web_app_sku
  }
  dependsOn: [
    resource_group
  ]
}
