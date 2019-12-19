ESX                			 = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_bike:buy1', function(source, cb)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.get('money') >= 89 then
        xPlayer.removeMoney(89)
        TriggerClientEvent('esx:showNotification', source, 'Vous avez payez 89$ Bonne route !')
        cb(true)
    elseif xPlayer.get('bank') >= 89 then
        xPlayer.removeAccountMoney('bank', 89)
        TriggerClientEvent('esx:showNotification', source, 'Vous avez payez 89$ Bonne route !')
        cb(true)
    else
        -- TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez d\'argent sur vous ni sur votre carte bancaire')
        cb(false)
    end
end)

ESX.RegisterServerCallback('esx_bike:buy2', function(source, cb)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.get('money') >= 129 then
        xPlayer.removeMoney(129)
        TriggerClientEvent('esx:showNotification', source, 'Vous avez payez 129$ Bonne route !')
        cb(true)
    elseif xPlayer.get('bank') >= 129 then
        xPlayer.removeAccountMoney('bank', 129)
        TriggerClientEvent('esx:showNotification', source, 'Vous avez payez 129$ Bonne route !')
        cb(true)
    else
        -- TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez d\'argent sur vous ni sur votre carte bancaire')
        cb(false)
    end
end)

ESX.RegisterServerCallback('esx_bike:buy3', function(source, cb)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.get('money') >= 109 then
        xPlayer.removeMoney(109)
        TriggerClientEvent('esx:showNotification', source, 'Vous avez payez 109$ Bonne route !')
        cb(true)
    elseif xPlayer.get('bank') >= 109 then
        xPlayer.removeAccountMoney('bank', 109)
        TriggerClientEvent('esx:showNotification', source, 'Vous avez payez 109$ Bonne route !')
        cb(true)
    else
        -- TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez d\'argent sur vous ni sur votre carte bancaire')
        cb(false)
    end
end)