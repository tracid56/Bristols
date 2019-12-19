Citizen.CreateThread(function()
    local notif = false
    
    while true do
        Citizen.Wait(300000)
        notif = true
        if notif then
            TriggerServerEvent('notifsave:diff')
        end
        notif = false
    end
end)

-- PlayerOnlineTime = 0
-- Citizen.CreateThread(function()
-- 	while true do
-- 		Wait(60000)  -- One minute (NOTE: Do keep in mind that this isn't a very accurate method though but just an example! :) )
-- 		PlayerOnlineTime = PlayerOnlineTime + 1
--         if PlayerOnlineTime == 60 then
--             exports.XNLRankBar:Exp_XNL_AddPlayerXP(500) -- Give the player 500XP when the hour has been reached
--             TriggerServerEvent('maj:rank', 500)
-- 			PlayerOnlineTime = 0 -- Reset the 'hour timer'
-- 		end
-- 	end
-- end)