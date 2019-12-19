Config                            = {}
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 204, g = 204, b = 0 }
Config.DrawDistance               = 100.0
Config.MaxInService               = -1
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.EnableSocietyOwnedVehicles1 = false
Config.EnableLicenses             = true
Config.EnableESXIdentity          = true
Config.Locale                     = 'fr'

Config.BanditsStations = {

  Bandits = {

    AuthorizedWeapons = {

    {name = 'WEAPON_FIREEXTINGUISHER', price = 500},
    {name = 'WEAPON_STUNGUN',          price = 1000},
    {name = 'WEAPON_BZGAS',            price = 3000},
    {name = 'WEAPON_MOLOTOV',          price = 1500},
    {name = 'WEAPON_SMOKEGRENADE',     price = 1500},            
    {name = 'WEAPON_HEAVYPISTOL',      price = 8000},
    {name = 'WEAPON_COMBATPISTOL',     price = 10000},    
    {name = 'WEAPON_MICROSMG',         price = 12000},
    {name = 'WEAPON_SMG',              price = 16000},
    {name = 'WEAPON_CARBINERIFLE',     price = 18000},  
    {name = 'WEAPON_MG',               price = 25000},
    {name = 'WEAPON_COMPACTRIFLE',     price = 25000}, 
    {name = 'WEAPON_ASSAULTRIFLE',     price = 25000},
    {name = 'WEAPON_COMBATPDW',        price = 25000},
    {name = 'WEAPON_SPECIALCARBINE',   price = 35000},           
    {name = 'WEAPON_SAWNOFFSHOTGUN',   price = 17500},    
    {name = 'WEAPON_PUMPSHOTGUN',      price = 17500},
    {name = 'WEAPON_HEAVYSHOTGUN',     price = 25000},
    {name = 'WEAPON_MARKSMANRIFLE',    price = 30000},
    {name = 'WEAPON_SNIPERRIFLE',      price = 50000},
    {name = 'WEAPON_HEAVYSNIPER',      price = 65000},    
    {name = 'WEAPON_GUSENBERG',        price = 80000},
    {name = 'WEAPON_STICKYBOMB',       price = 10000},
    {name = 'WEAPON_PIPEBOMB',         price = 15000},
    {name = 'WEAPON_COMPACTLAUNCHER',  price = 165000},
    {name = 'WEAPON_HOMINGLAUNCHER',   price = 350000} 
    },

    Armories = {
      {x = 1227.825, y = -3165.593, z = 4.833},
    },

    CryptedActions = {
      {x = 1221.813, y = -3116.936, z = 4.730},
    },

    CryptedActions1 = {
      {x = 1218.540, y = -3183.454, z = 4.833},
    },

    VehicleBanditsSpawnPoint = {
      Pos   = {x = 54.914, y = 3719.412, z = 39.666, a = 22.730},
      Size  = {x = 1.5, y = 1.5, z = 1.0},
      Type  = -1
    },
  
    VehicleBanditsSpawnPoint1 = {
      Pos   = {x = 579.175, y = -2345.337, z = 5.907, a = 76.834},
      Size  = {x = 1.5, y = 1.5, z = 1.0},
      Type  = -1
    },

  },

}

Config.TeleportZonesBandits = {
  EnterBuilding = {
    Pos       = { x = 1234.536, y = -3202.348, z = 4.528 },--devant
    Size      = { x = 1.5, y = 1.5, z = 1.0 },
    Color     = { r = 190, g = 0, b = 0 },
    Marker    = 1,
    Blip      = false,
    Name      = "Bunker : entrée",
    Type      = "teleport",
    Hint      = "Appuyez sur ~INPUT_PICKUP~ pour entrer dans le Bunker.",
    Teleport  = { x = 1235.173, y = -3195.238, z = 5.833 },--devant
  },

  ExitBuilding = {
    Pos       = { x = 1235.173, y = -3195.238, z = 4.833 },--devant
    Size      = { x = 1.5, y = 1.5, z = 1.0 },
    Color     = { r = 190, g = 0, b = 0 },
    Marker    = 1,
    Blip      = false,
    Name      = "Bunker : sortie",
    Type      = "teleport",
    Hint      = "Appuyez sur ~INPUT_PICKUP~ pour sortir du Bunker.",
    Teleport  = { x = 1234.536, y = -3202.348, z = 5.528 },--devant
  },
}

