----------------------------------------------------------------
-- Made By: Guy293
-- GitHub: https://github.com/Guy293
-- Fivem Forum: https://forum.fivem.net/u/guy293/
----------------------------------------------------------------




ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Register server callback for jobs online
ESX.RegisterServerCallback('guy293_getJobsOnline', function(source, cb)

  local xPlayer  = ESX.GetPlayerFromId(source)
  
  local xPlayers = ESX.GetPlayers()

	PoliceConnected = 0
	EMSConnected = 0
	DepanneurConnected = 0
	TaxiConnected = 0
	BanquierConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			PoliceConnected = PoliceConnected + 1
		end	
		if xPlayer.job.name == 'ambulance' then
			EMSConnected = EMSConnected + 1
		end
		if xPlayer.job.name == 'mecano' then
			DepanneurConnected = DepanneurConnected + 1
		end		
		if xPlayer.job.name == 'taxi' then
			TaxiConnected = TaxiConnected + 1
		end
		if xPlayer.job.name == 'banker' then
			BanquierConnected = BanquierConnected + 1
		end
	end
  
  
cb(PoliceConnected, EMSConnected, DepanneurConnected, TaxiConnected, BanquierConnected)

end)