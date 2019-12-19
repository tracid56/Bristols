Config = {}
Config.Locale = 'fr'

Config.DoorList = {

	--
	-- Mission Row First Floor
	--

	-- Entrance Doors
	{
		objName = 'prop_ld_bankdoors_02',
		objCoords  = {x = 233.009, y = 215.076, z = 106.287},
		textCoords = {x = 233.009, y = 215.076, z = 106.287},
		authorizedJobs = { 'banker' },
		locked = false,
		distance = 2.5
	},

	{
		objName = 'prop_ld_bankdoors_02',
		objCoords  = {x = 231.817, y = 214.669, z = 106.280},
		textCoords = {x = 231.817, y = 214.669, z = 106.280},
		authorizedJobs = { 'banker' },
		locked = false,
		distance = 2.5
	},

	-- Rooftop
	{
		objName = 'prop_ld_bankdoors_02',
		objCoords  = {x = 464.361, y = -984.678, z = 43.834},
		textCoords = {x = 464.361, y = -984.050, z = 44.834},
		authorizedJobs = { 'banker' },
		locked = true
	},

	-- Hallway to roof
	{
		objName = 'v_ilev_arm_secdoor',
		objCoords  = {x = 461.286, y = -985.320, z = 30.839},
		textCoords = {x = 461.50, y = -986.00, z = 31.50},
		authorizedJobs = { 'banker' },
		locked = true
	},

	--
	-- Addons
	--

	--[[
	-- Entrance Gate (Mission Row mod) https://www.gta5-mods.com/maps/mission-row-pd-ymap-fivem-v1
	{
		objName = 'prop_gate_airport_01',
		objCoords  = {x = 420.133, y = -1017.301, z = 28.086},
		textCoords = {x = 420.133, y = -1021.00, z = 32.00},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 14,
		size = 2
	}
	--]]
}