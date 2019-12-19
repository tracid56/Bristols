-----------------------
-- Lucifer
-- Copyrighted © Lucifer 2018
-- Do not redistribute or edit in any way without my permission.
-----------------------

peacetime = false

RegisterNetEvent("isPeacetime")
AddEventHandler("isPeacetime", function(peacetime)
	isPeacetime = peacetime
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)

		local ply = PlayerPedId()

		if isPeacetime then
			DisableControlAction(0, 24)
			DisableControlAction(0, 25)
			DisableControlAction(0, 45)
			DisableControlAction(0, 69)
			DisableControlAction(0, 92)
			DisableControlAction(0, 106)
			DisableControlAction(0, 122)
			DisableControlAction(0, 135)
			DisableControlAction(0, 140)
			DisableControlAction(0, 142)
			DisableControlAction(0, 144)
			DisableControlAction(0, 176)
			DisableControlAction(0, 223)
			DisableControlAction(0, 229)
			DisableControlAction(0, 237)
			DisableControlAction(0, 257)
			DisableControlAction(0, 329)
			if IsDisabledControlPressed(0, 24) or IsDisabledControlPressed(0, 25) then
				DisablePlayerFiring(ply, true)
				showNotification("~r~Bristols ! ~n~~w~Le PVP est désactiver")
			end
		end
	end
end)

function showNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(0, 1)
end
