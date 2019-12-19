----------------------------------------------------------------
-- Made By: Guy293
-- GitHub: https://github.com/Guy293
-- Fivem Forum: https://forum.fivem.net/u/guy293/
----------------------------------------------------------------

--Get ESX Data
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-- Store data for later
LSPD = 0
EMS = 0
DEPANNEUR = 0
TAXI = 0
BANQUIER = 0


-- Get jobs data every 10 secconds
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)
		ESX.TriggerServerCallback('guy293_getJobsOnline', function(police, ems, depanneur, taxi, banquier)
			LSPD = police
			EMS = ems
			DEPANNEUR = depanneur
			TAXI = taxi
			BANQUIER = banquier
		end)
	end
end)
			
-- Print text
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		DrawText2(0.675, 1.337, 1.0,1.0,0.45, "LSPD: ~w~" .. LSPD , 54 ,126, 253, 200)
		DrawText2(0.675, 1.359, 1.0,1.0,0.45, "EMS: ~w~" .. EMS , 253 ,104, 225, 200)
		DrawText2(0.675, 1.381, 1.0,1.0,0.45, "Dépanneur: ~w~" .. DEPANNEUR , 145 ,144, 144, 200)
		DrawText2(0.675, 1.403, 1.0,1.0,0.45, "Taxi: ~w~" .. TAXI , 255 ,247, 0, 200)
		DrawText2(0.675, 1.425, 1.0,1.0,0.45, "Banquier: ~w~" .. BANQUIER , 250 ,132, 0, 200)
	end
end)



function DrawText2(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end