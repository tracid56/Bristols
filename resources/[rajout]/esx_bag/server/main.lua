ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('bag', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem('bag', 1)
    
    TriggerClientEvent('esx-kr-bag:CheckBag', source, HasBag)
    if not HasBag then
        TriggerEvent('esx-kr-bag:InsertBag', source)
    else
        TriggerClientEvent('esx:showNotification', source, _U('already_bag'))
    end
end)

ESX.RegisterServerCallback('esx-kr-bag:getPlayerInventory', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local items   = xPlayer.inventory

    cb({items = items})
 end)

ESX.RegisterServerCallback('esx-kr-bag:getBag', function(source, cb)
    local src = source
    local identifier = ESX.GetPlayerFromId(source).identifier

        MySQL.Async.fetchAll('SELECT * FROM owned_bags WHERE identifier = @identifier ',{["@identifier"] = identifier}, function(bag)

            if bag[1] ~= nil then
                MySQL.Async.fetchAll('SELECT * FROM owned_bag_inventory WHERE id = @id ',{["@id"] = bag[1].id}, function(inventory)
                cb({bag = bag, inventory = inventory})
                end)
            else
                cb(nil)
            end
    end)
end)

ESX.RegisterServerCallback('esx-kr-bag:getAllBags', function(source, cb)
    local src = source

    MySQL.Async.fetchAll('SELECT * FROM owned_bags', {}, function(bags)
       
        if bags[1] ~= nil then
            cb(bags)
        else
            cb(nil)
        end
    end)
end)


ESX.RegisterServerCallback('esx-kr-bag:getBagInventory', function(source, cb, BagId)
    local src = source
    local identifier = ESX.GetPlayerFromId(src).identifier

        MySQL.Async.fetchAll('SELECT * FROM owned_bag_inventory WHERE id = @id ',{["@id"] = BagId}, function(bag)
        cb(bag)
    end)
end)

RegisterServerEvent('esx-kr-bag:InsertBag')
AddEventHandler('esx-kr-bag:InsertBag', function(source)
    local src = source
    local identifier = ESX.GetPlayerFromId(src).identifier
    local xPlayer = ESX.GetPlayerFromId(src)
    local xPlayers = ESX.GetPlayers()

    TriggerClientEvent('esx-kr-bag:GiveBag', src)
    for i=1, #xPlayers, 1 do
        TriggerClientEvent('esx-kr-bag:ReSync', xPlayers[i], id)
     end
    MySQL.Async.execute('INSERT INTO owned_bags (identifier, id, x, y, z) VALUES (@identifier, @id, @x, @y, @z)', {['@identifier'] = identifier,['@id']  = math.random(1, 100000), ['@x']  = nil, ['@y'] = nil, ['@y'] = nil})
end)

RegisterServerEvent('esx-kr-bag:TakeItem')
AddEventHandler('esx-kr-bag:TakeItem', function(id, item, count, type)

    local src = source
    local identifier = ESX.GetPlayerFromId(src).identifier
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll('SELECT * FROM owned_bags WHERE id = @id ',{["@id"] = id}, function(bag)
    MySQL.Async.fetchAll('SELECT * FROM owned_bag_inventory WHERE id = @id AND item = @item ',{["@id"] = id, ["@item"] = item}, function(result)

			if result[1] ~= nil then
				if type == 'weapon' then
					xPlayer.addWeapon(item, count)
				elseif type == 'item' then
					if result[1].count >= count then
						xPlayer.addInventoryItem(item, count)
					else
						TriggerClientEvent('esx:showNotification', src, _U('pick_toomuch'))
						return
					end
				end
				MySQL.Async.execute('UPDATE owned_bags SET itemcount = @itemcount WHERE id = @id', {['@id'] = id, ['@itemcount'] = bag[1].itemcount - 1})    
				if (result[1].count - count) >= 0 then
					if (result[1].count - count) == 0 then
						MySQL.Async.execute('DELETE FROM owned_bag_inventory WHERE id = @id AND item = @item AND count = @count',{['@id'] = id,['@item'] = item, ['@count'] = count})
					else
						MySQL.Async.execute('UPDATE owned_bag_inventory SET count = @count WHERE id = @id AND item = @item', {['@id'] = id,['@item'] = item, ['@count'] = result[1].count - count})
					end
				else
					TriggerClientEvent('esx:showNotification', src, _U('pick_toomuch'))
					return
				end
			end
        end)
    end)
end)

