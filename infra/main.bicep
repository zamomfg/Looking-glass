

param app_name string

param enviroment string
param location string
param location_name string

param web_app_sku string
param repo_url string

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

output staticWebAppName string = static_web_app.outputs.staticWebAppName
