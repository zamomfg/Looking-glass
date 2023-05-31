

param app_name string

param enviroment string
param location string
param location_name string

param web_app_sku string
param repo_url string

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
  scope: resourceGroup()
  params: {
    app_name: app_name
    enviroment: enviroment
    location: location
    location_name: location_name
    sku: web_app_sku
    repo_url: repo_url
  }
}

// output targetResourceGroupName string = rg.name
