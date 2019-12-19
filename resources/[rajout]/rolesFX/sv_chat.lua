ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Fondateur = {"steam:110000113892145","steam:110000113101033","steam:11000010fa8f70c","steam:11000011527705c","ip:",}
local Modo = {"steam:11000013563e8b6","steam:110000107930e5b","steam:11000011857d8b5","ip:",}
local Developpeur = {"steam:","ip:",}

AddEventHandler('chatMessage', function(Source, Name, Msg)
    args = stringsplit(Msg, " ")
    CancelEvent()
    if string.find(args[1], "/") then
        local cmd = args[1]
        table.remove(args, 1)
    else    
        local player = GetPlayerIdentifiers(Source)[1]
        local xPlayer = ESX.GetPlayerFromId(Source)
        if has_value(Fondateur, player) then
            TriggerClientEvent('chatMessage', -1, "Chef des babouins | " .. Name, { 255, 0, 0 }, Msg)           
        elseif has_value(Modo, player) then
            TriggerClientEvent('chatMessage', -1, "Modo | " .. Name, { 0, 255, 34 }, Msg)
        elseif has_value(Developpeur, player) then
            TriggerClientEvent('chatMessage', -1, "Staff-dev | " .. Name, { 0, 255, 250 }, Msg)
        -- elseif xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'gouvernement' then
        --     TriggerClientEvent('chatMessage', -1, "Gouvernement | " .. Name, { 253, 64, 122 }, Msg)
        -- elseif xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'police' then
        --     TriggerClientEvent('chatMessage', -1, "LSPD | " .. Name, { 54, 126, 253 }, Msg)
        -- elseif xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'brinks' then
        --     TriggerClientEvent('chatMessage', -1, "Brinks | " .. Name, { 240, 143, 46 }, Msg)
        -- elseif xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'pompier' then
        --     TriggerClientEvent('chatMessage', -1, "LSFD | " .. Name, { 255, 97, 57 }, Msg)
        -- elseif xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'securite' then
        --     TriggerClientEvent('chatMessage', -1, "Securité | " .. Name, { 196, 96, 96 }, Msg)
        -- elseif xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'ambulance' then
        --     TriggerClientEvent('chatMessage', -1, "EMS | " .. Name, { 253, 104, 225 }, Msg)
        -- elseif xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'immobillier' then
        --     TriggerClientEvent('chatMessage', -1, "Agent Immobilier | " .. Name, { 84, 154, 235 }, Msg)
        -- elseif xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'concessionnaire' then
        --     TriggerClientEvent('chatMessage', -1, "Concessionnaire | " .. Name, { 194, 211, 130 }, Msg)
        -- elseif xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'depanneur' then
        --     TriggerClientEvent('chatMessage', -1, "Dépanneur  | " .. Name, { 145, 144, 144 }, Msg)
        -- elseif xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'taxi' then
        --     TriggerClientEvent('chatMessage', -1, "Chauffeur de Taxi | " .. Name, { 255, 247, 0 }, Msg)
        -- elseif xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'chauffeur' then
        --     TriggerClientEvent('chatMessage', -1, "Chauffeur Routier | " .. Name, { 245, 203, 154 }, Msg)
        -- elseif xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'unicorn' then
        --     TriggerClientEvent('chatMessage', -1, "Unicorn | " .. Name, { 0, 255, 51 }, Msg)
        -- elseif xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'banquier' then
        --     TriggerClientEvent('chatMessage', -1, "Banquier | " .. Name, { 250, 132, 0 }, Msg)
        -- elseif xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'journaliste' then
        --     TriggerClientEvent('chatMessage', -1, "Journaliste | " .. Name, { 59, 111, 3 }, Msg)
        -- elseif xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'vigneron' then
        --     TriggerClientEvent('chatMessage', -1, "Vigneron | " .. Name, { 255, 0, 255 }, Msg)
        -- elseif xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'bahamas' then
        --     TriggerClientEvent('chatMessage', -1, "Bahamas | " .. Name, { 140, 196, 197 }, Msg)
        -- elseif xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'brasseur' then
        --     TriggerClientEvent('chatMessage', -1, "Brasseur | " .. Name, { 245, 243, 140 }, Msg)
        -- elseif xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'tabac' then
        --     TriggerClientEvent('chatMessage', -1, "Tabac | " .. Name, { 145, 84, 39 }, Msg)
        else
            TriggerClientEvent('chatMessage', -1, "" .. Name, { 85, 207, 91 }, Msg)
        end
            
    end
end)

function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end