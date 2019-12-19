ESX                 = nil
PlayersHarvesting   = {}
PlayersHarvesting2  = {}
PlayersHarvesting3  = {}
PlayersHarvesting4  = {}
PlayersHarvesting5  = {}
PlayersHarvesting6  = {}
PlayersHarvesting7  = {}
PlayersCrafting     = {}
PlayersCrafting2    = {}
PlayersCrafting3    = {}
PlayersCrafting4    = {}
PlayersCrafting5    = {}
PlayersCrafting6    = {}
PlayersCrafting7    = {}
local CreatedInstances = {}

function randomFloat(lower, greater)
  return lower + math.random()  * (greater - lower);
end

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
  
  local _source = source
  
  TriggerClientEvent('esx_unicorn:setTimeDiff', _source, os.time())
  TriggerClientEvent('esx_unicorn:onCreatedInstanceData', _source, CreatedInstances)

end)

if Config.MaxInService ~= -1 then
  TriggerEvent('esx_service:activateService', 'unicorn', Config.MaxInService)
end

TriggerEvent('esx_cryptedphone:registerNumber', 'unicorn', 'Contact Cartel', true, true)
TriggerEvent('esx_society:registerSociety', 'unicorn', 'Unicorn', 'society_unicorn', 'society_unicorn', 'society_unicorn', {type = 'private'})

RegisterServerEvent('esx_unicorn:annonce')
AddEventHandler('esx_unicorn:annonce', function(result)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	local text     = result
	print(text)
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		TriggerClientEvent('esx_unicorn:annonce', xPlayers[i],text)
	end

	Wait(8000)

	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		TriggerClientEvent('esx_unicorn:annoncestop', xPlayers[i])
	end

end)


-------------- Récupération de Menthe -------------
local function Harvest(source)

  SetTimeout(4000, function()

    if PlayersHarvesting[source] == true then

      local _source = source
      local xPlayer = ESX.GetPlayerFromId(_source)
      local GazBottleQuantity = xPlayer.getInventoryItem('menthe').count

      if GazBottleQuantity >= 80 then
        TriggerClientEvent('esx:showNotification', source, '~r~Vous n\'avez plus de place')
      else
                xPlayer.addInventoryItem('menthe', 4)

        Harvest(source)
      end
    end
  end)
end

RegisterServerEvent('esx_unicorn:startHarvest')
AddEventHandler('esx_unicorn:startHarvest', function()
  local _source = source
  PlayersHarvesting[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Récupération de ~b~Menthe~s~...')
  Harvest(source)
end)

RegisterServerEvent('esx_unicorn:stopHarvest')
AddEventHandler('esx_unicorn:stopHarvest', function()
  local _source = source
  PlayersHarvesting[_source] = false
end)
------------ Récupération Pomme de Terre --------------
local function Harvest2(source)

  SetTimeout(4000, function()

    if PlayersHarvesting2[source] == true then

      local _source = source
      local xPlayer = ESX.GetPlayerFromId(_source)
      local FixToolQuantity  = xPlayer.getInventoryItem('patate').count
      if FixToolQuantity >= 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Vous n\'avez plus de place')
      else
                xPlayer.addInventoryItem('patate', 4)

        Harvest2(source)
      end
    end
  end)
end

RegisterServerEvent('esx_unicorn:startHarvest2')
AddEventHandler('esx_unicorn:startHarvest2', function()
  local _source = source
  PlayersHarvesting2[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Récupération de ~b~Pomme de Terre~s~...')
  Harvest2(_source)
end)

RegisterServerEvent('esx_unicorn:stopHarvest2')
AddEventHandler('esx_unicorn:stopHarvest2', function()
  local _source = source
  PlayersHarvesting2[_source] = false
end)
----------------- Récupération Raisin ----------------
local function Harvest3(source)

  SetTimeout(4000, function()

    if PlayersHarvesting3[source] == true then

      local _source = source
      local xPlayer = ESX.GetPlayerFromId(_source)
      local CaroToolQuantity  = xPlayer.getInventoryItem('raisin').count
            if CaroToolQuantity >= 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Vous n\'avez plus de place')
      else
                xPlayer.addInventoryItem('raisin', 4)

        Harvest3(source)
      end
    end
  end)
