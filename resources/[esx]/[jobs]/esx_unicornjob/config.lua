Config                            = {}
Config.DrawDistance               = 100.0
Config.MaxInService               = -1
Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = true
Config.EnableESXIdentity          = false
Config.Locale                     = 'fr'

Config.Alcool = {
  'champagne',
  'rhum',
  'vodka',
  'whisky',
  'mojito'
}

Config.AlcoolResellChances = {
  champagne = 10,
  rhum      = 15,
  vodka     = 20,
  whisky    = 25,
  mojito    = 30,
}

Config.AlcoolResellQuantity = {
  champagne = {min = 1, max = 3},
  rhum      = {min = 2, max = 5},
  vodka     = {min = 3, max = 6},
  whisky    = {min = 3, max = 6},
  mojito    = {min = 4, max = 10},
}

Config.AlcoolPrices = {
  champagne = {min = 100, max = 150},
  rhum      = {min = 50, max = 80},
  vodka     = {min = 20, max = 40},
  whisky    = {min = 30, max = 60},
  mojito    = {min = 10, max = 30},
}

Config.AlcoolPricesHigh = {
  champagne = {min = 100, max = 150},
  rhum      = {min = 50, max = 80},
  vodka     = {min = 20, max = 40},
  whisky    = {min = 30, max = 60},
  mojito    = {min = 10, max = 30},
}

Config.Time = {
  champagne = 8 * 60,
  rhum = 8 * 60,
  vodka = 8 * 60,
  whisky = 8 * 60,
  mojito = 8 * 60,
}

Config.Zones = {

  DiscoActions = {
    Pos   = { x = 94.563, y = -1294.466, z = 28.868 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 1,
  },

  VehicleActions = {
    Pos   = { x = 135.851, y = -1279.193, z = 28.368 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 1,
  },

  TenuesActions = {
    Pos   = { x = 105.742, y = -1303.352, z = 27.868 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 1,
  },

  StockActions = {
    Pos   = { x = 129.490, y = -1281.235, z = 29.269 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 1,
  },


  Farm1 = {
    Pos   = { x = 1880.1740722656, y = 4995.3505859375, z = 51.620754241943 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 1,
  },
  
  Farm2 = {
    Pos   = { x = -1821.90734863, y = 2220.68627929, z = 86.60118316 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 1,
  },  

  Craft = {
    Pos   = { x = 132.0381, y = -1286.8227, z = 28.9709 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 1,
  },

  VehicleSpawnPoint = {
    Pos   = { x = 135.464, y = -1257.221, z = 29.487 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = -1,
  },

  VehicleDeleter = {
    Pos   = { x = 165.093, y = -1283.64, z = 28.0000 },
    Size  = { x = 3.0, y = 3.0, z = 1.0 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 1,
  },
}