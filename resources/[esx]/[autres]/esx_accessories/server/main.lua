ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--RegisterServerEvent('esx_accessories:pay')
--AddEventHandler('esx_accessories:pay', function()
--    local _source = source
--    local xPlayer = ESX.GetPlayerFromId(_source)
--    xPlayer.removeAccountMoney('bank', Config.Price)
--    TriggerClientEvent('esx:showNotification', _source, _U('you_paid') .. '$' .. Config.Price)
--
--end)

RegisterServerEvent('esx_accessories:save')
AddEventHandler('esx_accessories:save', function(skin, accessory)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    TriggerEvent('esx_datastore:getDataStore', 'user_' .. string.lower(accessory), xPlayer.identifier, function(store)
        
        store.set('has' .. accessory, true)

        local itemSkin = {}
        local item1 = string.lower(accessory) .. '_1'
        local item2 = string.lower(accessory) .. '_2'
        itemSkin[item1] = skin[item1]
        itemSkin[item2] = skin[item2]
        store.set('skin', itemSkin)

    end)

end)

ESX.RegisterServerCallback('esx_accessories:get', function(source, cb, accessory)

    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_datastore:getDataStore', 'user_' .. string.lower(accessory), xPlayer.identifier, function(store)
        
        local hasAccessory = (store.get('has' .. accessory) and store.get('has' .. accessory) or false)
        local skin = (store.get('skin') and store.get('skin') or {})

        cb(hasAccessory, skin)

    end)

end)

--===================================================================
--===================================================================

ESX.RegisterServerCallback('esx_accessories:buy', function(source, cb)
    
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.get('money') >= Config.Price then
        xPlayer.removeMoney(Config.Price)
        TriggerClientEvent('esx:showNotification', source, _U('you_paid') .. '$' .. Config.Price)
        cb(true)
      elseif xPlayer.get('bank') >= Config.Price then
        xPlayer.removeAccountMoney('bank', Config.Price)
        TriggerClientEvent('esx:showNotification', source, _U('you_paid') .. '$' .. Config.Price .. ' avec votre carte bancaire')
        cb(true)
      else
        cb(false)
      end

end)