RegisterServerEvent('esx-kr-bag:PutItem')
AddEventHandler('esx-kr-bag:PutItem', function(id, item, label, count, type)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier = ESX.GetPlayerFromId(src).identifier
	local update
	local count2 = count
    local insert
    local xItem = xPlayer.getInventoryItem(item)
	
	
    MySQL.Async.fetchAll('SELECT * FROM owned_bags WHERE identifier = @identifier ',{["@identifier"] = identifier}, function(bag)
		if xItem.count >= count then
			if bag[1].itemcount < Config.MaxItemCount then
				if count2 <= Config.MaxPerItem then
					if type == 'weapon' then
						xPlayer.removeWeapon(item, count)
						MySQL.Async.execute('UPDATE owned_bags SET itemcount = @itemcount WHERE identifier = @identifier', {['@identifier'] = identifier, ['@itemcount'] = bag[1].itemcount + 1})
						MySQL.Async.execute('INSERT INTO owned_bag_inventory (id, label, item, count) VALUES (@id, @label, @item, @count)', {['@id'] = id,['@item']  = item, ['@label']  = label, ['@count'] = count})
					elseif type == 'item' then
						MySQL.Async.fetchAll('SELECT * FROM owned_bag_inventory WHERE id = @id ',{["@id"] = id}, function(result)
							if result[1] ~= nil then
								for i=1, #result, 1 do
									if result[i].item == item then
										count = count + result[i].count
										update = 1
									elseif result[i].item ~= item then
										insert = 1
									end
								end
								if update == 1 then
									if count <= Config.MaxPerItem then
										MySQL.Async.execute('UPDATE owned_bag_inventory SET count = @count WHERE item = @item', {['@item'] = item, ['@count'] = count})
										xPlayer.removeInventoryItem(item, count2)
									else
										TriggerClientEvent('esx:showNotification', src, _U('too_much', Config.MaxPerItem))
										return
									end
								elseif insert == 1 then
									if count2 <= Config.MaxPerItem then
										MySQL.Async.execute('UPDATE owned_bags SET itemcount = @itemcount WHERE identifier = @identifier', {['@identifier'] = identifier, ['@itemcount'] = bag[1].itemcount + 1})
										MySQL.Async.execute('INSERT INTO owned_bag_inventory (id, label, item, count) VALUES (@id, @label, @item, @count)', {['@id'] = id,['@item']  = item, ['@label']  = label, ['@count'] = count})
										xPlayer.removeInventoryItem(item, count2)
									else
										TriggerClientEvent('esx:showNotification', src, _U('too_much', Config.MaxPerItem))
										return
									end
								end
							else
								MySQL.Async.execute('UPDATE owned_bags SET itemcount = @itemcount WHERE identifier = @identifier', {['@identifier'] = identifier, ['@itemcount'] = bag[1].itemcount + 1})
								MySQL.Async.execute('INSERT INTO owned_bag_inventory (id, label, item, count) VALUES (@id, @label, @item, @count)', {['@id'] = id,['@item']  = item, ['@label']  = label, ['@count'] = count})
								xPlayer.removeInventoryItem(item, count2)
							end
						end)
					end
				else
					TriggerClientEvent('esx:showNotification', src, _U('too_much', Config.MaxPerItem))
				end
			else
				TriggerClientEvent('esx:showNotification', src, _U('bag_maxitem',Config.MaxItemCount))
			end
		else
			TriggerClientEvent('esx:showNotification', src, _U('pick_toomuch'))
		end
    end)
end)

RegisterServerEvent('esx-kr-bag:PickUpBag')
AddEventHandler('esx-kr-bag:PickUpBag', function(id)
    local src = source
    local identifier = ESX.GetPlayerFromId(src).identifier

    MySQL.Async.fetchAll('UPDATE owned_bags SET identifier = @identifier, x = @x, y = @y, z = @z WHERE id = @id', {['@identifier'] = identifier, ['@id'] = id, ['@x'] = nil, ['@y'] = nil, ['@z'] = nil})

        local xPlayers = ESX.GetPlayers()

     for i=1, #xPlayers, 1 do
        TriggerClientEvent('esx-kr-bag:SetOntoPlayer', src, id)
		TriggerClientEvent('esx:showNotification', src, _U('bag_access'))
        TriggerClientEvent('esx-kr-bag:ReSync', xPlayers[i], id)
     end
end)

RegisterServerEvent('esx-kr-bag:DropBag')
AddEventHandler('esx-kr-bag:DropBag', function(id, x, y, z)
    local src = source
    local identifier = ESX.GetPlayerFromId(src).identifier

    MySQL.Async.fetchAll('UPDATE owned_bags SET identifier = @identifier, x = @x, y = @y, z = @z WHERE id = @id', {['@identifier'] = nil, ['@id'] = id, ['@x'] = x, ['@y'] = y, ['@z'] = z})

        local xPlayers = ESX.GetPlayers()
        
    for i=1, #xPlayers, 1 do
        TriggerClientEvent('esx-kr-bag:ReSync', xPlayers[i], id)
    end
end)
