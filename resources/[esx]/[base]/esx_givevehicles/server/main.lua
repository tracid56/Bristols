ESX               = nil
local cars 		  = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_givevehicules:requestPlayerCars', function(source, cb, plate)

	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll(
		'SELECT * FROM owned_vehicles WHERE owner = @identifier', 
		{
			['@identifier'] = xPlayer.identifier
		},
		function(result)

			local found = false

			for i=1, #result, 1 do

				local vehicleProps = json.decode(result[i].vehicle)

				if vehicleProps.plate == plate then
					found = true
					break
				end

			end

			if found then
				cb(true)
			else
				cb(false)
			end

		end
	)
end)

RegisterServerEvent('esx_givevehicules:setVehicleOwnedPlayerId')
AddEventHandler('esx_givevehicules:setVehicleOwnedPlayerId', function (playerId, vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	MySQL.Async.execute('UPDATE owned_vehicles SET owner=@owner WHERE plate=@plate',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate
	},
	
	function (rowsChanged)
		TriggerClientEvent('esx:showNotification', playerId, 'Vous avez reçu les papier d\'une nouvelle voiture immatriculer ~g~' ..vehicleProps.plate..'~w~ !', vehicleProps.plate)

	end) 
end)

ESX.RegisterServerCallback('esx_givevehicules:requestPlayerCarsboat', function(source, cb, plate)

	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll(
		'SELECT * FROM owned_vehicles_boat WHERE owner = @identifier', 
		{
			['@identifier'] = xPlayer.identifier
		},
		function(result)

			local found = false

			for i=1, #result, 1 do

				local vehicleProps = json.decode(result[i].vehicle)

				if vehicleProps.plate == plate then
					found = true
					break
				end

			end

			if found then
				cb(true)
			else
				cb(false)
			end

		end
	)
end)

RegisterServerEvent('esx_givevehicules:setVehicleOwnedPlayerIdboat')
AddEventHandler('esx_givevehicules:setVehicleOwnedPlayerIboat', function (playerId, vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	MySQL.Async.execute('UPDATE owned_vehicles_boat SET owner=@owner WHERE plate=@plate',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate
	},
	
	function (rowsChanged)
		TriggerClientEvent('esx:showNotification', playerId, 'Vous avez reçu les papier d\'un nouveau bateau immatriculer ~g~' ..vehicleProps.plate..'~w~ !', vehicleProps.plate)

	end) 
end)

ESX.RegisterServerCallback('esx_givevehicules:requestPlayerCarsair', function(source, cb, plate)

	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll(
		'SELECT * FROM owned_vehicles_boat WHERE owner = @identifier', 
		{
			['@identifier'] = xPlayer.identifier
		},
		function(result)

			local found = false

			for i=1, #result, 1 do

				local vehicleProps = json.decode(result[i].vehicle)

				if vehicleProps.plate == plate then
					found = true
					break
				end

			end

			if found then
				cb(true)
			else
				cb(false)
			end

		end
	)
end)

RegisterServerEvent('esx_givevehicules:setVehicleOwnedPlayerIdair')
AddEventHandler('esx_givevehicules:setVehicleOwnedPlayerIdair', function (playerId, vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	MySQL.Async.execute('UPDATE owned_vehicles_boat SET owner=@owner WHERE plate=@plate',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate
	},
	
	function (rowsChanged)
		TriggerClientEvent('esx:showNotification', playerId, 'Vous avez reçu les papier d\'un nouveau avion/hélico immatriculer ~g~' ..vehicleProps.plate..'~w~ !', vehicleProps.plate)

	end) 
end)



















------------------------------------------------------------------------

RegisterServerEvent('esx_givevehicules:setVehicleOwnedPlayerIdClee')
AddEventHandler('esx_givevehicules:setVehicleOwnedPlayerIdClee', function (playerId, vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	MySQL.Async.execute('UPDATE open_car SET identifier=@identifier WHERE value=@value',
	{
		['@identifier']   = xPlayer.identifier,
		['@value']   = vehicleProps.plate
	},
	
	function (rowsChanged)
		TriggerClientEvent('esx:showNotification', playerId, 'Vous avez reçu les clée de votre nouvelle voiture immatriculer ~g~' ..vehicleProps.plate..'~w~ !', vehicleProps.plate)

	end) 
end)