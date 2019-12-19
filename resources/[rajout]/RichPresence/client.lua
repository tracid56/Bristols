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
		SetDiscordAppId(651839862051176448)
		SetDiscordRichPresenceAsset('flashback')
		SetDiscordRichPresenceAssetText("FlashBack !")
		SetDiscordRichPresenceAssetSmall('discord')
		SetDiscordRichPresenceAssetSmallText("https://discord.gg...")
		SetRichPresence("🪐 Joueurs - ".. GetPlayerName(PlayerId()) .." [ID:"..id.."] - ".. #players .. "/64")
	end
end)