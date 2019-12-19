--Truck
Config	=	{}

 -- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg)
Config.Limit = 25000

-- Default weight for an item:
	-- weight == 0 : The item do not affect character inventory weight
	-- weight > 0 : The item cost place on inventory
	-- weight < 0 : The item add place on inventory. Smart people will love it.
Config.DefaultWeight = 250



-- If true, ignore rest of file
Config.WeightSqlBased = false

-- I Prefer to edit weight on the config.lua and I have switched Config.WeightSqlBased to false:

Config.localWeight = {
	black_money = 1, -- poids pour un argent
}

Config.VehicleLimit = {
    [0] = 30000, --Compact
    [1] = 35000, --Sedan
    [2] = 50000, --SUV
    [3] = 30000, --Coupes
    [4] = 30000, --Muscle
    [5] = 5000, --Sports Classics
    [6] = 5000, --Sports
    [7] = 5000, --Super
    [8] = 2000, --Motorcycles
    [9] = 100000, --Off-road
    [10] = 180000, --Industrial
    [11] = 35000, --Utility
    [12] = 75000, --Vans
    [13] = 1250, --Cycles
    [14] = 5000, --Boats
    [15] = 25000, --Helicopters
    [16] = 150000, --Planes
    [17] = 110000, --Service
    [18] = 110000, --Emergency
    [19] = 70000, --Military
    [20] = 180000, --Commercial
    [21] = 0, --Trains
}