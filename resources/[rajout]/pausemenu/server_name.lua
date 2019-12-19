function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey('ADD_TEXT_ENTRY'), key, value)
end

Citizen.CreateThread(function()
	while true do
		local id = GetPlayerServerId(PlayerId())
		Citizen.Wait(1500)
		players = {}
		for i = 0, 65 do
			if NetworkIsPlayerActive( i ) then
				table.insert( players, i )
			end
		end
		AddTextEntry('FE_THDR_GTAO', '[~b~F~r~R~w~] ~r~Bristols ! ~w~| ~b~'.. GetPlayerName(PlayerId()) ..' ~w~[~b~ID:'..id..'~w~] ~r~'.. #players .. '/64 ~w~')
	end
end)
