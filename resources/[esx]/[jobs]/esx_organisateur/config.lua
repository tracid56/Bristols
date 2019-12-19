Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 120, g = 120, b = 240 }
Config.EnablePlayerManagement     = true -- If set to true, you need esx_addonaccount, esx_billing and esx_society
Config.EnablePvCommand            = false
Config.EnableOwnedVehicles        = true
Config.EnableSocietyOwnedVehicles = true
Config.ResellPercentage           = 70
Config.Locale                     = 'fr'

Config.Zones = {

  ShopEntering = {
    Pos   = { x = 1721.124, y = 3320.391, z = 40.224 },------le bureaux pour les civil
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = 1,
  },

  ShopInside = {
    Pos     = { x = 1749.327, y = 3266.247, z = 40.264 },------pour acheté le véhicule pour le megasin et le jeureu
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 104.71,
    Type    = -1,
  },

  ShopOutside = {
    Pos     = { x = -48.093, y = -1078.855, z = 25.771 },
    Pos     = { x = -47.093, y = -1077.855, z = 25.771 },
    Pos     = { x = -46.093, y = -1076.855, z = 25.771 },
    Pos     = { x = -48.668, y = -1079.944, z = 25.771 },
    Size    = { x = 2.5, y = 2.5, z = 2.0 },
    Heading = 73.60,
    Type    = -1,
  },

  BossActions = {
    Pos   = { x = 1717.209, y = 3322.592, z = 40.223 },------le buraux pour sont service
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = -1,
  },

  GiveBackVehicle = {
    Pos   = { x = 1735.388, y = 3316.853, z = 40.223 },--------donne votre voiture
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = (Config.EnablePlayerManagement and 1 or -1),
  },

}
