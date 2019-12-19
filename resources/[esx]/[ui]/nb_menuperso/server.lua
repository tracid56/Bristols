ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('NB:getUsergroup', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  local group = xPlayer.getGroup()
  cb(group)
end)

function getMaximumGrade(jobname)
    local result = MySQL.Sync.fetchAll("SELECT * FROM job_grades WHERE job_name=@jobname  ORDER BY `grade` DESC ;", {
        ['@jobname'] = jobname
    })
    if result[1] ~= nil then
        return result[1].grade
    end
    return nil
end

RegisterServerEvent('nb_menuperso:staff')
AddEventHandler('nb_menuperso:staff', function(result)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	local mess     = result
	--print(text)
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		TriggerClientEvent('esx_breakingnews:staff', xPlayers[i],mess)
	end

end)
-------------------------------------------------------------------------------Notif Save

RegisterServerEvent("notifsave:diff")
AddEventHandler("notifsave:diff", function()
	local _source = source
	TriggerClientEvent('esx:showNotification', _source, "Votre personnage a été ~b~synchroniser")
end)

-------------------------------------------------------------------------------Admin Menu

RegisterServerEvent("AdminMenu:giveCash")
AddEventHandler("AdminMenu:giveCash", function(money)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local total = money
	
	xPlayer.addMoney((total))
	local item = '$ ~w~d\'argent !'
	local message = 'Tu t\'es octroyer~g~'
	TriggerClientEvent('esx:showNotification', _source, message.." "..total.." "..item)

end)

RegisterServerEvent("AdminMenu:giveBank")
AddEventHandler("AdminMenu:giveBank", function(money)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local total = money
	
	xPlayer.addAccountMoney('bank', total)
	local item = '$ ~w~en banque'
	local message = 'Tu t\'es octroyer~g~'
	TriggerClientEvent('esx:showNotification', _source, message.." "..total.." "..item)

end)

RegisterServerEvent("AdminMenu:giveDirtyMoney")
AddEventHandler("AdminMenu:giveDirtyMoney", function(money)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local total = money
	
	xPlayer.addAccountMoney('black_money', total)
	local item = '$ ~w~d\'argent sale'
	local message = 'Tu t\'es octroyer~r~'
	TriggerClientEvent('esx:showNotification', _source, message.." "..total.." "..item)

end)

-------------------------------------------------------------------------------Grade Menu
RegisterServerEvent('NB:promouvoirplayer')
AddEventHandler('NB:promouvoirplayer', function(target)

	local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local maximumgrade = tonumber(getMaximumGrade(sourceXPlayer.job.name)) -1 

	if(targetXPlayer.job.grade == maximumgrade)then
		TriggerClientEvent('esx:showNotification', _source, "Vous devez demander une autorisation du ~r~Gouvernement~w~.")
	else
		if(sourceXPlayer.job.name == targetXPlayer.job.name)then

			local grade = tonumber(targetXPlayer.job.grade) + 1 
			local job = targetXPlayer.job.name

			targetXPlayer.setJob(job, grade)

			TriggerClientEvent('esx:showNotification', _source, "Vous avez ~g~promu "..targetXPlayer.name.."~w~.")
			TriggerClientEvent('esx:showNotification', target,  "Vous avez été ~g~promu par ".. sourceXPlayer.name.."~w~.")		

		else
			TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")

		end

	end 
		
end)

RegisterServerEvent('NB:destituerplayer')
AddEventHandler('NB:destituerplayer', function(target)

	local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if(targetXPlayer.job.grade == 0)then
		TriggerClientEvent('esx:showNotification', _source, "Vous ne pouvez pas plus ~r~rétrograder~w~ davantage.")
	else
		if(sourceXPlayer.job.name == targetXPlayer.job.name)then

			local grade = tonumber(targetXPlayer.job.grade) - 1 
			local job = targetXPlayer.job.name

			targetXPlayer.setJob(job, grade)

			TriggerClientEvent('esx:showNotification', _source, "Vous avez ~r~rétrogradé "..targetXPlayer.name.."~w~.")
			TriggerClientEvent('esx:showNotification', target,  "Vous avez été ~r~rétrogradé par ".. sourceXPlayer.name.."~w~.")		

		else
			TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")

		end

	end 
		
end)

