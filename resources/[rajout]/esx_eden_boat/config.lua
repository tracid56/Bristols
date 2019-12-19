Config = {}
Config.Blip			= {sprite= 356, color = 67}
Config.Price		= 0

Config.Garages = {	
	Garage_Boat = {	
		Pos = {x = -843.573, y=-1321.182, z=5.000 },
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = 'Garage Bateau',
		HelpPrompt = "Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage",
		Functionmenu = OpenMenuGarage,
		SpawnPoint = {
			Pos = {x = -867.429, y=-1325.710, z=1.000 },
			Heading = 264.63,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = "Appuyez sur ~INPUT_PICKUP~ pour sortir votre véhicule",
			Functionmenu = ListVehiclesMenu,
		},
		DeletePoint = {
			Pos = {x = -857.798, y=-1329.550, z=1.000 },
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = "Appuyez sur ~INPUT_PICKUP~ pour rentrer votre véhicule",
			Functionmenu = StockVehicleMenu,
		}, 	
	}		
}