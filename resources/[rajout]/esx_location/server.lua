ESX                			 = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_location:buy1', function(source, cb)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.get('money') >= 300 then
        xPlayer.removeMoney(300)
        TriggerClientEvent('esx:showNotification', source, 'Vous avez payez 300$ Bonne route !')
        cb(true)
    elseif xPlayer.get('bank') >= 300 then
        xPlayer.removeAccountMoney('bank', 300)
        TriggerClientEvent('esx:showNotification', source, 'Vous avez payez 300$ Bonne route !')
        cb(true)
    else
        -- TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez d\'argent sur vous ni sur votre carte bancaire')
        cb(false)
    end
end)

ESX.RegisterServerCallback('esx_location:buy2', function(source, cb)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.get('money') >= 450 then
        xPlayer.removeMoney(450)
        TriggerClientEvent('esx:showNotification', source, 'Vous avez payez 450$ Bonne route !')
        cb(true)
    elseif xPlayer.get('bank') >= 450 then
        xPlayer.removeAccountMoney('bank', 450)
        TriggerClientEvent('esx:showNotification', source, 'Vous avez payez 450$ Bonne route !')
        cb(true)
    else
        -- TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez d\'argent sur vous ni sur votre carte bancaire')
        cb(false)
    end
end)

ESX.RegisterServerCallback('esx_location:buy3', function(source, cb)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.get('money') >= Config.Price3 then
        xPlayer.removeMoney(Config.Price3)
        TriggerClientEvent('esx:showNotification', source, 'Vous avez payez '..Config.Price3..'$ Bonne route !')
        cb(true)
    elseif xPlayer.get('bank') >= Config.Price3 then
        xPlayer.removeAccountMoney('bank', Config.Price3)
        TriggerClientEvent('esx:showNotification', source, 'Vous avez payez '..Config.Price3..'$ Bonne route !')
        cb(true)
    else
        -- TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez d\'argent sur vous ni sur votre carte bancaire')
        cb(false)
    end
end)

ESX.RegisterServerCallback('esx_location:buy4', function(source, cb)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.get('money') >= Config.Price4 then
        xPlayer.removeMoney(Config.Price4)
        TriggerClientEvent('esx:showNotification', source, 'Vous avez payez '..Config.Price4..'$ Bonne route !')
        cb(true)
    elseif xPlayer.get('bank') >= Config.Price4 then
        xPlayer.removeAccountMoney('bank', Config.Price4)
        TriggerClientEvent('esx:showNotification', source, 'Vous avez payez '..Config.Price4..'$ Bonne route !')
        cb(true)
    else
        -- TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez d\'argent sur vous ni sur votre carte bancaire')
        cb(false)
    end
end)