RegisterServerEvent('NB:recruterplayer')
AddEventHandler('NB:recruterplayer', function(target, job, grade)

	local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	
		targetXPlayer.setJob(job, grade)

		TriggerClientEvent('esx:showNotification', _source, "Vous avez ~g~recruté "..targetXPlayer.name.."~w~.")
		TriggerClientEvent('esx:showNotification', target,  "Vous avez été ~g~embauché par ".. sourceXPlayer.name.."~w~.")		

end)

RegisterServerEvent('NB:virerplayer')
AddEventHandler('NB:virerplayer', function(target)

	local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local job = "unemployed"
	local grade = "0"

	if(sourceXPlayer.job.name == targetXPlayer.job.name)then
		targetXPlayer.setJob(job, grade)

		TriggerClientEvent('esx:showNotification', _source, "Vous avez ~r~viré "..targetXPlayer.name.."~w~.")
		TriggerClientEvent('esx:showNotification', target,  "Vous avez été ~g~viré par ".. sourceXPlayer.name.."~w~.")	
	else

		TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")

	end

end)

RegisterServerEvent('NB:promouvoirplayerfaction')
AddEventHandler('NB:promouvoirplayerfaction', function(target)

	local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local maximumgrade = tonumber(getMaximumGrade(sourceXPlayer.faction.name)) -1 

	if(targetXPlayer.faction.grade == maximumgrade)then
		TriggerClientEvent('esx:showNotification', _source, "Vous devez demander une autorisation du ~r~Gouvernement~w~.")
	else
		if(sourceXPlayer.faction.name == targetXPlayer.faction.name)then

			local grade = tonumber(targetXPlayer.faction.grade) + 1 
			local faction = targetXPlayer.faction.name

			targetXPlayer.setFaction(faction, grade)

			TriggerClientEvent('esx:showNotification', _source, "Vous avez ~g~promu "..targetXPlayer.name.."~w~.")
			TriggerClientEvent('esx:showNotification', target,  "Vous avez été ~g~promu par ".. sourceXPlayer.name.."~w~.")		

		else
			TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")

		end

	end 
		
end)

RegisterServerEvent('NB:destituerplayerfaction')
AddEventHandler('NB:destituerplayerfaction', function(target)

	local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if(targetXPlayer.faction.grade == 0)then
		TriggerClientEvent('esx:showNotification', _source, "Vous ne pouvez pas plus ~r~rétrograder~w~ davantage.")
	else
		if(sourceXPlayer.faction.name == targetXPlayer.faction.name)then

			local grade = tonumber(targetXPlayer.faction.grade) - 1 
			local faction = targetXPlayer.faction.name

			targetXPlayer.setFaction(faction, grade)

			TriggerClientEvent('esx:showNotification', _source, "Vous avez ~r~rétrogradé "..targetXPlayer.name.."~w~.")
			TriggerClientEvent('esx:showNotification', target,  "Vous avez été ~r~rétrogradé par ".. sourceXPlayer.name.."~w~.")		

		else
			TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")

		end

	end 
		
end)

RegisterServerEvent('NB:recruterplayerfaction')
AddEventHandler('NB:recruterplayerfaction', function(target, faction, grade)

	local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	
		targetXPlayer.setFaction(faction, grade)

		TriggerClientEvent('esx:showNotification', _source, "Vous avez ~g~recruté "..targetXPlayer.name.."~w~.")
		TriggerClientEvent('esx:showNotification', target,  "Vous avez été ~g~embauché par ".. sourceXPlayer.name.."~w~.")		

end)

RegisterServerEvent('NB:virerplayerfaction')
AddEventHandler('NB:virerplayerfaction', function(target)

	local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local faction = "resid"
	local grade = "0"

	if(sourceXPlayer.faction.name == targetXPlayer.faction.name)then
		targetXPlayer.setFaction(faction, grade)

		TriggerClientEvent('esx:showNotification', _source, "Vous avez ~r~viré "..targetXPlayer.name.."~w~.")
		TriggerClientEvent('esx:showNotification', target,  "Vous avez été ~g~viré par ".. sourceXPlayer.name.."~w~.")	
	else

		TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")

	end

end)