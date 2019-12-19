ESX 						              = nil
local PlayersHarvestingOrange = {}
local PlayersHarvestingGrape  = {}
local PlayersWashMoney			  = {}
local CopsConnected           = 0

AddEventHandler('esx:playerLoaded', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

end)

AddEventHandler('esx:playerDropped', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

end)

AddEventHandler('esx:setJob', function(source, job, lastJob)

end)

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

----------------------------
---------- ORANGE ----------
----------------------------


local function HarvestOrange(source)

	SetTimeout(3000, function()

		if PlayersHarvestingOrange[source] == true then

			local xPlayer  = ESX.GetPlayerFromId(source)

			if xPlayer ~= nil then
				local orange = xPlayer.getInventoryItem('orange')

				if orange.limit ~= -1 and orange.count >= orange.limit then
					TriggerClientEvent('esx:showNotification', source, _U('inv_full'))
				else
					xPlayer.addInventoryItem('orange', 1)
					HarvestOrange(source)
				end
			end

		end
	end)
end

RegisterServerEvent('esx_various:startHarvestOrange')
AddEventHandler('esx_various:startHarvestOrange', function()

	local _source = source

	PlayersHarvestingOrange[_source] = true

	TriggerClientEvent('esx:showNotification', _source, _U('pickup_in_prog'))

	HarvestOrange(_source)

end)

RegisterServerEvent('esx_various:stopHarvestOrange')
AddEventHandler('esx_various:stopHarvestOrange', function()

	local _source = source

	PlayersHarvestingOrange[_source] = false

end)



--------------------------------------------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------
-----////////////////////////Use Objetc////////////////////////-----
--------------------------------------------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------

----------------------------
-- Utiliser Sandwich Thon --
----------------------------
ESX.RegisterUsableItem('fishburger', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('fishburger', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 300000) 
	TriggerClientEvent('esx_basicneeds:hamburger', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_FishBurger'))

end)

----------------------------
-- Utiliser Burger Viande --
----------------------------
ESX.RegisterUsableItem('ckiburger', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('ckiburger', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 350000) 
	TriggerClientEvent('esx_basicneeds:hamburger', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_ChikBurger'))

end)

----------------------------
------ Utiliser Orange -----
----------------------------
ESX.RegisterUsableItem('orange', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('orange', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 100000) 
	TriggerClientEvent('esx_status:add', source, 'thirst', 50000) 
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_orange'))

end)

----------------------------
------ Utiliser Raisin -----
----------------------------
ESX.RegisterUsableItem('grape', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('grape', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 100000) 
	TriggerClientEvent('esx_status:add', source, 'thirst', 50000) 
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_grape'))

end)

----------------------------
-- Utiliser Jus d'orange ---
----------------------------
ESX.RegisterUsableItem('orangejus', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('orangejus', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 300000)
	TriggerClientEvent('esx_status:add', source, 'hunger', 150000) 
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_orangejus'))

end)

----------------------------
-- Utiliser Jus de raisin --
----------------------------
ESX.RegisterUsableItem('grapesjus', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('grapesjus', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 300000)
	TriggerClientEvent('esx_status:add', source, 'hunger', 150000)  
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_grapesjus'))

end)

----------------------------
---- Utiliser Cigarette ----
----------------------------
ESX.RegisterUsableItem('cigaret', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('cigaret', 1)

	TriggerClientEvent('esx_teamsterjob:onSmoke', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez utilisé ~g~1x ~b~Cigarette')

end)

----------------------------
---- Utiliser CorsicaCola ----
----------------------------
ESX.RegisterUsableItem('cocacola', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('cocacola', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 225000)
	-- TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	TriggerClientEvent('esx_teamsterjob:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez utilisé ~g~1x ~b~Coca Cola')

end)

----------------------------
----- Utiliser Banane ------
----------------------------
ESX.RegisterUsableItem('banana', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('banana', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 160000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_Banana'))

end)



----------------------------
----- UTILISER  COFEE  -----
----------------------------
ESX.RegisterUsableItem('coffee', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('coffee', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 50000)
	TriggerClientEvent('esx_status:add', source, 'hunger', 50000)  
	TriggerClientEvent('esx_teamsterjob:onDrink2', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez utilisé ~g~1x ~b~Café')

end)
