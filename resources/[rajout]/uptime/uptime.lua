Citizen.CreateThread(function()
	local starttick = GetGameTimer()
	while true do
		Citizen.Wait(1000) -- check all 15 seconds
		local tick = GetGameTimer()
		local uptimeDay = math.floor((tick-starttick)/86400000)
        local uptimeHour = math.floor((tick-starttick)/3600000) % 24
		local uptimeMinute = math.floor((tick-starttick)/60000) % 60
		local uptimeSecond = math.floor((tick-starttick)/1000) % 60
		ExecuteCommand(string.format("sets Uptime \"%2d Jours %2d Heures %2d Minutes %2d Seconds\"", uptimeDay, uptimeHour, uptimeMinute, uptimeSecond))
	end
end)