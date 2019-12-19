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

Config.PoliceStations = {

  LSPD = {

    Blip = {
      Pos     = { x = 1195.260, y = -1477.720, z = 33.859 },
      Sprite  = 267,
      Display = 4,
      Scale   = 0.9,
      Colour  = 1,
    },
		
		AuthorizedWeapons = {
      { name = 'WEAPON_HEAVYPISTOL',       price = 0 },
      { name = 'WEAPON_NIGHTSTICK',         price = 0 },
      { name = 'WEAPON_STUNGUN',            price = 0 },
      { name = 'WEAPON_APPistol',           price = 0 },
      { name = 'WEAPON_HEAVYSHOTGUN',        price = 0 },
      { name = 'WEAPON_FLASHLIGHT',         price = 0 },
      { name = 'WEAPON_BZGas',                 price = 0 },
      { name = 'WEAPON_CarbineRifle',      price = 0 },
      { name = 'WEAPON_FLARE',            price = 0 },
      { name = 'WEAPON_ASSAULTSMG',       price = 0 },
      { name = 'WEAPON_CombatPDW',         price = 0 },
      { name = 'WEAPON_HEAVYSNIPER',       price = 0 },
			{ name = 'GADGET_PARACHUTE',        price = 0 },
    },

    AuthorizedVehicles = {
      { name = 'police',  label = 'Véhicule de patrouille 1' },
      { name = 'police2', label = 'Véhicule de patrouille 2' },
      { name = 'police3', label = 'Véhicule de patrouille 3' },
      { name = 'police4', label = 'Véhicule civil' },
      { name = 'policeb', label = 'Moto' },
      { name = 'policet', label = 'Van de transport' },
			{ name = 'ghispo2',   label = 'Véhicule Rapide Intervention' }
    },

    Cloakrooms = {
      { x = 1195.260, y = -1477.720, z = 33.859 },
    },

    Vehicles = {
      {
        Spawner    = { x = 1203.661, y = -1490.752, z = 33.692 },
        SpawnPoint = { x = 1201.000, y = -1504.581, z = 33.692 },
        Heading    = 91.480,
      }
    },

    VehicleDeleters = {
      { x = 1197.332, y = -1490.622, z = 33.692 },
    },

    BossActions = {
      { x = 1191.865, y = -1474.731, z = 33.859 }
    },

  },

}

Config.Uniforms = {
    
  cadet_wear = {
    male = {
			['tshirt_1'] = 59,  ['tshirt_2'] = 1,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = 45,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
},
  officer_wear = {
    male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
  sergeant_wear = {
    male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
  lieutenant_wear = {
    male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
  lieutenant_wear = {
    male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	detective_wear = {
    male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 26,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 11,
			['pants_1'] = 10,   ['pants_2'] = 0,
			['shoes_1'] = 5,   ['shoes_2'] = 0,
			['helmet_1'] = 0,  ['helmet_2'] = 0,
			['chain_1'] = 125,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
  capitaine_wear = {
    male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
  bullet_wear = {
		male = {
			['bproof_1'] = 11,  ['bproof_2'] = 1
		},
		female = {
			['bproof_1'] = 13,  ['bproof_2'] = 1
		}
	},
	gilet_wear = {
		male = {
			['tshirt_1'] = 59,  ['tshirt_2'] = 1
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1
		}
	}

}

Config.JobLocations = {
  {x = 293.476, y = -590.163, z = 42.7371},
  {x = 253.404, y = -375.86, z = 44.0819},
  {x = 120.808, y = -300.416, z = 45.1399},
  {x = -38.4132, y = -381.576, z = 38.3456},
  {x = -107.442, y = -614.377, z = 35.6703},
  {x = -252.292, y = -856.474, z = 30.5626},
  {x = -236.138, y = -988.382, z = 28.7749},
  {x = -276.989, y = -1061.18, z = 25.6853},
  {x = -576.451, y = -998.989, z = 21.785},
  {x = -602.798, y = -952.63, z = 21.6353},
  {x = -790.653, y = -961.855, z = 14.8932},
  {x = -912.588, y = -864.756, z = 15.0057},
  {x = -1069.77, y = -792.513, z = 18.8075},
  {x = -1306.94, y = -854.085, z = 15.0959},
  {x = -1468.51, y = -681.363, z = 26.178},
  {x = -1380.89, y = -452.7, z = 34.0843},
  {x = -1326.35, y = -394.81, z = 36.0632},
  {x = -1383.68, y = -269.985, z = 42.4878},
  {x = -1679.61, y = -457.339, z = 39.4048},
  {x = -1812.45, y = -416.917, z = 43.6734},
  {x = -2043.64, y = -268.291, z = 22.9927},
  {x = -2186.45, y = -421.595, z = 12.6776},
  {x = -1862.08, y = -586.528, z = 11.1747},
  {x = -1859.5, y = -617.563, z = 10.8788},
  {x = -1634.95, y = -988.302, z = 12.6241},
  {x = -1283.99, y = -1154.16, z = 5.30998},
  {x = -1126.47, y = -1338.08, z = 4.63434},
  {x = -867.907, y = -1159.67, z = 5.00795},
  {x = -847.55, y = -1141.38, z = 6.27591},
  {x = -722.625, y = -1144.6, z = 10.2176},
  {x = -575.503, y = -318.446, z = 34.5273},
  {x = -592.309, y = -224.853, z = 36.1209},
  {x = -559.594, y = -162.873, z = 37.7547},
  {x = -534.992, y = -65.6695, z = 40.634},
  {x = -758.234, y = -36.6906, z = 37.2911},
  {x = -1375.88, y = 20.9516, z = 53.2255},
  {x = -1320.25, y = -128.018, z = 48.097},
  {x = -1285.71, y = 294.287, z = 64.4619},
  {x = -1245.67, y = 386.533, z = 75.0908},
  {x = -760.355, y = 285.015, z = 85.0667},
  {x = -626.786, y = 254.146, z = 81.0964},
  {x = -563.609, y = 267.962, z = 82.5116},
  {x = -486.806, y = 271.977, z = 82.8187},
  {x = 88.295, y = 250.867, z = 108.188},
  {x = 234.087, y = 344.678, z = 105.018},
  {x = 434.963, y = 96.707, z = 99.1713},
  {x = 482.617, y = -142.533, z = 58.1936},
  {x = 762.651, y = -786.55, z = 25.8915},
  {x = 809.06, y = -1290.8, z = 25.7946},
  {x = 490.819, y = -1751.37, z = 28.0987},
  {x = 432.351, y = -1856.11, z = 27.0352},
  {x = 164.348, y = -1734.54, z = 28.8982},
  {x = -57.6909, y = -1501.4, z = 31.1084},
  {x = 52.2241, y = -1566.65, z = 29.006},
  {x = 295.44149780273,y = -1439.6423339844,z = 28.803928375244 },
  {x = 1165.1629638672,y = -1536.8948974609,z = 38.400791168213 },
  {x = 1827.8881835938,y = 3693.8835449219,z = 33.224269866943 },  
}