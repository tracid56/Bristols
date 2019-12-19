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
Config.EnableLicenses             = true
Config.MaxInService               = -1
Config.Locale                     = 'fr'

Config.PoliceStations = {

  LSPD = {

    Blip = {
      Pos     = { x = -648.296, y = -1637.451, z = 25.0361 },
      Sprite  = 269,
      Display = 4,
      Scale   = 0.9,
      Colour  = 17,
    },

    AuthorizedWeapons = {
      { name = 'WEAPON_COMBATPISTOL',       price = 0 },
      { name = 'WEAPON_APPistol',       price = 0 },
      { name = 'WEAPON_PUMPSHOTGUN',     price = 0 },
      { name = 'WEAPON_FLASHLIGHT',     price = 0 },
      { name = 'GADGET_PARACHUTE',       price = 0 },
    },

    Cloakrooms = {
      { x = -594.449, y = -1619.473, z = 32.010 },
    },

    Armories = {
      { x = -613.103, y = -1624.680, z = 32.010 },
    },

    Vehicles = {
      {
        Spawner    = { x = -621.445, y = -1640.557, z = 24.974 },
        SpawnPoint = { x = -622.826, y = -1648.612, z = 24.825 },
        Heading    = 67.235,
      }
    },

    Helicopters = {
      {
        Spawner    = { x = -617.010, y = -1612.445, z = 40.049 },
        SpawnPoint = { x = -611.559, y = -1617.101, z = 44.532 },
        Heading    = 1.440,
      }
    },

    VehicleDeleters = {
      { x = -630.615, y = -1657.050, z = 24.825 },
    },

    BossActions = {
      { x = -616.869, y = -1624.061, z = 32.010 }
    },

  },

}
