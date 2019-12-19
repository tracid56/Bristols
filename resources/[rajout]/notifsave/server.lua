ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('onMySQLReady', function ()
    -- Startup code using mysql
end)

AddEventHandler('esx:playerLoaded', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT `rank` FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
        -- print(result[1].rank)
        rankbd = result[1].rank
    end)
    
    Wait(0)
    TriggerClientEvent('maj:richpresence', _source , rankbd)
    TriggerClientEvent('XNL_NET:XNL_SetInitialXPLevels', source, rankbd, true, true)
end)

RegisterServerEvent('maj:rank')
AddEventHandler('maj:rank', function(rank)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll('SELECT `rank` FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
    }, function(result)
        rankbd = result[1].rank
        rankbd = rankbd + rank

        MySQL.Async.execute('UPDATE users SET rank = @rank WHERE identifier = @identifier', {
            ['@rank']     = rankbd,
            ['@identifier'] = xPlayer.identifier
        })
    end)

    -- TriggerEvent('maj:rank2')
end)

RegisterServerEvent('maj:rank2')
AddEventHandler('maj:rank2', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT `rank` FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
        -- print(result[1].rank)
        rankbd = result[1].rank
    end)
    
    Wait(0)
    TriggerClientEvent('maj:richpresence', _source , rankbd)
end)