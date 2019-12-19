Config = {}
Config.Locale = 'fr'
Config.NumberOfCopsRequired = 5
Config.NumberOfffCopsRequired = 5

Banks = {
	["Blaine County Savings"] = {
		position = { ['x'] = -107.06505584717, ['y'] = 6474.8012695313, ['z'] = 31.62670135498 },
		reward = math.random(12500,20000),
		nameofbank = "a la banque 4/7",
		secondsRemaining = 600, -- seconds
		lastrobbed = 0
	},
	["Principal bank"] = {
		position = { ['x'] = 265.40866088867, ['y'] = 213.69737243652, ['z'] = 101.05 },
		reward = math.random(500000,1000000),
		nameofbank = "a la Banque Principal",
		secondsRemaining = 900, -- seconds
		lastrobbed = 0
	}
}