Config.TeleportZonesBandits1 = {
  EnterBuilding = {
    Pos       = { x = 232.895, y = -753.695, z = 29.826 },--garage central
    Size      = { x = 1.5, y = 1.5, z = 1.0 },
    Color     = { r = 190, g = 0, b = 0 },
    Marker    = 1,
    Blip      = false,
    Name      = "Bunker : entrée",
    Type      = "teleport",
    Hint      = "Appuyez sur ~INPUT_PICKUP~ pour entrer dans le Bunker.",
    Teleport  = { x = 1224.910, y = -3189.003, z = 5.833 },--garage central
  },

  ExitBuilding = {
    Pos       = { x = 1224.910, y = -3189.003, z = 4.833 },--garage central
    Size      = { x = 1.5, y = 1.5, z = 1.0 },
    Color     = { r = 190, g = 0, b = 0 },
    Marker    = 1,
    Blip      = false,
    Name      = "Bunker : sortie",
    Type      = "teleport",
    Hint      = "Appuyez sur ~INPUT_PICKUP~ pour sortir du Bunker.",
    Teleport  = { x = 232.895, y = -753.695, z = 30.826 },--garage central
  },
}

Config.TeleportZonesBandits2 = {
  EnterBuilding = {
    Pos       = { x = 56.603, y = 3712.767, z = 38.755 },----Nort
    Size      = { x = 1.5, y = 1.5, z = 1.0 },
    Color     = { r = 190, g = 0, b = 0 },
    Marker    = 1,
    Blip      = false,
    Name      = "Bunker : entrée",
    Type      = "teleport",
    Hint      = "Appuyez sur ~INPUT_PICKUP~ pour entrer dans le Bunker.",
    Teleport  = { x = 1222.121, y = -3131.371, z = 5.205 },----Nort
  },

  ExitBuilding = {
    Pos       = { x = 1222.121, y = -3131.371, z = 4.205 },----Nort
    Size      = { x = 1.5, y = 1.5, z = 1.0 },
    Color     = { r = 190, g = 0, b = 0 },
    Marker    = 1,
    Blip      = false,
    Name      = "Bunker : sortie",
    Type      = "teleport",
    Hint      = "Appuyez sur ~INPUT_PICKUP~ pour sortir du Bunker.",
    Teleport  = { x = 56.603, y = 3712.767, z = 39.755 },--Nort
  },
}

Config.TeleportZonesBandits3 = {
  EnterBuilding = {
    Pos       = { x = 572.722, y = -2350.512, z = 4.858 },----port
    Size      = { x = 1.5, y = 1.5, z = 1.0 },
    Color     = { r = 190, g = 0, b = 0 },
    Marker    = 1,
    Blip      = false,
    Name      = "Bunker : entrée",
    Type      = "teleport",
    Hint      = "Appuyez sur ~INPUT_PICKUP~ pour entrer dans le Bunker.",
    Teleport  = { x = 1220.042, y = -3184.941, z = 5.833 },----port
  },

  ExitBuilding = {
    Pos       = { x = 1220.042, y = -3184.941, z = 4.833 },----port
    Size      = { x = 1.5, y = 1.5, z = 1.0 },
    Color     = { r = 190, g = 0, b = 0 },
    Marker    = 1,
    Blip      = false,
    Name      = "Bunker : sortie",
    Type      = "teleport",
    Hint      = "Appuyez sur ~INPUT_PICKUP~ pour sortir du Bunker.",
    Teleport  = { x = 572.722, y = -2350.512, z = 5.858 },----port
  },
}