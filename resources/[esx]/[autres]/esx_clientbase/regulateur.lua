local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX                     = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(1)
  end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
		if IsControlJustPressed(1, 246) then
			TriggerEvent('pv:setCruiseSpeed')
		end
	end
end)

local cruise = 0

AddEventHandler('pv:setCruiseSpeed', function()
	if cruise == 0 and IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		if GetEntitySpeedVector(GetVehiclePedIsIn(GetPlayerPed(-1), false), true)['y'] > 0 then
			
			cruise = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false))
			
			local cruiseKm  = math.floor(cruise * 3.6 + 0.5)
			local cruiseMph = math.floor(cruise * 2.23694 + 0.5)
			
			NotificationMessage('Limitateur: ~g~ ACTIF~w~ - ~b~ ' .. cruiseKm ..' km/h')
			
			Citizen.CreateThread(function()
				while cruise > 0 and GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1) == GetPlayerPed(-1) do
					local cruiseVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
					if IsVehicleOnAllWheels(cruiseVeh) and GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) > (cruise - 2.0) then
						SetVehicleForwardSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false), cruise)
					else
						cruise = 0
						NotificationMessage('Limitateur: ~r~ INACTIF')
						break
					end
					if IsControlPressed(1, 8) then
						cruise = 0
						NotificationMessage('Limitateur: ~r~ INACTIF')
					end
					if IsControlPressed(1, 32) then
						cruise = 0
						TriggerEvent('pv:setNewSpeed')
					end
					if cruise > 44 then
						cruise = 0
						NotificationMessage('Limitateur: Ne peux pas être aussi élevé !')
						break
					end
					Wait(200)
				end
				cruise = 0
			end)
		else
			cruise = 0
			NotificationMessage('Limitateur: ~r~INACTIF')
		end
	else
		if cruise > 0 then
			NotificationMessage('Limitateur: ~r~INACTIF')
		end
		cruise = 0
	end
end)

AddEventHandler('pv:setNewSpeed', function()
	Citizen.CreateThread(function()
		while IsControlPressed(1, 32) do
			Citizen.Wait(1)
		end
		TriggerEvent('pv:setCruiseSpeed')
	end)
end)

function NotificationMessage(message)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(message)
	DrawNotification(0,1)
end
