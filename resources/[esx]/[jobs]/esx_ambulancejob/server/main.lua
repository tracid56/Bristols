ESX = nil

PlayersHarvesting  = {}
PlayersHarvesting2 = {}
PlayersCrafting    = {}
PlayersCrafting2   = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function(target, type)
  TriggerClientEvent('esx_ambulancejob:revive', target, type)
end)

RegisterServerEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(target, type)
  TriggerClientEvent('esx_ambulancejob:heal', target, type)
end)

TriggerEvent('esx_phone:registerNumber', 'ambulance', _U('alert_ambulance'), true, true)
TriggerEvent('esx_society:registerSociety', 'ambulance', 'Ambulance', 'society_ambulance', 'society_ambulance', 'society_ambulance', {type = 'public'})

-------------- Récupération Défibrilateur -------------
local function Harvest(source)

  SetTimeout(4000, function()

    if PlayersHarvesting[source] == true then

      local _source = source
      local xPlayer = ESX.GetPlayerFromId(_source)
      local GazBottleQuantity = xPlayer.getInventoryItem('defibrilateur').count

      if GazBottleQuantity >= 50 then
        TriggerClientEvent('esx:showNotification', source, _U('you_do_not_room'))
      else
                xPlayer.addInventoryItem('defibrilateur', 1)

        Harvest(source)
      end
    end
  end)
end

RegisterServerEvent('esx_ambulancejob:startHarvest')
AddEventHandler('esx_ambulancejob:startHarvest', function()
  local _source = source
  PlayersHarvesting[_source] = true
  TriggerClientEvent('esx:showNotification', source, _U('recovery_gas_can'))
  Harvest(source)
end)

RegisterServerEvent('esx_ambulancejob:stopHarvest')
AddEventHandler('esx_ambulancejob:stopHarvest', function()
  local _source = source
  PlayersHarvesting[_source] = false
end)

-------------- Récupération Dopamine -------------
local function Harvest2(source)

  SetTimeout(4000, function()

    if PlayersHarvesting2[source] == true then

      local _source = source
      local xPlayer = ESX.GetPlayerFromId(_source)
      local GazBottleQuantity = xPlayer.getInventoryItem('dopamine').count

      if GazBottleQuantity >= 50 then
        TriggerClientEvent('esx:showNotification', source, _U('you_do_not_room'))
      else
                xPlayer.addInventoryItem('dopamine', 1)

        Harvest2(source)
      end
    end
  end)
end

RegisterServerEvent('esx_ambulancejob:startHarvest2')
AddEventHandler('esx_ambulancejob:startHarvest2', function()
  local _source = source
  PlayersHarvesting2[_source] = true
  TriggerClientEvent('esx:showNotification', source, _U('recovery_dopamine'))
  Harvest2(source)
end)

RegisterServerEvent('esx_ambulancejob:stopHarvest2')
AddEventHandler('esx_ambulancejob:stopHarvest2', function()
  local _source = source
  PlayersHarvesting2[_source] = false
end)

------------ Craft kit de Soin --------------
local function Craft(source)

  SetTimeout(4000, function()

    if PlayersCrafting[source] == true then

      local _source = source
      local xPlayer = ESX.GetPlayerFromId(_source)
      local FixToolQuantity  = xPlayer.getInventoryItem('defibrilateur').count
      if FixToolQuantity <= 1 then
        TriggerClientEvent('esx:showNotification', source, _U('not_enough_gaz_can'))
      else
                xPlayer.removeInventoryItem('defibrilateur', 2)
                xPlayer.addInventoryItem('medkit', 1)

        Craft(source)
      end
    end
  end)
end

RegisterServerEvent('esx_ambulancejob:startCraft')
AddEventHandler('esx_ambulancejob:startCraft', function()
  local _source = source
  PlayersCrafting[_source] = true
  TriggerClientEvent('esx:showNotification', source, _U('assembling_blowtorch'))
  Craft(source)
end)

RegisterServerEvent('esx_ambulancejob:stopCraft')
AddEventHandler('esx_ambulancejob:stopCraft', function()
  local _source = source
  PlayersCrafting[_source] = false
end)

