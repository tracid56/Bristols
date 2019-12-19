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
    Pos   = { x = -811.150, y = -1340.802, z = 4.150 },--entre shop
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = 1,
  },

  ShopInside = {
    Pos     = { x = -908.445, y = -1356.609, z = 0.249 },--vu vehicule
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = -20.0,
    Type    = -1,
  },

  ShopOutside = {
    Pos     = { x = -894.812, y = -1371.821, z = 0.307 },
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 238.335,
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
    Pos   = { x = -852.356, y = -1345.176, z = 0.296 },
    Size  = { x = 3.0, y = 3.0, z = 1.0 },
    Type  = 1,
  },

}
