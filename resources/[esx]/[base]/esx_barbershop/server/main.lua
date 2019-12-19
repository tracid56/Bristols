ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_barbershop:buy', function(source, cb)

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