------------ Craft Seringue Adrénaline --------------
local function Craft2(source)

  SetTimeout(4000, function()

    if PlayersCrafting2[source] == true then

      local _source = source
      local xPlayer = ESX.GetPlayerFromId(_source)
      local FixToolQuantity  = xPlayer.getInventoryItem('dopamine').count
      if FixToolQuantity <= 1 then
        TriggerClientEvent('esx:showNotification', source, _U('not_enough_gaz_can'))
      else
                xPlayer.removeInventoryItem('dopamine', 2)
                xPlayer.addInventoryItem('adrenaline', 1)

        Craft2(source)
      end
    end
  end)
end

RegisterServerEvent('esx_ambulancejob:startCraft2')
AddEventHandler('esx_ambulancejob:startCraft2', function()
  local _source = source
  PlayersCrafting2[_source] = true
  TriggerClientEvent('esx:showNotification', source, _U('assembling_adrenaline'))
  Craft2(source)
end)

RegisterServerEvent('esx_ambulancejob:stopCraft2')
AddEventHandler('esx_ambulancejob:stopCraft2', function()
  local _source = source
  PlayersCrafting2[_source] = false
end)
-----------------------------------------------------------------------------------------------------------------------------------
ESX.RegisterServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function(source, cb)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local societyAccount = nil

  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
    societyAccount = account
  end)

  societyAccount.addMoney(100)
  xPlayer.removeMoney(0)

  if Config.RemoveCashAfterRPDeath then
    xPlayer.setAccountMoney('black_money', 0)
  end

  if Config.RemoveItemsAfterRPDeath then
    for i=1, #xPlayer.inventory, 1 do
      if xPlayer.inventory[i].count > 0 then
        xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
      end
    end
  end

  if Config.RemoveWeaponsAfterRPDeath then
    for i=1, #xPlayer.loadout, 1 do
      xPlayer.removeWeapon(xPlayer.loadout[i].name)
    end
  end

  cb()

end)

ESX.RegisterServerCallback('esx_ambulancejob:removeItemsAfterRPDeathRemoveMoney', function(source, cb)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  if Config.RemoveCashAfterRPDeath then
    xPlayer.setAccountMoney('black_money', 0)
  end

  if Config.RemoveItemsAfterRPDeath then
    for i=1, #xPlayer.inventory, 1 do
      if xPlayer.inventory[i].count > 0 and not xPlayer.inventory[i].rare then
        xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
      end
    end
  end

  if Config.RemoveWeaponsAfterRPDeath then
    for i=1, #xPlayer.loadout, 1 do
      xPlayer.removeWeapon(xPlayer.loadout[i].name)
    end
  end

  cb()

end)

RegisterServerEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function(target)
  TriggerClientEvent('esx_ambulancejob:putInVehicle', target)
end)


ESX.RegisterServerCallback('esx_ambulancejob:getBankMoney', function(source, cb)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local money = xPlayer.getAccount('bank').money

    cb(money)
end)


TriggerEvent('es:addGroupCommand', 'revive', 'admin', function(source, args, user)

  if args[2] ~= nil then
    TriggerClientEvent('esx_ambulancejob:revive', tonumber(args[2]))
  else
    TriggerClientEvent('esx_ambulancejob:revive', source)
  end
end, function(source, args, user)
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficient Permissions.")
end, {help = _U('revive_help'), params = {{name = 'id'}}})



ESX.RegisterServerCallback('esx_ambulancejob:getFineList', function(source, cb, category)
  MySQL.Async.fetchAll(
    'SELECT * FROM fine_types_ambulance WHERE category = @category',
    {
      ['@category'] = category
    },
    function(fines)
      cb(fines)
    end
  )
end)


ESX.RegisterServerCallback('esx_ambulancejob:getItemAmount', function(source, cb, item)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local qtty = xPlayer.getInventoryItem(item).count
  cb(qtty)
end)



RegisterServerEvent('esx_ambulancejob:success')
AddEventHandler('esx_ambulancejob:success', function()

  math.randomseed(os.time())

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local total          = math.random(Config.NPCJobEarnings.min, Config.NPCJobEarnings.max);
  local societyAccount = nil

  if xPlayer.job.grade >= 3 then
    total = total * 2
  end

  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
    societyAccount = account
  end)

  if societyAccount ~= nil then

    local playerMoney  = 10
    local societyMoney = 20

    xPlayer.addMoney(playerMoney)
    societyAccount.addMoney(societyMoney)

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_earned') .. playerMoney)
    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. societyMoney)

  else

    xPlayer.addMoney(total)
    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_earned') .. total)

  end

