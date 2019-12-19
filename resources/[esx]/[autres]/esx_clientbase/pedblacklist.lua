-- CONFIG --

-- Blacklisted ped models
pedblacklist = {
	"FIREMAN",
	"GANG_1",
	"GANG_2",
	"GANG_9",
	"GANG_10",
	"AMBIENT_GANG_LOST",
	"AMBIENT_GANG_MEXICAN",
	"AMBIENT_GANG_MEXICAN",
	"AMBIENT_GANG_BALLAS",
	"AMBIENT_GANG_CULT",
	"AMBIENT_GANG_SALVA",
	"AMBIENT_GANG_WEICHENG",
	"AMBIENT_GANG_HILLBILLY",
	"DEALER",
	"MEDIC",
	"SPECIAL",
	"GUARD_DOG",
	"COP",
}

-- Defaults to this ped model if an error happened
defaultpedmodel = "a_m_y_skater_01"

-- CODE --

Citizen.CreateThread(function()
	while true do
		Wait(1)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			playerModel = GetEntityModel(playerPed)

			if not prevPlayerModel then
				if isPedBlacklisted(prevPlayerModel) then
					SetPlayerModel(PlayerId(), GetHashKey(defaultpedmodel))
				else
					prevPlayerModel = playerModel
				end
			else
				if isPedBlacklisted(playerModel) then
					SetPlayerModel(PlayerId(), prevPlayerModel)
					sendForbiddenMessage("Ce ped est en Blacklist!")
				end

				prevPlayerModel = playerModel
			end
		end
	end
end)

function isPedBlacklisted(model)
	for _, blacklistedPed in pairs(pedblacklist) do
		if model == GetHashKey(blacklistedPed) then
			return true
		end
	end

	return false
end