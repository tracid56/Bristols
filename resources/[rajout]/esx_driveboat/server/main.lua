ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('esx_driveboat:loadLicenses', source, licenses)
	end)
end)

RegisterNetEvent('esx_driveboat:addLicense')
AddEventHandler('esx_driveboat:addLicense', function(type)
	local _source = source

	TriggerEvent('esx_license:addLicense', _source, type, function()
		TriggerEvent('esx_license:getLicenses', _source, function(licenses)
			TriggerClientEvent('esx_driveboat:loadLicenses', _source, licenses)
		end)
	end)
end)

ESX.RegisterServerCallback('esx_driveboat:paytheory', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  local pricetheory = Config.Prices['dmv_boat']

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

ESX.RegisterServerCallback('esx_driveboat:paydriveboat', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  local pricedriveboat = Config.Prices['drive_boat']

  if xPlayer.get('money') >= pricedriveboat then
    xPlayer.removeMoney(pricedriveboat)
    TriggerClientEvent('esx:showNotification', source, _U('you_paid', pricedriveboat))
    cb(true)
  elseif xPlayer.get('bank') >= pricedriveboat then
    xPlayer.removeAccountMoney('bank', pricedriveboat)
    TriggerClientEvent('esx:showNotification', source, _U('you_paid', pricedriveboat))
    cb(true)
  else
    cb(false)
  end
end)