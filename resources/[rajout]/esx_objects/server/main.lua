ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) 
	ESX = obj 
end)


--------------------------
--------HACKPHONE---------
--------------------------
ESX.RegisterUsableItem('hackphone', function(source)

	TriggerClientEvent('esx_useitem:hackphone', source)

end)

--------------------------
---------JOURNAL----------
--------------------------

ESX.RegisterUsableItem('journal', function(source)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

  xPlayer.removeInventoryItem('journal', 1)

  TriggerClientEvent('affiche:display', _source, true)
  TriggerClientEvent('esx:showNotification', _source, "Vous êtes en train de lire le journal.")
  TriggerClientEvent('getDisclaimerStatus', _source, true)
  TriggerClientEvent('anim:Play', _source, 'cop:clipboard')
end)

--------------------------
---------JUMELLES---------
--------------------------

ESX.RegisterUsableItem('jumelles', function(source) -- Consider the item as usable

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent('jumelles:Active', source) --Trigger the event when the player is using the item

end)

--------------------------
----------BALLON----------
--------------------------

ESX.RegisterUsableItem('ball', function(source)
	TriggerClientEvent('esx_items:ball', source)
end)


--------------------------
-----------BANG-----------
--------------------------

ESX.RegisterUsableItem('bong', function(source)
	TriggerClientEvent('esx_items:bong', source)
end)

RegisterServerEvent('esx_items:bong')
AddEventHandler('esx_items:bong', function()

	local xPlayer  = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bong', 1)
	TriggerClientEvent('esx_status:add', source, 'drunk', 250000)

end)

--------------------------
-----------BANG-----------
--------------------------

ESX.RegisterUsableItem('rose', function(source)
	
		TriggerClientEvent('esx_items:rose', source)
	
end)


--------------------------
----------NOTEPAD---------
--------------------------

ESX.RegisterUsableItem('notepad', function(source)
	
		TriggerClientEvent('esx_items:notepad', source)
	
end)
	

--------------------------
--------PARAPLUIE---------
--------------------------

ESX.RegisterUsableItem('parapluie', function(source)
	TriggerClientEvent('esx_items:parapluie', source)
end)


--------------------------
-------PAREBALLE50--------
--------------------------

ESX.RegisterUsableItem('bullet1', function(source)
	TriggerClientEvent('esx_items:bullet1', source)

	local xPlayer  = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bullet1', 1)
end)

--------------------------
-------PAREBALLE75--------
--------------------------

ESX.RegisterUsableItem('bullet2', function(source)
	TriggerClientEvent('esx_items:bullet2', source)

	local xPlayer  = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bullet2', 1)
end)

--------------------------
------PAREBALLE100--------
--------------------------

ESX.RegisterUsableItem('bullet3', function(source)
	TriggerClientEvent('esx_items:bullet3', source)

	local xPlayer  = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bullet3', 1)
end)

--------------------------
-------PAREBALLE200-------
--------------------------

ESX.RegisterUsableItem('bullet4', function(source)
	TriggerClientEvent('esx_items:bullet4', source)

	local xPlayer  = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bullet4', 1)
end)

--HAZMAT NOIRE--
ESX.RegisterUsableItem('hazmat1', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
        TriggerClientEvent('esx_objects:settenuehaz1', _source)
end)

--HAZMAT BLEUE--
ESX.RegisterUsableItem('hazmat2', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
        TriggerClientEvent('esx_objects:settenuehaz2', _source)
end)

--HAZMAT BREAKINGBAD--
ESX.RegisterUsableItem('hazmat3', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
        TriggerClientEvent('esx_objects:settenuehaz3', _source)
end)

--HAZMAT BLANCHE--
ESX.RegisterUsableItem('hazmat4', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
        TriggerClientEvent('esx_objects:settenuehaz4', _source)
end)

--CASA PAPEL--
ESX.RegisterUsableItem('casapapel', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
        TriggerClientEvent('esx_objects:settenuecasa', _source)
end)

--TENUE KARTING--
ESX.RegisterUsableItem('karting1', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
        TriggerClientEvent('esx_objects:settenuekarting1', _source)
end)

--TENUE KARTING--
ESX.RegisterUsableItem('karting2', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
        TriggerClientEvent('esx_objects:settenuekarting2', _source)
end)


--TENUE SKYDIVING--
ESX.RegisterUsableItem('skydiving', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
        TriggerClientEvent('esx_objects:settenueskydivingcl', _source)
end)

--TENUE PRISON--
ESX.RegisterUsableItem('prisonnier', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
        TriggerClientEvent('esx_objects:settenuejailer', _source)
end)


--TENUE PLONGEE--
ESX.RegisterUsableItem('swim', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
        TriggerClientEvent('esx_objects:settenueswim', _source)
end)

--CARTES--
ESX.RegisterUsableItem('identity', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent('esx_cards:show', source, 'showItentity')
end)

ESX.RegisterUsableItem('job', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent('esx_cards:show', source, 'showItentity')
end)

ESX.RegisterUsableItem('drive', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent('esx_cards:show', source, 'driverlicence')
end)

ESX.RegisterUsableItem('drive_bike', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent('esx_cards:show', source, 'driverlicence')
end)

ESX.RegisterUsableItem('drive_truck', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent('esx_cards:show', source, 'driverlicence')
end)

-- Register Usable splif
ESX.RegisterUsableItem('splif', function(source)

	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('splif', 1)

	TriggerClientEvent('bl_Advanceddrugs:onPot', _source)
	TriggerClientEvent('esx_status:remove', source, 'hunger', 300000) 
	TriggerClientEvent('esx_status:remove', source, 'thirst', 200000)	
    TriggerClientEvent('esx:showNotification', _source, 'Vous avez fumez un Spliff')

end)

-- Register Usable coke
ESX.RegisterUsableItem('coke', function(source)

	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('coke', 1)

	TriggerClientEvent('bl_Advanceddrugs:onPot', _source)
    TriggerClientEvent('esx:showNotification', _source, _U('used_one_coke'))

end)

-- Register Usable sedatif
ESX.RegisterUsableItem('sedatif', function(source)

	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('sedatif', 1)

	TriggerClientEvent('bl_Advanceddrugs:onPotSed', _source)
    TriggerClientEvent('esx:showNotification', _source, _U('used_one_sedatif'))

end)

-- Register Usable huilecanna
ESX.RegisterUsableItem('huile_pooch', function(source)

	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('huile_pooch', 1)

	TriggerClientEvent('bl_Advanceddrugs:onPot', _source)
	TriggerClientEvent('esx_ambulancejob:heal', source, 'big')
	TriggerClientEvent('esx_status:remove', source, 'hunger', 400000) 
	TriggerClientEvent('esx_status:remove', source, 'thirst', 300000)
    TriggerClientEvent('esx:showNotification', _source, 'Vous avez pris des gouttes d\'huile de Canna')

end)

-- Register Usable Meth
ESX.RegisterUsableItem('meth_pooch', function(source)

	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('meth_pooch', 1)

	TriggerClientEvent('bl_Advanceddrugs:onPot', _source)
    TriggerClientEvent('esx:showNotification', _source, _U('used_one_meth'))

end)