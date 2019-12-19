-----------------------------------------
-- Created and modify by L'ile Légale RP
-- SenSi and Kaminosekai
-----------------------------------------

ESX = nil
local PlayersTransforming  = {}
local PlayersSelling       = {}
local PlayersHarvesting = {}
local vine = 1
local jus = 1
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'brinks', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'brinks', _U('vigneron_client'), true, true)
TriggerEvent('esx_society:registerSociety', 'brinks', 'Brinks', 'society_brinks', 'society_brinks', 'society_brinks', {type = 'public'})

RegisterServerEvent('esx_brinks:GiveItem')
AddEventHandler('esx_brinks:GiveItem', function()
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  local Quantity = xPlayer.getInventoryItem('sacbillets').count

  if Quantity >= 20 then
    TriggerClientEvent('esx:showNotification', _source, _U('stop_npc'))
    return
  else
    xPlayer.addInventoryItem('sacbillets', 1)
    TriggerClientEvent('esx:showNotification', _source, 'Vous avez vidé le ~g~distributeur')
  end

end)

local function Sell(source, zone)

	if PlayersSelling[source] == true then
		local xPlayer  = ESX.GetPlayerFromId(source)
		
		if zone == 'SellFarm' then
			if xPlayer.getInventoryItem('sacbillets').count <= 0 then
			sacbillets = 0
			else
				sacbillets = 1
			end
		
			if sacbillets == 0 and sacbillets == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_product_sale'))
				return
			elseif xPlayer.getInventoryItem('sacbillets').count <= 0 and sacbillets == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_jus_sale'))
				sacbillets = 0
				return
			else
				if (sacbillets == 1) then
					SetTimeout(2500, function()
						local xPlayer        = ESX.GetPlayerFromId(source)
						local money = math.random(350,400)
						local playerMoney  = math.random(350,400)
						xPlayer.removeInventoryItem('sacbillets', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_brinks', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							societyAccount.addMoney(money)
							xPlayer.addMoney(playerMoney)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_earned') .. playerMoney)
						end
						Sell(source,zone)
					end)
				end
				
			end
		end
	end
end

RegisterServerEvent('esx_brinks:startSell')
AddEventHandler('esx_brinks:startSell', function(zone)

	local _source = source
	
	if PlayersSelling[_source] == false then
		PlayersSelling[_source]=false
	else
		PlayersSelling[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))
		Sell(_source, zone)
	end

end)

RegisterServerEvent('esx_brinks:stopSell')
AddEventHandler('esx_brinks:stopSell', function()

	local _source = source
	
	if PlayersSelling[_source] == true then
		PlayersSelling[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
		
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~vendre')
		PlayersSelling[_source]=true
	end

end)

RegisterServerEvent('esx_brinks:getStockItem')
AddEventHandler('esx_brinks:getStockItem', function(itemName, count)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_brinks', function(inventory)

		local item = inventory.getItem(itemName)

		if item.count >= count then
			inventory.removeItem(itemName, count)
			xPlayer.addInventoryItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn') .. count .. ' ' .. item.label)

	end)

end)

ESX.RegisterServerCallback('esx_brinks:getStockItems', function(source, cb)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_brinks', function(inventory)
		cb(inventory.items)
	end)

end)

RegisterServerEvent('esx_brinks:putStockItems')
AddEventHandler('esx_brinks:putStockItems', function(itemName, count)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_brinks', function(inventory)

		local item = inventory.getItem(itemName)

		if item.count >= 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('added') .. count .. ' ' .. item.label)

	end)
end)

ESX.RegisterServerCallback('esx_brinks:getPlayerInventory', function(source, cb)

	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = xPlayer.inventory

	cb({
		items      = items
	})

end)