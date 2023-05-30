

var name = 'looking_glass'

param enviroment string
param location string
param location_name string

param web_app_sku string
param skip_app_build bool


module resource_group 'looking_glass_web_app.bicep' = {
  name: 'rg'
  params: {
    app_name: name,
    enviroment: enviroment,
    location: location,
    location_name: location_name
    scope: subscription()
  }
}

module static_web_app 'looking_glass_web_app.bicep' = {
  name: 'swa'
  params: {
    app_name: name,
    enviroment: enviroment,
    location: location,
    location_name: location_name,
    sku: web_app_sku,
    skip_app_build: skip_app_build,
    scope:  resourceGroup(resource_group.outputs.resourceGroupOutput)
  }
  dependsOn: [
    resource_group
  ]
}
