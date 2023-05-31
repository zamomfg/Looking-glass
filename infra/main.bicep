

var name = 'looking_glass'

param enviroment string
param location string
param location_name string

param web_app_sku string
param repo_url string

// added the resouce name here aswell since the name need to be known before the resouce group is created to use it in the scope for other modules
// TODO remove the name in the module file
var rg_name = 'rg-${name}-${enviroment}-${location_name}'

targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: rg_name
  location: location
}

// module resource_group 'resouce_group.bicep' = {
//   name: 'rg'
//   scope: subscription()
//   params: {
//     app_name: name
//     enviroment: enviroment
//     location: location
//     location_name: location_name
//   }
// }

module static_web_app 'looking_glass_web_app.bicep' = {
  name: 'swa'
  // scope:  resourceGroup(rg_name)
  scope: rg
  params: {
    app_name: name
    enviroment: enviroment
    location: location
    location_name: location_name
    sku: web_app_sku
    repo_url: repo_url
  }
  dependsOn: [
    rg
  ]
}

// output targetResourceGroupName string = rg.name
