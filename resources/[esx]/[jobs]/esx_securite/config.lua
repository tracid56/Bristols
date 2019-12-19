Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }
Config.NPCJobEarnings             = {min = 450, max = 750}
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = false
Config.EnableESXIdentity          = true -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = true -- only turn this on if you are using esx_license
Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society
Config.MaxInService               = -1
Config.Locale                     = 'fr'

Config.securiteStations = {

  LSPD = {

    Blip = {
      Pos     = { x = 34.655, y = -2675.768, z = 12.045 },
      Sprite  = 316,
      Display = 4,
      Scale   = 0.9,
      Colour  = 0,
    },
		
		AuthorizedWeapons = {
      { name = 'WEAPON_HEAVYPISTOL',       price = 0 },
      { name = 'WEAPON_STUNGUN',            price = 0 },
      { name = 'WEAPON_HEAVYSHOTGUN',        price = 0 },
      { name = 'WEAPON_FLASHLIGHT',         price = 0 },
      { name = 'WEAPON_FLARE',            price = 0 },
    },

    AuthorizedVehicles = {
      { name = 'securite',  label = 'Véhicule de patrouille 1' },
      { name = 'securite2', label = 'Véhicule de patrouille 2' },
      { name = 'securite3', label = 'Véhicule de patrouille 3' }
    },

    Armories = {
      { x = 30.254, y = -2692.583, z = 12.009 },
    },

    Vehicles = {
      {
        Spawner    = { x = 8.003, y = -2653.123, z = 6.005 },
        SpawnPoint = { x = -6.360, y = -2652.970, z = 6.005 },
        Heading    = 90.0,
      }
    },

    Helicopters = {
      {
        Spawner    = { x = 0, y = 0, z = 0 },
        SpawnPoint = { x = 0, y = 0, z = 0 },
        Heading    = 0.0,
      }
    },

    VehicleDeleters = {
      { x = 14.019, y = -2635.031, z = 6.041 },
    },

    BossActions = {
      { x = 36.874, y = -2668.399, z = 12.045 }
    },

  },

}