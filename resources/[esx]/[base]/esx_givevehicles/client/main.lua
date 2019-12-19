ESX               = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("esx_givevehicules:car")
AddEventHandler("esx_givevehicules:car", function()

CarCoche()

end)

function CarCoche()
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)

	if IsPedInAnyVehicle(playerPed,  false) then
		vehicle = GetVehiclePedIsIn(playerPed, false)
	else
		vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 7.0, 0, 70)
	end
	
	local plate = GetVehicleNumberPlateText(vehicle)
	local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
	

	ESX.TriggerServerCallback('esx_givevehicules:requestPlayerCars', function(isOwnedVehicle)

		if isOwnedVehicle then
		
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

          if closestPlayer == -1 or closestDistance > 3.0 then
		  	ESX.ShowNotification('Aucun joueur à proximité !')
          else
			ESX.ShowNotification('Vous avez donnez les papier de votre voiture immatriculer ~g~'..vehicleProps.plate..' ~w~!')
			TriggerServerEvent('esx_givevehicules:setVehicleOwnedPlayerId', GetPlayerServerId(closestPlayer), vehicleProps)
			TriggerServerEvent('esx_givevehicules:setVehicleOwnedPlayerIdClee', GetPlayerServerId(closestPlayer), vehicleProps)
          end
		else
	       ESX.ShowNotification('Aucun véhicule à proximité ou le vehicule vous appartient pas')
		end
	end, GetVehicleNumberPlateText(vehicle))
end

RegisterNetEvent("esx_givevehicules:boat")
AddEventHandler("esx_givevehicules:boat", function()

BoatCoche()

end)

function BoatCoche()
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)

	if IsPedInAnyVehicle(playerPed,  false) then
		vehicle = GetVehiclePedIsIn(playerPed, false)
	else
		vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 7.0, 0, 70)
	end
	
	local plate = GetVehicleNumberPlateText(vehicle)
	local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
	

	ESX.TriggerServerCallback('esx_givevehicules:requestPlayerCarsboat', function(isOwnedVehicle)

		if isOwnedVehicle then
		
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

          if closestPlayer == -1 or closestDistance > 3.0 then
		  	ESX.ShowNotification('Aucun joueur à proximité !')
          else
			ESX.ShowNotification('Vous avez donnez les papier de votre bateau immatriculer ~g~'..vehicleProps.plate..' ~w~!')
			TriggerServerEvent('esx_givevehicules:setVehicleOwnedPlayerIdboat', GetPlayerServerId(closestPlayer), vehicleProps)
			TriggerServerEvent('esx_givevehicules:setVehicleOwnedPlayerIdClee', GetPlayerServerId(closestPlayer), vehicleProps)
          end
		else
	       ESX.ShowNotification('Aucun véhicule à proximité ou le bateau vous appartient pas')
		end
	end, GetVehicleNumberPlateText(vehicle))
end


RegisterNetEvent("esx_givevehicules:air")
AddEventHandler("esx_givevehicules:air", function()

AirCoche()

end)

function AirCoche()
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)

	if IsPedInAnyVehicle(playerPed,  false) then
		vehicle = GetVehiclePedIsIn(playerPed, false)
	else
		vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 7.0, 0, 70)
	end
	
	local plate = GetVehicleNumberPlateText(vehicle)
	local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
	

	ESX.TriggerServerCallback('esx_givevehicules:requestPlayerCarsair', function(isOwnedVehicle)

		if isOwnedVehicle then
		
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

          if closestPlayer == -1 or closestDistance > 3.0 then
		  	ESX.ShowNotification('Aucun joueur à proximité !')
          else
			ESX.ShowNotification('Vous avez donnez les papier de votre avion/hélico immatriculer ~g~'..vehicleProps.plate..' ~w~!')
			TriggerServerEvent('esx_givevehicules:setVehicleOwnedPlayerIdair', GetPlayerServerId(closestPlayer), vehicleProps)
			TriggerServerEvent('esx_givevehicules:setVehicleOwnedPlayerIdClee', GetPlayerServerId(closestPlayer), vehicleProps)
          end
		else
	       ESX.ShowNotification('Aucun véhicule à proximité ou le avion/hélico vous appartient pas')
		end
	end, GetVehicleNumberPlateText(vehicle))
end