end

RegisterServerEvent('esx_unicorn:startHarvest3')
AddEventHandler('esx_unicorn:startHarvest3', function()
  local _source = source
  PlayersHarvesting3[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Récupération de ~b~Raisin~s~...')
  Harvest3(_source)
end)

RegisterServerEvent('esx_unicorn:stopHarvest3')
AddEventHandler('esx_unicorn:stopHarvest3', function()
  local _source = source
  PlayersHarvesting3[_source] = false
end)
------------ Craft Mojito -------------------
local function Craft(source)

  SetTimeout(4000, function()

    if PlayersCrafting[source] == true then

      local _source = source
      local xPlayer = ESX.GetPlayerFromId(_source)
      local GazBottleQuantity = xPlayer.getInventoryItem('menthe').count

      if GazBottleQuantity <= 0 then
        TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ de Menthe')
      else
                xPlayer.removeInventoryItem('menthe', 4)
                xPlayer.addInventoryItem('mojito', 2)

        Craft(source)
      end
    end
  end)
end

RegisterServerEvent('esx_unicorn:startCraft')
AddEventHandler('esx_unicorn:startCraft', function()
  local _source = source
  PlayersCrafting[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Production de ~b~Mojito~s~...')
  Craft(_source)
end)

RegisterServerEvent('esx_unicorn:stopCraft')
AddEventHandler('esx_unicorn:stopCraft', function()
  local _source = source
  PlayersCrafting[_source] = false
end)
------------ Craft Vodka --------------
local function Craft2(source)

  SetTimeout(4000, function()

    if PlayersCrafting2[source] == true then

      local _source = source
      local xPlayer = ESX.GetPlayerFromId(_source)
      local FixToolQuantity  = xPlayer.getInventoryItem('patate').count
      if FixToolQuantity <= 0 then
        TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ de Pomme de Terre')
      else
                xPlayer.removeInventoryItem('patate', 4)
                xPlayer.addInventoryItem('vodka', 2)

        Craft2(source)
      end
    end
  end)
end

RegisterServerEvent('esx_unicorn:startCraft2')
AddEventHandler('esx_unicorn:startCraft2', function()
  local _source = source
  PlayersCrafting2[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Production de ~b~Vodka~s~...')
  Craft2(_source)
end)

RegisterServerEvent('esx_unicorn:stopCraft2')
AddEventHandler('esx_unicorn:stopCraft2', function()
  local _source = source
  PlayersCrafting2[_source] = false
end)
----------------- Craft Champagne ----------------
local function Craft3(source)

  SetTimeout(4000, function()

    if PlayersCrafting3[source] == true then

      local _source = source
      local xPlayer = ESX.GetPlayerFromId(_source)
      local CaroToolQuantity  = xPlayer.getInventoryItem('raisin').count
            if CaroToolQuantity <= 0 then
        TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez ~r~pas assez~s~ de Raisin')
      else
                xPlayer.removeInventoryItem('raisin', 4)
                xPlayer.addInventoryItem('champagne', 2)

        Craft3(source)
      end
    end
  end)
end

RegisterServerEvent('esx_unicorn:startCraft3')
AddEventHandler('esx_unicorn:startCraft3', function()
  local _source = source
  PlayersCrafting3[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Production de ~b~Champagne~s~...')
  Craft3(_source)
end)

RegisterServerEvent('esx_unicorn:stopCraft3')
AddEventHandler('esx_unicorn:stopCraft3', function()
  local _source = source
  PlayersCrafting3[_source] = false
end)

-------------- Récupération de Houblon -------------
local function Harvest4(source)

  SetTimeout(4000, function()

    if PlayersHarvesting4[source] == true then

      local _source = source
      local xPlayer = ESX.GetPlayerFromId(_source)
      local GazBottleQuantity = xPlayer.getInventoryItem('houblon').count

      if GazBottleQuantity >= 80 then
        TriggerClientEvent('esx:showNotification', source, '~r~Vous n\'avez plus de place')
      else
                xPlayer.addInventoryItem('houblon', 4)

        Harvest4(source)
      end
    end
  end)
end

RegisterServerEvent('esx_unicorn:startHarvest4')
AddEventHandler('esx_unicorn:startHarvest4', function()
  local _source = source
  PlayersHarvesting4[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Récupération de ~b~Houblon~s~...')
  Harvest4(source)
end)

RegisterServerEvent('esx_unicorn:stopHarvest4')
AddEventHandler('esx_unicorn:stopHarvest4', function()
  local _source = source
  PlayersHarvesting4[_source] = false
end)

------------ Récupération Malte --------------
local function Harvest5(source)

  SetTimeout(4000, function()

    if PlayersHarvesting5[source] == true then

      local _source = source
      local xPlayer = ESX.GetPlayerFromId(_source)
      local FixToolQuantity  = xPlayer.getInventoryItem('malte').count
      if FixToolQuantity >= 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Vous n\'avez plus de place')
      else
                xPlayer.addInventoryItem('malte', 4)

        Harvest5(source)
      end
    end
  end)
end

RegisterServerEvent('esx_unicorn:startHarvest5')
AddEventHandler('esx_unicorn:startHarvest5', function()
  local _source = source
  PlayersHarvesting5[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Récupération de ~b~Malte~s~...')
  Harvest5(_source)
end)

RegisterServerEvent('esx_unicorn:stopHarvest5')
AddEventHandler('esx_unicorn:stopHarvest5', function()
  local _source = source
  PlayersHarvesting5[_source] = false
end)

----------------- Récupération Sucre ----------------
local function Harvest6(source)

  SetTimeout(4000, function()

    if PlayersHarvesting6[source] == true then

      local _source = source
      local xPlayer = ESX.GetPlayerFromId(_source)
      local CaroToolQuantity  = xPlayer.getInventoryItem('sucre').count
            if CaroToolQuantity >= 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Vous n\'avez plus de place')
      else
                xPlayer.addInventoryItem('sucre', 4)

        Harvest6(source)
      end
    end
  end)
end

RegisterServerEvent('esx_unicorn:startHarvest6')
AddEventHandler('esx_unicorn:startHarvest6', function()
  local _source = source
  PlayersHarvesting6[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Récupération de ~b~Sucre~s~...')
  Harvest6(_source)
end)

RegisterServerEvent('esx_unicorn:stopHarvest6')
AddEventHandler('esx_unicorn:stopHarvest6', function()
  local _source = source
  PlayersHarvesting6[_source] = false
end)

----------------- Récupération Fruits ----------------
local function Harvest7(source)

  SetTimeout(4000, function()

    if PlayersHarvesting7[source] == true then

      local _source = source
      local xPlayer = ESX.GetPlayerFromId(_source)
      local CaroToolQuantity  = xPlayer.getInventoryItem('fruits').count
            if CaroToolQuantity >= 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Vous n\'avez plus de place')
      else
                xPlayer.addInventoryItem('fruits', 4)

        Harvest7(source)
      end
    end
  end)
end

RegisterServerEvent('esx_unicorn:startHarvest7')
AddEventHandler('esx_unicorn:startHarvest7', function()
  local _source = source
  PlayersHarvesting7[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Récupération de ~b~Fruits~s~...')
  Harvest7(_source)
end)

RegisterServerEvent('esx_unicorn:stopHarvest7')
AddEventHandler('esx_unicorn:stopHarvest7', function()
  local _source = source
  PlayersHarvesting7[_source] = false
end)

------------ Craft Bières -------------------
local function Craft4(source)

  SetTimeout(4000, function()

    if PlayersCrafting4[source] == true then

      local _source = source
      local xPlayer = ESX.GetPlayerFromId(_source)
      local GazBottleQuantity = xPlayer.getInventoryItem('houblon').count
      if GazBottleQuantity <= 0 then
        TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez de houblon')
      else
                xPlayer.removeInventoryItem('houblon', 4)
                xPlayer.addInventoryItem('beer', 2)

        Craft4(source)
      end
    end
  end)
end

RegisterServerEvent('esx_unicorn:startCraft4')
AddEventHandler('esx_unicorn:startCraft4', function()
  local _source = source
  PlayersCrafting4[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Fabrication de ~b~Bières~s~...')
  Craft4(_source)
end)

RegisterServerEvent('esx_unicorn:stopCraft4')
AddEventHandler('esx_unicorn:stopCraft4', function()
  local _source = source
  PlayersCrafting4[_source] = false
end)

------------ Craft Whisky --------------
local function Craft5(source)

  SetTimeout(4000, function()

    if PlayersCrafting5[source] == true then

      local _source = source
      local xPlayer = ESX.GetPlayerFromId(_source)
      local FixToolQuantity  = xPlayer.getInventoryItem('malte').count
      if FixToolQuantity <= 0 then
        TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez de malte')
      else
                xPlayer.removeInventoryItem('malte', 4)
                xPlayer.addInventoryItem('whisky', 2)

        Craft5(source)
      end
    end
  end)
end

RegisterServerEvent('esx_unicorn:startCraft5')
AddEventHandler('esx_unicorn:startCraft5', function()
  local _source = source
  PlayersCrafting5[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Fabrication de ~b~Whisky~s~...')
  Craft5(_source)
end)

RegisterServerEvent('esx_unicorn:stopCraft5')
AddEventHandler('esx_unicorn:stopCraft5', function()
  local _source = source
  PlayersCrafting5[_source] = false
end)

------------------------- Craft Rhum -------------------------------
local function Craft6(source)

  SetTimeout(4000, function()

    if PlayersCrafting6[source] == true then

      local _source = source
      local xPlayer = ESX.GetPlayerFromId(_source)
      local CaroToolQuantity  = xPlayer.getInventoryItem('sucre').count
            if CaroToolQuantity <= 0 then
        TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez de sucre')
      else
                xPlayer.removeInventoryItem('sucre', 4)
                xPlayer.addInventoryItem('rhum', 2)

        Craft6(source)
      end
    end
  end)
end

RegisterServerEvent('esx_unicorn:startCraft6')
AddEventHandler('esx_unicorn:startCraft6', function()
  local _source = source
  PlayersCrafting6[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Fabrication du ~b~Rhum~s~...')
  Craft6(_source)
end)

RegisterServerEvent('esx_unicorn:stopCraft6')
AddEventHandler('esx_unicorn:stopCraft6', function()
  local _source = source
  PlayersCrafting6[_source] = false
end)

------------------------------ Craft Cocktail --------------------------------
local function Craft7(source)

  SetTimeout(4000, function()

    if PlayersCrafting7[source] == true then

      local _source = source
      local xPlayer = ESX.GetPlayerFromId(_source)
      local CaroToolQuantity  = xPlayer.getInventoryItem('fruits').count
            if CaroToolQuantity <= 0 then
        TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez de fruits')
      else
                xPlayer.removeInventoryItem('fruits', 4)
                xPlayer.addInventoryItem('cocktail', 2)

        Craft7(source)
      end
    end
  end)
end

RegisterServerEvent('esx_unicorn:startCraft7')
AddEventHandler('esx_unicorn:startCraft7', function()
  local _source = source
  PlayersCrafting7[_source] = true
  TriggerClientEvent('esx:showNotification', _source, 'Fabrication de ~b~Cocktail~s~...')
  Craft7(_source)
end)

RegisterServerEvent('esx_unicorn:stopCraft7')
AddEventHandler('esx_unicorn:stopCraft7', function()
  local _source = source
  PlayersCrafting7[_source] = false
end)

----------------ACHAT PNJ---------------
RegisterServerEvent('esx_unicorn:pedBuyAlcool')
AddEventHandler('esx_unicorn:pedBuyAlcool', function()
  
  local _source       = source
  local xPlayer       = ESX.GetPlayerFromId(_source)
  local resellChances = {}
  local alcoolTypeMagic  = math.random(0, 100)
  local chosenAlcool     = nil
  local prices        = nil

  if highPrice then
    prices = Config.AlcoolPricesHigh
  else
    prices = Config.AlcoolPrices
  end

  for k,v in pairs(Config.AlcoolResellChances) do
    table.insert(resellChances, {alcool = k, chance = v})
  end

  table.sort(resellChances, function(a, b)
    return a.chance < b.chance
  end)

  local count = 0

  for i=1, #resellChances, 1 do
    
    count = count + resellChances[i].chance

    if alcoolTypeMagic <= count then
      chosenAlcool = resellChances[i].alcool
      break
    end

  end

  local pricePerUnit = randomFloat(prices[chosenAlcool].min, prices[chosenAlcool].max)
  local quantity     = math.random(Config.AlcoolResellQuantity[chosenAlcool].min, Config.AlcoolResellQuantity[chosenAlcool].max)
  local item         = xPlayer.getInventoryItem(chosenAlcool)

  if item.count > 0 then

    if item.count < quantity then

      local price = math.floor(item.count * pricePerUnit)

      xPlayer.removeInventoryItem(chosenAlcool, item.count)
      xPlayer.addAccountMoney('black_money', price)
      
      TriggerClientEvent('esx:showNotification', _source, 'Vous avez gagné ~g~$' .. price .. '~s~ pour ~y~x' .. item.count .. ' ' .. item.label)
    else

      local price = math.floor(quantity * pricePerUnit)

      xPlayer.removeInventoryItem(chosenAlcool, quantity)
      xPlayer.addAccountMoney('black_money', price)

      TriggerClientEvent('esx:showNotification', _source, 'Vous avez gagné ~g~$' .. price .. '~s~ pour ~y~x' .. quantity .. ' ' .. item.label)
    end

  else
    TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas l\'alcool demandées [' .. item.label .. ']')
  end

end)

RegisterServerEvent('esx_unicorn:pedCallPolice')
AddEventHandler('esx_unicorn:pedCallPolice', function()
  
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  local xPlayers = ESX.GetPlayers()

  for i=1, #xPlayers, 1 do

    local xPlayer2 = ESX.GetPlayerFromId(xPlayers[i])
      
    if xPlayer2.job.name == 'crypted' then
      TriggerClientEvent('esx_cryptedphone:onMessage', xPlayer2.source, '', 'Une personne a essayé de me vendre de l\'alcool', xPlayer.get('coords'), true, 'Alerte Moldu', false)
    end

  end

end)


----------------------------------
---- Ajout Gestion Stock Boss ----
----------------------------------

RegisterServerEvent('esx_unicorn:getStockItem')
AddEventHandler('esx_unicorn:getStockItem', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_unicorn', function(inventory)

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

ESX.RegisterServerCallback('esx_unicorn:getStockItems', function(source, cb)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_unicorn', function(inventory)
    cb(inventory.items)
  end)

end)

-------------
-- AJOUT 2 --
-------------

RegisterServerEvent('esx_unicorn:putStockItems')
AddEventHandler('esx_unicorn:putStockItems', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_unicorn', function(inventory)

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

ESX.RegisterServerCallback('esx_unicorn:putStockItems', function(source, cb)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_unicorn', function(inventory)
    cb(inventory.items)
  end)

end)

ESX.RegisterServerCallback('esx_unicorn:getPlayerInventory', function(source, cb)

  local xPlayer    = ESX.GetPlayerFromId(source)
  local items      = xPlayer.inventory

  cb({
    items      = items
  })

end)

ESX.RegisterServerCallback('esx_unicorn:tryRemoveInventoryItem', function(source, cb, itemName, itemCount)

  local xPlayer = ESX.GetPlayerFromId(source)
  local item    = xPlayer.getInventoryItem(itemName)

  if item.count >= itemCount then
    xPlayer.removeInventoryItem(itemName, itemCount)
    cb(true)
  else
    cb(false)
  end
end)

