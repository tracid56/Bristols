ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('esx_driveavion:loadLicenses', source, licenses)
	end)
end)

RegisterNetEvent('esx_driveavion:addLicense')
AddEventHandler('esx_driveavion:addLicense', function(type)
	local _source = source

	TriggerEvent('esx_license:addLicense', _source, type, function()
		TriggerEvent('esx_license:getLicenses', _source, function(licenses)
			TriggerClientEvent('esx_driveavion:loadLicenses', _source, licenses)
		end)
	end)
end)

ESX.RegisterServerCallback('esx_driveavion:paytheory', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  local pricetheory = Config.Prices['dmv_air']

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

ESX.RegisterServerCallback('esx_driveavion:paydriveavion', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  local pricedriveavion = Config.Prices['drive_avion']

  if xPlayer.get('money') >= pricedriveavion then
    xPlayer.removeMoney(pricedriveavion)
    TriggerClientEvent('esx:showNotification', source, _U('you_paid', pricedriveavion))
    cb(true)
  elseif xPlayer.get('bank') >= pricedriveavion then
    xPlayer.removeAccountMoney('bank', pricedriveavion)
    TriggerClientEvent('esx:showNotification', source, _U('you_paid', pricedriveavion))
    cb(true)
  else
    cb(false)
  end
end)

ESX.RegisterServerCallback('esx_driveavion:paydriveheli', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  local pricedriveheli = Config.Prices['drive_heli']

  if xPlayer.get('money') >= pricedriveheli then
    xPlayer.removeMoney(pricedriveheli)
    TriggerClientEvent('esx:showNotification', source, _U('you_paid', pricedriveheli))
    cb(true)
  elseif xPlayer.get('bank') >= pricedriveheli then
    xPlayer.removeAccountMoney('bank', pricedriveheli)
    TriggerClientEvent('esx:showNotification', source, _U('you_paid', pricedriveheli))
    cb(true)
  else
    cb(false)
  end
end)
