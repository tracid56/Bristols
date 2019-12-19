ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_plasticsurgery:pay')
AddEventHandler('esx_plasticsurgery:pay', function()

	local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.get('money') >= Config.Price then
      xPlayer.removeMoney(Config.Price)
      TriggerClientEvent('esx:showNotification', source, _U('you_paid') .. '$' .. Config.Price)
    elseif xPlayer.get('bank') >= Config.Price then
      xPlayer.removeAccountMoney('bank', Config.Price)
      TriggerClientEvent('esx:showNotification', source, _U('you_paid') .. '$' .. Config.Price)
    else
      TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez pas assez d\'argent sur vous ni sur votre carte bancaire')
    end

end)

ESX.RegisterServerCallback('esx_plasticsurgery:checkMoney', function(source, cb)

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
