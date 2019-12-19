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
    Citizen.Wait(0)
  end
end)

local indicator = "Off"

RegisterNetEvent('pv:syncIndicator')
AddEventHandler('pv:syncIndicator', function (playerId, IStatus)
	if GetPlayerFromServerId(playerId) ~= PlayerId() then
		local ped = GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(playerId)), false)
		if IStatus == "Off" then
			SetVehicleIndicatorLights(ped, 0, false)
			SetVehicleIndicatorLights(ped, 1, false)
		elseif IStatus == "Left" then
			SetVehicleIndicatorLights(ped, 0, false)
			SetVehicleIndicatorLights(ped, 1, true)
		elseif IStatus == "Right" then
			SetVehicleIndicatorLights(ped, 0, true)
			SetVehicleIndicatorLights(ped, 1, false)
		elseif IStatus == "Both" then
			SetVehicleIndicatorLights(ped, 0, true)
			SetVehicleIndicatorLights(ped, 1, true)
		end
	end
end)

AddEventHandler('pv:setIndicator', function (IStatus)
	local ped = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	local HasTrailer, vehTrailer = GetVehicleTrailerVehicle(ped, vehTrailer)
	if IStatus == "Off" then
		SetVehicleIndicatorLights(ped, 0, false)
		SetVehicleIndicatorLights(ped, 1, false)
		if HasTrailer then
			SetVehicleIndicatorLights(vehTrailer, 0, false)
			SetVehicleIndicatorLights(vehTrailer, 1, false)
		end
		elseif IStatus == "Left" then
			SetVehicleIndicatorLights(ped, 0, false)
			SetVehicleIndicatorLights(ped, 1, true)
			if HasTrailer then
				SetVehicleIndicatorLights(vehTrailer, 0, false)
				SetVehicleIndicatorLights(vehTrailer, 1, true)
			end
		elseif IStatus == "Right" then
			SetVehicleIndicatorLights(ped, 0, true)
			SetVehicleIndicatorLights(ped, 1, false)
			if HasTrailer then
				SetVehicleIndicatorLights(vehTrailer, 0, true)
				SetVehicleIndicatorLights(vehTrailer, 1, false)
			end
		elseif IStatus == "Both" then
			SetVehicleIndicatorLights(ped, 0, true)
			SetVehicleIndicatorLights(ped, 1, true)
		if HasTrailer then
			SetVehicleIndicatorLights(vehTrailer, 0, true)
			SetVehicleIndicatorLights(vehTrailer, 1, true)
		end
	end
end)

RegisterNetEvent('pv:setHazards')
AddEventHandler('pv:setHazards', function(hazardsDeactivate)
	local ped = GetVehiclePedIsIn(GetPlayerPed(-1), true)
	if ped ~= nil then
		local setHazards = true
		if hazardsDeactivate == "false" or hazardsDeactivate == "0" or hazardsDeactivate == "off" then
			setHazards = false
		end
		if setHazards then
			indicator = "Both"
		else
			indicator = "Off"
		end
		TriggerServerEvent("pv:syncIndicator", indicator)
		TriggerEvent("pv:setIndicator", indicator)
	end
end)

local pedHeading = 0.0
local indicatorTime = 0

Citizen.CreateThread(function()
	while true do
		-- Citizen.Wait(0)
		local ped = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		if ped ~= nil and GetPedInVehicleSeat(ped, -1) == GetPlayerPed(-1) then
			if IsControlJustPressed(1, 174) then
				indicatorTime = 0
				if indicator == "Left" then
					indicator = "Off"
				else
					indicator = "Left"
					pedHeading = GetEntityHeading(ped)
				end
				TriggerServerEvent("pv:syncIndicator", indicator)
				TriggerEvent("pv:setIndicator", indicator)
			elseif IsControlJustPressed(1, 175) then
				indicatorTime = 0
				if indicator == "Right" then
					indicator = "Off"
				else
					indicator = "Right"
					pedHeading = GetEntityHeading(ped)
				end
				TriggerServerEvent("pv:syncIndicator", indicator)
				TriggerEvent("pv:setIndicator", indicator)
			elseif IsControlJustPressed(1, 172) then
				indicatorTime = 0
				if indicator == "Both" then
					indicator = "Off"
				else
					indicator = "Both"
					pedHeading = GetEntityHeading(ped)
				end
				TriggerServerEvent("pv:syncIndicator", indicator)
				TriggerEvent("pv:setIndicator", indicator)
			end
			if indicatorTime == 0 then
				if indicator ~= "Off" then
					local pedNewHeading = GetEntityHeading(ped)
					if math.abs(pedNewHeading - pedHeading) > 60.0 then
						indicatorTime = GetGameTimer() + 1500
					end
				end
			else
				if GetGameTimer() >= indicatorTime and indicator ~= "Both" and (indicator == "Left" or indicator == "Right") then
					indicator = "Off"
					TriggerServerEvent("pv:syncIndicator", indicator)
					TriggerEvent("pv:setIndicator", indicator)
				end
			end
		end
		if ped ~= nil and ped ~= false and GetPedInVehicleSeat(ped, -1) == GetPlayerPed(-1) and IsVehicleEngineOn(ped) then
			if GetEntitySpeed(ped) < 4 and not IsControlPressed(1, 32) then
				SetVehicleBrakeLights(ped, true)
			end
		end
		for playerIds = 0,65 do
			if NetworkIsPlayerActive(GetPlayerFromServerId(playerIds)) then
				local networkPed = GetPlayerPed(GetPlayerFromServerId(playerIds))
				local networkPedVeh = GetVehiclePedIsIn(networkPed, false)
				if networkPedVeh ~= nil and networkPedVeh ~= false and GetPlayerFromServerId(playerIds) ~= PlayerId() and GetPedInVehicleSeat(networkPedVeh, -1) == networkPed and IsVehicleEngineOn(networkPedVeh) then
					if GetEntitySpeed(networkPedVeh) < 2 then
						SetVehicleBrakeLights(networkPedVeh, true)
					end
				end
			end
		end
		Citizen.Wait(1)
	end
end)