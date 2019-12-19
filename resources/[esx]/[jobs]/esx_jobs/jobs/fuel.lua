Config.Jobs.fuel = {
	BlipInfos = {
		Sprite = 436,
		Color = 5
	},
	Vehicles = {
		Truck = {
			Spawner = 1,
			Hash = "phantom",
			Trailer = "tanker",
			HasCaution = true
		}
	},
	Zones = {
		CloakRoom = { -- 1
			Pos   = {x = 557.933, y = -2327.9, z = 4.82896},
			Size  = {x = 3.0, y = 3.0, z = 2.0},
			Color = {r = 204, g = 204, b = 0},
			Marker= 11,
			Blip  = true,
			Name  = _U('f_oil_refiner'),
			Type  = "cloakroom",
			Hint  = _U('cloak_change'),
			GPS = {x = 554.597, y = -2314.43, z = 4.86293}
		},
		
		Offshore = { -- 3
			Pos   = {x = 1240.741088, y = -3002.878173, z = 9.129263},
			Size  = {x = 3.0, y = 3.0, z = 2.0},
			Color = {r = 204, g = 204, b = 0},
			Marker= 3,
			Blip  = true,
			Name  = _U('offshore_prod'),
			Type  = "offshore",
			Hint  = _U('offshore_prod'),
			GPS = {x = 1240.741088, y = -3002.878173, z = 9.129263}
		},
		ChampPetrol = { -- 4 -- 8
			Pos   = {x = 13627.48144, y = 9957.01171875, z = 31.09},
			Size  = {x = 5.0, y = 5.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Marker= 14,
			Blip  = true,
			Name  = _U('f_drill_oil'),
			Type  = "work",
			Item  = {
				{
					name   = _U('f_fuel'),
					db_name= "petrol",
					time   = 5000,
					max    = 20,
					add    = 1,
					remove = 1,
					requires = "nothing",
					requires_name = "Nothing",
					drop   = 100
				}
			},
			Hint  = _U('f_drillbutton'),
			GPS = {x = 13627.48144, y = 9957.01171875, z = 31.09}
		},

		Raffinerie = { -- 5
			Pos   = {x = 13711.26855, y = 9831.625, z = 30.074307},
			Size  = {x = 5.0, y = 5.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Marker= 15,
			Blip  = true,
			Name  = _U('f_fuel_refine'),
			Type  = "work",
			Item  = {
				{
					name   = _U('f_fuel_refine'),
					db_name= "petrol_raffin",
					time   = 5000,
					max    = 10,
					add    = 1,
					remove = 2,
					requires = "petrol",
					requires_name = _U('f_fuel'),
					drop   = 100
				}
			},
			Hint  = _U('f_refine_fuel_button'),
			GPS = {x = 13711.26855, y = 9831.625, z = 30.074307}
		},

		Melange = { -- 6
			Pos   = {x = 13714.13085, y = 9812.36914, z = 33.98346},
			Size  = {x = 5.0, y = 1.0, z = 0.5},
			Color = {r = 204, g = 204, b = 0},
			Marker= 16,
			Blip  = true,
			Name  = _U('f_fuel_mixture'),
			Type  = "work",
			Item  = {
				{
					name   = _U('f_gas'),
					db_name= "essence",
					time   = 5000,
					max    = 20,
					add    = 2,
					remove = 1,
					requires = "petrol_raffin",
					requires_name = _U('f_fuel_refine'),
					drop   = 100
				}
			},
			Hint  = _U('f_fuel_mixture_button'),
			GPS = {x = 13714.13085, y = 9812.36914, z = 33.98346}
		},

		VehicleSpawner = { -- 2
			Pos   = {x = 554.597, y = -2314.43, z = 4.86293},
			Size  = {x = 3.0, y = 3.0, z = 2.0},
			Color = {r = 204, g = 204, b = 0},
			Marker= 12,
			Blip  = false,
			Name  = _U('spawn_veh'),
			Type  = "vehspawner",
			Spawner = 1,
			Hint  = _U('spawn_truck_button'),
			Caution = 0,
			GPS = {x = 602.254, y = 2926.62, z = 39.6898}
		},

		VehicleSpawnPoint = {
			Pos   = {x = 572.175, y = -2305.63, z = 5.9161},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Marker= -1,
			Blip  = false,
			Name  = _U('service_vh'),
			Type  = "vehspawnpt",
			Spawner = 1,
			GPS = 0,
			Heading = 0
		},

		VehicleDeletePoint = {
			Pos   = {x = 520.684, y = -2124.21, z = 4.98635},
			Size  = {x = 5.0, y = 5.0, z = 1.0},
			Color = {r = 255, g = 0, b = 0},
			Marker= 1,
			Blip  = false,
			Name  = _U('return_vh'),
			Type  = "vehdelete",
			Hint  = _U('return_vh_button'),
			Spawner = 1,
			Caution = 0,
			GPS = 0,
			Teleport = 0
		},

		Delivery = { -- 7
			Pos   = {x = 2791.67260, y = 1523.6568, z = 24.505933},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 10.0, y = 10.0, z = 1.0},
			Marker= 29,
			Blip  = true,
			Name  = _U('delivery'),
			Type  = "delivery",
			Spawner = 1,
			Item  = {
				{
					name   = _U('delivery'),
					time   = 500,
					remove = 1,
					max    = 20, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
					price  = 10,
					requires = "essence",
					requires_name = _U('f_gas'),
					drop   = 100
				}
			},
			Hint  = _U('f_deliver_gas'),
			GPS = {x = 2791.67260, y = 1523.6568, z = 24.305933}
		}
	}
}
