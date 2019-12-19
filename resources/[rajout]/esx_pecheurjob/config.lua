Config                            = {}
Config.DrawDistance               = 100.0
Config.MaxInService               = -1
Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.Locale                     = 'fr'

Config.Zones = {

	RaisinFarm = {
		Pos   = {x = 1056.573, y = 4023.572, z = 33.216},
		Size  = {x = 110.0, y = 110.0, z = 10.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Récolte de Poisson Cru",
		Type  = 1
	},

	TraitementVin = {
		Pos   = {x = 1309.483, y = 4362.065, z = 40.545},
		Size  = {x = 3.5, y = 3.5, z = 2.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Traitement de Poisson Cru",
		Type  = 1
	},
	
	SellFarm = {
		Pos   = {x = 867.881, y = -1640.399, z = 29.335},
		Size  = {x = 3.5, y = 3.5, z = 2.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Vente de Poisson",
		Type  = 1
	},

	VigneronActions = {
		Pos   = {x = 1336.663, y = 4385.192, z = 43.341},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Point d'action",
		Type  = 0
	 },

	VehicleSpawnPoint = {
		Pos   = {x = 1348.101, y = 4376.363, z = 43.343},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Garage véhicule",
		Type  = -1
	},

	BateauSpawnPoint = {
		Pos   = {x = 1275.669, y = 4210.728, z = 32.014},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Garage bateau",
		Type  = -1
	},

	VehicleSpawner = {
		Pos   = {x = 1335.266, y = 4380.442, z = 43.360},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Spawn point",
		Type  = 0
	},

	VehicleDeleter = {
		Pos   = {x = 1333.014, y = 4372.041, z = 43.196},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 136, g = 243, b = 216},
		Name  = "Ranger son véhicule",
		Type  = 0
	}

}
