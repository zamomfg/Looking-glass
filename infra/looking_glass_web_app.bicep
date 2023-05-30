
// param skip_app_build bool

@allowed([ 'Free', 'Standard' ])
param sku string = 'Standard'

param app_name string
param enviroment string
param location string
param location_name string

var swa_name = 'swa-${app_name}-${enviroment}-${location_name}'

resource swa_resource 'Microsoft.Web/staticSites@2021-01-15' = {
  name: swa_name
  location: location
  tags: null
  properties: {
      branch: 'main'
      // repositoryToken: tokenParam
      repositoryUrl: 'https://github.com/zamomfg/Looking-glass'
      buildProperties: {
          appLocation: '../app'
          apiLocation: '../api'
          outputLocation: '../output'
      }
  }
  sku: {
      name: sku
      size: sku
  }
}
