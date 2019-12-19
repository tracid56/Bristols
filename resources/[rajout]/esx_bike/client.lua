
ESX = nil
local PlayerData = {}
local menuOpen = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()

	for i=1, #Config.LocationsBlips, 1 do

		local blip = AddBlipForCoord(Config.LocationsBlips[i].x, Config.LocationsBlips[i].y, Config.LocationsBlips[i].z)

		SetBlipSprite (blip, 226)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.9)
		SetBlipColour (blip, 46)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Location Vélo')
		EndTextCommandSetBlipName(blip)
	end

end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)

		for k,v in pairs(Config.Locations) do
			local coords = GetEntityCoords(PlayerPedId())

			if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance then
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end
			if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.5 then
				showInfo("Appuyez sur ~INPUT_CONTEXT~ pour louer un véhicule")
				if(IsControlJustPressed(1, 38)) then
					showMenu(v)
					menuOpen = true
				end
			end
		end
	end
end)

function showMenu(v)

	local elements = {
		{label = 'Endurex 10$', value = 'tribike2', price = 10},
		{label = 'Cruiser 10$', value = 'cruiser', price = 10},
		{label = 'Bmx 10$', value = 'bmx', price = 10}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'vehicle_menu',
		{
			css = 'location',
			title = 'Location de vélo',
			align    = 'top-left',
			elements = elements
		},
		function(data, menu)
			local vehicleProps = data.current.value
			local price = data.current.price
			local playerPed = GetPlayerPed(-1)
			local platenum = math.random(100, 900)
			local vehicle = GetVehiclePedIsIn(playerPed)

			if data.current.value == 'tribike2' then 
				ESX.TriggerServerCallback('esx_bike:buy1', function(hasEnoughMoney)
					if hasEnoughMoney then
						ESX.Game.SpawnVehicle(data.current.value, Config.Locations.Locations1.Pos, Config.Locations.Locations1.Heading, function(vehicle)
							SetVehicleNumberPlateText(vehicle, "LOCA" .. platenum)
							TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
							local plate = GetVehicleNumberPlateText(vehicle)
							plate = string.gsub(plate, " ", "")
							TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
						end)
					else
						ESX.ShowNotification('Vous n\'avez pas assez d\'argent sur vous ni sur votre carte bancaire')
					end
				end)
			end

			if data.current.value == 'cruiser' then 
				ESX.TriggerServerCallback('esx_bike:buy2', function(hasEnoughMoney)
					if hasEnoughMoney then
						ESX.Game.SpawnVehicle(data.current.value, Config.Locations.Locations1.Pos, Config.Locations.Locations1.Heading, function(vehicle)
							SetVehicleNumberPlateText(vehicle, "LOCA" .. platenum)
							TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
							local plate = GetVehicleNumberPlateText(vehicle)
							plate = string.gsub(plate, " ", "")
							TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
						end)
					else
						ESX.ShowNotification('Vous n\'avez pas assez d\'argent sur vous ni sur votre carte bancaire')
					end
				end)
			end

			if data.current.value == 'bmx' then 
				ESX.TriggerServerCallback('esx_bike:buy3', function(hasEnoughMoney)
					if hasEnoughMoney then
						ESX.Game.SpawnVehicle(data.current.value, Config.Locations.Locations1.Pos, Config.Locations.Locations1.Heading, function(vehicle)
							SetVehicleNumberPlateText(vehicle, "LOCA" .. platenum)
							TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
							local plate = GetVehicleNumberPlateText(vehicle)
							plate = string.gsub(plate, " ", "")
							TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
						end)
					else
						ESX.ShowNotification('Vous n\'avez pas assez d\'argent sur vous ni sur votre carte bancaire')
					end
				end)
			end
			menu.close()
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function showInfo(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, false, 1, 0)
end
