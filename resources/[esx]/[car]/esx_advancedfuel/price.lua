ESX              = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
fuelCost = 150

RegisterServerEvent('frfuel:fuelAdded')
AddEventHandler('frfuel:fuelAdded', function(amount)
TriggerEvent('es:getPlayerFromId', source, function(xPlayer)--ESX
if (xPlayer) then
    TriggerClientEvent('chatMessage', source, "Essence", {255, 0, 0}, "Le prix de l'essence est de " .. fuelCost) --FR
    --TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "The price of gasoline is" .. fuelCost) -- EN

    litres = math.random(1, 10)
    TriggerClientEvent('chatMessage', source, "Essence", {255, 0, 0}, "votre plein est de " .. litres .. " litres d'essence") --FR
    --TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Your full is " .. round(amount) .. " Liters of gasoline") --EN

    if litres == 1 then
        TriggerClientEvent('chatMessage', source, "Essence", {255, 0, 0}, "Le plein vous a coûté 150$") --FR
        local xPlayer     = ESX.GetPlayerFromId(source)
        if xPlayer.get('money') >= 150 then
            xPlayer.removeMoney(150)
        elseif xPlayer.get('bank') >= 150 then
            xPlayer.removeAccountMoney('bank', 150)
        else
            TriggerClientEvent('chatMessage', source, "Essence", {255, 0, 0}, "Vous n'avez pas assez d'argent ")
        end
    elseif litres == 2 then
        TriggerClientEvent('chatMessage', source, "Essence", {255, 0, 0}, "Le plein vous a coûté 60$") --FR
        local xPlayer     = ESX.GetPlayerFromId(source)
        if xPlayer.get('money') >= 60 then
            xPlayer.removeMoney(60)
        elseif xPlayer.get('bank') >= 60 then
            xPlayer.removeAccountMoney('bank', 60)
        else
            TriggerClientEvent('chatMessage', source, "Essence", {255, 0, 0}, "Vous n'avez pas assez d'argent ")
        end
    elseif litres == 3 then
        TriggerClientEvent('chatMessage', source, "Essence", {255, 0, 0}, "Le plein vous a coûté 90$") --FR
        local xPlayer     = ESX.GetPlayerFromId(source)
        if xPlayer.get('money') >= 90 then
            xPlayer.removeMoney(90)
        elseif xPlayer.get('bank') >= 90 then
            xPlayer.removeAccountMoney('bank', 90)
        else
            TriggerClientEvent('chatMessage', source, "Essence", {255, 0, 0}, "Vous n'avez pas assez d'argent ")
        end
    elseif litres == 4 then
        TriggerClientEvent('chatMessage', source, "Essence", {255, 0, 0}, "Le plein vous a coûté 120$") --FR
        local xPlayer     = ESX.GetPlayerFromId(source)
        if xPlayer.get('money') >= 120 then
            xPlayer.removeMoney(120)
        elseif xPlayer.get('bank') >= 120 then
            xPlayer.removeAccountMoney('bank', 120)
        else
            TriggerClientEvent('chatMessage', source, "Essence", {255, 0, 0}, "Vous n'avez pas assez d'argent ")
        end
    elseif litres == 5 then
        TriggerClientEvent('chatMessage', source, "Essence", {255, 0, 0}, "Le plein vous a coûté 150$") --FR
        local xPlayer     = ESX.GetPlayerFromId(source)
        if xPlayer.get('money') >= 150 then
            xPlayer.removeMoney(150)
        elseif xPlayer.get('bank') >= 150 then
            xPlayer.removeAccountMoney('bank', 150)
        else
            TriggerClientEvent('chatMessage', source, "Essence", {255, 0, 0}, "Vous n'avez pas assez d'argent ")
        end
    elseif litres == 150 then
        TriggerClientEvent('chatMessage', source, "Essence", {255, 0, 0}, "Le plein vous a coûté 180$") --FR
        local xPlayer     = ESX.GetPlayerFromId(source)
        if xPlayer.get('money') >= 180 then
            xPlayer.removeMoney(180)
        elseif xPlayer.get('bank') >= 180 then
            xPlayer.removeAccountMoney('bank', 180)
        else
            TriggerClientEvent('chatMessage', source, "Essence", {255, 0, 0}, "Vous n'avez pas assez d'argent ")
        end
    elseif litres == 7 then
        TriggerClientEvent('chatMessage', source, "Essence", {255, 0, 0}, "Le plein vous a coûté 210$") --FR
        local xPlayer     = ESX.GetPlayerFromId(source)
        if xPlayer.get('money') >= 210 then
            xPlayer.removeMoney(210)
        elseif xPlayer.get('bank') >= 210 then
            xPlayer.removeAccountMoney('bank', 210)
        else
            TriggerClientEvent('chatMessage', source, "Essence", {255, 0, 0}, "Vous n'avez pas assez d'argent ")
        end
    elseif litres == 8 then
        TriggerClientEvent('chatMessage', source, "Essence", {255, 0, 0}, "Le plein vous a coûté 240$") --FR
        local xPlayer     = ESX.GetPlayerFromId(source)
        if xPlayer.get('money') >= 240 then
            xPlayer.removeMoney(240)
        elseif xPlayer.get('bank') >= 240 then
            xPlayer.removeAccountMoney('bank', 240)
        else
            TriggerClientEvent('chatMessage', source, "Essence", {255, 0, 0}, "Vous n'avez pas assez d'argent ")
        end
    elseif litres == 9 then
        TriggerClientEvent('chatMessage', source, "Essence", {255, 0, 0}, "Le plein vous a coûté 270$") --FR
        local xPlayer     = ESX.GetPlayerFromId(source)
        if xPlayer.get('money') >= 270 then
            xPlayer.removeMoney(270)
        elseif xPlayer.get('bank') >= 270 then
            xPlayer.removeAccountMoney('bank', 270)
        else
            TriggerClientEvent('chatMessage', source, "Essence", {255, 0, 0}, "Vous n'avez pas assez d'argent ")
        end
    elseif litres == 10 then
        TriggerClientEvent('chatMessage', source, "Essence", {255, 0, 0}, "Le plein vous a coûté 300$") --FR
        local xPlayer     = ESX.GetPlayerFromId(source)
        if xPlayer.get('money') >= 300 then
            xPlayer.removeMoney(300)
        elseif xPlayer.get('bank') >= 300 then
            xPlayer.removeAccountMoney('bank', 300)
        else
            TriggerClientEvent('chatMessage', source, "Essence", {255, 0, 0}, "Vous n'avez pas assez d'argent ")
        end
    end
end

end)
end)

function round(num, numDecimalPlaces)
    local mult = 5^(numDecimalPlaces or 0)
    return math.random(1, 10)
end