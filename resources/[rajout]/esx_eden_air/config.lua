Config = {}
Config.Blip			= {sprite= 360, color = 75}
Config.Price		= 0

Config.Garages = {	
	Garage_Air= {	
		Pos = {x = -1148.178, y=-2825.939, z=13.964 },
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = 'Garage',
		HelpPrompt = "Appuyez sur ~INPUT_PICKUP~ pour ouvrir le garage",
		Functionmenu = OpenMenuGarage,
		SpawnPoint = {
			Pos = {x = -1112.594, y = -2883.696, z =13.946 },
			Heading = 264.63,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = "Appuyez sur ~INPUT_PICKUP~ pour sortir votre véhicule",
			Functionmenu = ListVehiclesMenu,
		},
		DeletePoint = {
			Pos = {x = -1087.352, y=-2897.292, z=13.947 },
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = "Appuyez sur ~INPUT_PICKUP~ pour rentrer votre véhicule",
			Functionmenu = StockVehicleMenu,
		}, 	
	}		
}
