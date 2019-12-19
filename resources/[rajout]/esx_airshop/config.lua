Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 120, g = 120, b = 240 }
Config.EnablePlayerManagement     = false -- If set to true, you need esx_addonaccount, esx_billing and esx_society
Config.EnablePvCommand            = false
Config.EnableOwnedVehicles        = true
Config.EnableSocietyOwnedVehicles = false
Config.ResellPercentage           = 50
Config.Locale                     = 'fr'

Config.Zones = {

  ShopEntering = {
    Pos   = { x = -1128.688, y = -2836.523, z = 12.946 },--entre shop
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = 1,
  },

  ShopInside = {
    Pos     = { x = -1146.053, y = -2864.586, z = 12.946 },--vu vehicule
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = -337.354,
    Type    = -1,
  },

  ShopOutside = {
    Pos     = { x = -1122.171, y = -2903.790, z = 12.945 },
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 243.386,
    Type    = -1,
  },

  BossActions = {
    Pos   = { x = -32.065, y = -1114.277, z = 25.422 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = -1,
  },

  GiveBackVehicle = {
    Pos   = { x = 31.854, y = -1105.431, z = 25.422 },
    Size  = { x = 3.0, y = 3.0, z = 1.0 },
    Type  = (Config.EnablePlayerManagement and 1 or -1),
  },

  ResellVehicle = {
    Pos   = { x = -1158.737, y = -2887.667, z =12.946 },--{ x = -1112.594, y = -2883.696, z =12.946 },
    Size  = { x = 3.0, y = 3.0, z = 1.0 },
    Type  = 1,
  },

}
