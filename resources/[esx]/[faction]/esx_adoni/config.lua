Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = false
Config.EnableESXIdentity          = true -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = false
Config.MaxInService               = -1
Config.Locale                     = 'fr'

Config.CartelStations = {

  Cartel = {

    Blip = {
      Pos     = { x = 425.130, y = -979.558, z = 30.711 },
      Sprite  = 60,
      Display = 4,
      Scale   = 0.9,
      Colour  = 29,
    },

    AuthorizedWeapons = {
      { name = 'WEAPON_APPISTOL',         price = 70000 },
      { name = 'WEAPON_HEAVYSHOTGUN',         price = 70000 },
      { name = 'WEAPON_ADVANCEDRIFLE',         price = 70000 },
      { name = 'WEAPON_COMBATMG',         price = 70000 },
      { name = 'WEAPON_HEAVYSNIPER',         price = 70000 },
    },

	  AuthorizedVehicles = {
		  --{ name = 'schafter5',  label = 'Véhicule Civil' },
      { name = 'xls2',  label = 'XLS' },
		  { name = 'Akuma',    label = 'Moto' },
		  { name = 'btype3',    label = 'Btype Luxe' },
	  },

    Cloakrooms = {
      { x = 1117.065, y = -3162.718, z = -37.870},
    },

    Armories = {
      { x = 1118.475, y = -3143.531, z = -36.062},
    },

    Vehicles = {
      {
        Spawner    = { x = -1172.156, y = -1384.321, z = 3.929 },
        SpawnPoint = { x = -1177.022, y = -1392.899, z = 4.748 },
        Heading    = 200.380,
      }
    },

    Helicopters = {
      {
        Spawner    = { x = 113.30500793457, y = -3109.3337402344, z = 5.0060696601868 },
        SpawnPoint = { x = 112.94457244873, y = -3102.5942382813, z = 5.0050659179688 },
        Heading    = 0.0,
      }
    },

    VehicleDeleters = {
      { x = -1183.676, y = -1393.567, z = 3.611 },
      
    },

    BossActions = {
      { x = 1115.904, y = -3161.050, z = -37.870 },
    },

  },

}

