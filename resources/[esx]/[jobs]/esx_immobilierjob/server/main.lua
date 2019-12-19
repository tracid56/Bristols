ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
  ESX = obj
end)

TriggerEvent('esx_phone:registerNumber', 'immobilier', _U('client'), false, false)
TriggerEvent('esx_society:registerSociety', 'immobilier', 'Agent immobilier', 'society_immobilier', 'society_immobilier', 'society_immobilier', {type = 'private'})

RegisterServerEvent('esx_immobilierjob:revoke')
AddEventHandler('esx_immobilierjob:revoke', function(property, owner)
  TriggerEvent('esx_property:removeOwnedPropertyIdentifier', property, owner)
end)

RegisterServerEvent('esx_immobilierjob:immobillier')
AddEventHandler('esx_immobilierjob:immobillier', function(result)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	local mess     = result
	--print(text)
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		TriggerClientEvent('esx_breakingnews:immobillier', xPlayers[i],mess)
	end

end)

RegisterServerEvent('esx_immobilierjob:sell')
AddEventHandler('esx_immobilierjob:sell', function(target, property, price)

  local xPlayer = ESX.GetPlayerFromId(target)

  xPlayer.removeMoney(price)

  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_immobilier', function(account)
    account.addMoney(price)
  end)

  TriggerEvent('esx_property:setPropertyOwned', property, price, false, xPlayer.identifier)
end)

RegisterServerEvent('esx_immobilierjob:getStockItem')
AddEventHandler('esx_immobilierjob:getStockItem', function(itemName, count)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_immobilier', function(inventory)

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

ESX.RegisterServerCallback('esx_immobilierjob:getStockItems', function(source, cb)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_immobilier', function(inventory)
    cb(inventory.items)
  end)

end)

RegisterServerEvent('esx_immobilierjob:putStockItems')
AddEventHandler('esx_immobilierjob:putStockItems', function(itemName, count)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_immobilier', function(inventory)

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

ESX.RegisterServerCallback('esx_immobilierjob:getPlayerInventory', function(source, cb)

  local xPlayer    = ESX.GetPlayerFromId(source)
  local items      = xPlayer.inventory
  cb({
    items      = items
  })
end)


RegisterServerEvent('esx_immobilierjob:rent')
AddEventHandler('esx_immobilierjob:rent', function(target, property, price)

  local xPlayer = ESX.GetPlayerFromId(target)

  TriggerEvent('esx_property:setPropertyOwned', property, price, true, xPlayer.identifier)
end)


ESX.RegisterServerCallback('esx_immobilierjob:getCustomers', function(source, cb)

  TriggerEvent('esx_ownedproperty:getOwnedProperties', function(properties)

    local xPlayers  = ESX.GetPlayers()
    local customers = {}

    for i=1, #properties, 1 do
      for j=1, #xPlayers, 1 do

        local xPlayer = ESX.GetPlayerFromId(xPlayers[j])

        if xPlayer.identifier == properties[i].owner then
          table.insert(customers, {
            name           = xPlayer.name,
            propertyOwner  = properties[i].owner,
            propertyRented = properties[i].rented,
            propertyId     = properties[i].id,
            propertyPrice  = properties[i].price,
            propertyName   = properties[i].name
          })
        end
      end
    end

    cb(customers)

  end)

end)