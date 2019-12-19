-----------------------
-- Lucifer
-- Copyrighted © Lucifer 2018
-- Do not redistribute or edit in any way without my permission.
-----------------------

peacetime = false

RegisterCommand('pvp', function(source)
    peacetime = false
    TriggerClientEvent("isPeacetime", -1, peacetime)
    TriggerClientEvent('chatMessage', source, 'Bristols !', {255, 255, 255}, "PVP Activé")
end)

RegisterCommand('nopvp', function(source)
    peacetime = true
    TriggerClientEvent("isPeacetime", -1, peacetime)
    TriggerClientEvent('chatMessage', source, 'Bristols !', {255, 255, 255}, "PVP Désactiver")
end)
