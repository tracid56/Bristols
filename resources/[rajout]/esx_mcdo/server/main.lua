ESX                      = nil
local ItemsLabels        = {}
local ItemLabelsLicenses = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('onMySQLReady', function()

	MySQL.Async.fetchAll(
		'SELECT * FROM items',
		{},
		function(result)

			for i=1, #result, 1 do
				ItemsLabels[result[i].name] = result[i].label
			end

		end
	)

	TriggerEvent('esx_license:getLicensesList', function(licenses)
		for i=1, #licenses, 1 do
			ItemLabelsLicenses[licenses[i].type] = licenses[i].label
		end
	end)

end)

RegisterServerEvent('esx_mcdo:buyItem')
AddEventHandler('esx_mcdo:buyItem', function(itemType, itemName, price)

    local _source         = source
    local xPlayer         = ESX.GetPlayerFromId(source)

    if xPlayer.get('money') >= price then
		xPlayer.removeMoney(price)
		xPlayer.addInventoryItem(itemName, 1)
		TriggerClientEvent('esx:showNotification', _source, 'Vous avez acheté ~b~1x ' .. ItemsLabels[itemName])
	elseif xPlayer.get('bank') >= price then
		xPlayer.removeAccountMoney('bank', price)
		xPlayer.addInventoryItem(itemName, 1)
		TriggerClientEvent('esx:showNotification', _source, 'Vous avez acheté ~b~1x ' .. ItemsLabels[itemName].. ' ~w~avec votre carte bancaire')
    else
        TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez d\'argent sur vous ni sur votre carte bancaire')
    end

end)


ESX.RegisterServerCallback('esx_mcdo:requestDBItems', function(source, cb)

	MySQL.Async.fetchAll(
		'SELECT * FROM drive',
		{},
		function(result)

			local shopItems  = {}

			for i=1, #result, 1 do

				if shopItems[result[i].name] == nil then
					shopItems[result[i].name] = {}
				end

				local label = nil

				if result[i].type == 'item_standard' then
					label = ItemsLabels[result[i].item]
				elseif result[i].type == 'item_license' then
					label = ItemLabelsLicenses[result[i].item]
				end

				table.insert(shopItems[result[i].name], {
					name  = result[i].item,
					price = result[i].price,
					label = label,
					type  = result[i].type
				})

			end

			cb(shopItems)

		end
	)

end)