end)


RegisterServerEvent('esx_ambulancejob:getStockItem')
AddEventHandler('esx_ambulancejob:getStockItem', function(itemName, count)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ambulance', function(inventory)

    local item = inventory.getItem(itemName)

    if item.count >= count then
      inventory.removeItem(itemName, count)
      xPlayer.addInventoryItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_removed') .. count .. ' ' .. item.label)

  end)

end)

ESX.RegisterServerCallback('esx_ambulancejob:getStockItems', function(source, cb)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ambulance', function(inventory)
    cb(inventory.items)
  end)

end)

-------------
-- AJOUT 2 --
-------------

RegisterServerEvent('esx_ambulancejob:putStockItems')
AddEventHandler('esx_ambulancejob:putStockItems', function(itemName, count)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ambulance', function(inventory)

    local item = inventory.getItem(itemName)

    if item.count >= 0 then
      xPlayer.removeInventoryItem(itemName, count)
      inventory.addItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_added') .. count .. ' ' .. item.label)

  end)

end)

ESX.RegisterServerCallback('esx_ambulancejob:putStockItems', function(source, cb)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ambulance', function(inventory)
    cb(inventory.items)
  end)

end)

ESX.RegisterServerCallback('esx_ambulancejob:getPlayerInventory', function(source, cb)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local items      = xPlayer.inventory

  cb({
    items      = items
  })

end)

-- Registable Item MedKit --
ESX.RegisterUsableItem('medkit', function(source)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  xPlayer.removeInventoryItem('medkit', 1)

  TriggerClientEvent('esx_ambulancejob:heal', source, 'big')
  TriggerClientEvent('esx:showNotification', source, _U('Used_Medkit'))

end)

-- Registable Item MedKit --
ESX.RegisterUsableItem('doliprane', function(source)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  xPlayer.removeInventoryItem('doliprane', 1)

  TriggerClientEvent('esx_ambulancejob:heal2', source, 'other')
  TriggerClientEvent('esx:showNotification', source, _U('Used_Doliprane'))

end)

-- Registable Item Adrénaline --
ESX.RegisterUsableItem('adrenaline', function(source)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.removeInventoryItem('adrenaline', 1)

  TriggerClientEvent('esx_ambulancejob:revive', source)
  TriggerClientEvent('shakeCam', source, false)
  TriggerClientEvent('esx:showNotification', source, _U('Used_adrenaline'))

end)

RegisterServerEvent('esx_ambulancejob:annonce')
AddEventHandler('esx_ambulancejob:annonce', function(result)
  local _source  = source
  local xPlayer  = ESX.GetPlayerFromId(_source)
  local xPlayers = ESX.GetPlayers()
  local text     = result
  print(text)
  for i=1, #xPlayers, 1 do
    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
    TriggerClientEvent('esx_ambulancejob:annonce', xPlayers[i],text)
  end

  Citizen.Wait(8000)

  local xPlayers = ESX.GetPlayers()
  for i=1, #xPlayers, 1 do
    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
    TriggerClientEvent('esx_ambulancejob:annoncestop', xPlayers[i])
  end

end)

RegisterServerEvent('esx_ambulancejob:firstSpawn')
AddEventHandler('esx_ambulancejob:firstSpawn', function()
	local _source    = source
	local identifier = GetPlayerIdentifiers(_source)[1]
	MySQL.Async.fetchScalar('SELECT isDead FROM users WHERE identifier=@identifier',
	{
		['@identifier'] = identifier
	}, function(isDead)
		if isDead == 1 then
			print('Bristols: ' .. GetPlayerName(_source) .. ' [' .. identifier .. '] est mort')
			TriggerClientEvent('esx_ambulancejob:requestDeath', _source)
		end
	end)
end)

RegisterServerEvent('esx_ambulancejob:setDeathStatus')
AddEventHandler('esx_ambulancejob:setDeathStatus', function(isDead)
	local _source = source
	MySQL.Sync.execute("UPDATE users SET isDead=@isDead WHERE identifier=@identifier",
	{
		['@identifier'] = GetPlayerIdentifiers(_source)[1],
		['@isDead'] = isDead
	})
end)