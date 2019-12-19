ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('esx_dmvschool:loadLicenses', source, licenses)
	end)
end)

RegisterServerEvent('esx_dmvschool:addLicense')
AddEventHandler('esx_dmvschool:addLicense', function(type)
	local _source = source

	TriggerEvent('esx_license:addLicense', _source, type, function()
		TriggerEvent('esx_license:getLicenses', _source, function(licenses)
			TriggerClientEvent('esx_dmvschool:loadLicenses', _source, licenses)
		end)
	end)
end)

ESX.RegisterServerCallback('esx_dmvschool:paytheory', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  local pricetheory = Config.Prices['dmv']

  if xPlayer.get('money') >= pricetheory then
    xPlayer.removeMoney(pricetheory)
    TriggerClientEvent('esx:showNotification', source, _U('you_paid', pricetheory))
    cb(true)
  elseif xPlayer.get('bank') >= pricetheory then
    xPlayer.removeAccountMoney('bank', pricetheory)
    TriggerClientEvent('esx:showNotification', source, _U('you_paid', pricetheory))
    cb(true)
  else
    cb(false)
  end
end)

ESX.RegisterServerCallback('esx_dmvschool:paydrive', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  local pricedrive = Config.Prices['drive']

  if xPlayer.get('money') >= pricedrive then
    xPlayer.removeMoney(pricedrive)
    TriggerClientEvent('esx:showNotification', source, _U('you_paid', pricedrive))
    cb(true)
  elseif xPlayer.get('bank') >= pricedrive then
    xPlayer.removeAccountMoney('bank', pricedrive)
    TriggerClientEvent('esx:showNotification', source, _U('you_paid', pricedrive))
    cb(true)
  else
    cb(false)
  end
end)

ESX.RegisterServerCallback('esx_dmvschool:paydrivebike', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  local pricedrivebike = Config.Prices['drive_bike']

  if xPlayer.get('money') >= pricedrivebike then
    xPlayer.removeMoney(pricedrivebike)
    TriggerClientEvent('esx:showNotification', source, _U('you_paid', pricedrivebike))
    cb(true)
  elseif xPlayer.get('bank') >= pricedrivebike then
    xPlayer.removeAccountMoney('bank', pricedrivebike)
    TriggerClientEvent('esx:showNotification', source, _U('you_paid', pricedrivebike))
    cb(true)
  else
    cb(false)
  end
end)

ESX.RegisterServerCallback('esx_dmvschool:paydrivetruck', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  local pricedrivetruck = Config.Prices['drive_truck']

  if xPlayer.get('money') >= pricedrivetruck then
    xPlayer.removeMoney(pricedrivetruck)
    TriggerClientEvent('esx:showNotification', source, _U('you_paid', pricedrivetruck))
    cb(true)
  elseif xPlayer.get('bank') >= pricedrivetruck then
    xPlayer.removeAccountMoney('bank', pricedrivetruck)
    TriggerClientEvent('esx:showNotification', source, _U('you_paid', pricedrivetruck))
    cb(true)
  else
    cb(false)
  end
end)
