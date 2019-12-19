ESX               = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('cigarette', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local lighter = xPlayer.getInventoryItem('lighter')
	
		if lighter.count > 0 then
			xPlayer.removeInventoryItem('cigarette', 1)
			TriggerClientEvent('esx_cigarett:startSmoke', source)
		    TriggerClientEvent('esx_status:add', source, 'hunger', 150000)
	        TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
		else
			TriggerClientEvent('esx:showNotification', source, ('Vous n\'avez pas de ~r~briquets'))
		end
end)
