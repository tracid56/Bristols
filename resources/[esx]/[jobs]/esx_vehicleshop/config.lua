Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 120, g = 120, b = 240 }
Config.EnablePlayerManagement     = true -- If set to true, you need esx_addonaccount, esx_billing and esx_society
Config.EnablePvCommand            = false
Config.MaxInService           = -1
Config.EnableOwnedVehicles        = true
Config.EnableSocietyOwnedVehicles = true
Config.ResellPercentage           = 70
Config.Locale                     = 'fr'

Config.Zones = {

  ShopEntering = {
    Pos   = { x = -32.1483, y = -1114.4133, z = 26.4537, angle = 82.5456 },------le bureaux pour les civil
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = 1,
  },

  ShopInside = {
    Pos     = { x = -44.322, y = -1097.644, z = 26.422, angle = 70.737 },------pour acheté le véhicule pour le megasin et le jeureu
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 73.60,
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
    Pos   = { x = -29.528, y = -1108.426, z = 26.422 },------le buraux pour sont service
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = -1,
  },

  VehicleSpawnPoint = {
    Pos   = { x = -49.172927856445, y = -1078.2733154297, z = 26.335163116455 },--------donne votre voiture
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = (Config.EnablePlayerManagement and 1 or -1),
  },
  

  GiveBackVehicle = {
    Pos   = { x = -7.441, y = -1082.621, z = 26.672 },--------donne votre voiture
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = (Config.EnablePlayerManagement and 1 or -1),
  },

  ResellVehicle = {
    Pos   = { x = 0, y = 0, z = 0 },----Revendre le véhicule
    Size  = { x = 5.0, y = 5.0, z = 3.0 },
    Type  = 1,
  },

}


----14.405086517334, y = -1101.6304931641, z = 26.672071456909 angle = 156.58789