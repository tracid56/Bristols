RegisterServerEvent("restart:checkreboot")

AddEventHandler('restart:checkreboot', function()
	date_local = os.date('%H:%M:%S', os.time())
	if date_local == '05:30:00' then
		TriggerClientEvent('chatMessage', -1, "Bristols RP !", {255, 0, 0}, "Le serveur reboot dans 30 minutes !")
	elseif date_local == '05:45:00' then
		TriggerClientEvent('chatMessage', -1, "Bristols RP !", {255, 0, 0}, "Le serveur reboot dans 15 minutes !")
	elseif date_local == '05:55:00' then
		TriggerClientEvent('chatMessage', -1, "Bristols RP !", {255, 0, 0}, "Le serveur reboot dans 5 minutes ! Pensez a vous déconnecter sinon vous aurez un rollback")
	elseif date_local == '05:59:35' then
		TriggerClientEvent('chatMessage', -1, "Bristols RP !", {255, 0, 0}, "Le serveur reboot dans quelques instant ! Déconnecter vous !!")
	end
end)

AddEventHandler('restart:checkreboot', function()
	date_local = os.date('%H:%M:%S', os.time())
	if date_local == '11:30:00' then
		TriggerClientEvent('chatMessage', -1, "Bristols RP !", {255, 0, 0}, "Le serveur reboot dans 30 minutes !")
	elseif date_local == '11:45:00' then
		TriggerClientEvent('chatMessage', -1, "Bristols RP !", {255, 0, 0}, "Le serveur reboot dans 15 minutes !")
	elseif date_local == '11:55:00' then
		TriggerClientEvent('chatMessage', -1, "Bristols RP !", {255, 0, 0}, "Le serveur reboot dans 5 minutes ! Pensez a vous déconnecter sinon vous aurez un rollback")
	elseif date_local == '11:59:35' then
		TriggerClientEvent('chatMessage', -1, "Bristols RP !", {255, 0, 0}, "Le serveur reboot dans quelques instant ! Déconnecter vous !!")
	end
end)

AddEventHandler('restart:checkreboot', function()
	date_local = os.date('%H:%M:%S', os.time())
	if date_local == '23:30:00' then
		TriggerClientEvent('chatMessage', -1, "Bristols RP !", {255, 0, 0}, "Le serveur reboot dans 30 minutes !")
	elseif date_local == '23:45:00' then
		TriggerClientEvent('chatMessage', -1, "Bristols RP !", {255, 0, 0}, "Le serveur reboot dans 15 minutes !")
	elseif date_local == '23:55:00' then
		TriggerClientEvent('chatMessage', -1, "Bristols RP !", {255, 0, 0}, "Le serveur reboot dans 5 minutes ! Pensez a vous déconnecter sinon vous aurez un rollback")
	elseif date_local == '23:59:35' then
		TriggerClientEvent('chatMessage', -1, "Bristols RP !", {255, 0, 0}, "Le serveur reboot dans quelques instant ! Déconnecter vous !!")
	end
end)

function restart_server()
	SetTimeout(1000, function()
		TriggerEvent('restart:checkreboot')
		restart_server()
	end)
end

restart_server()

RegisterServerEvent("kickreboot")
AddEventHandler("kickreboot", function()
	date_local = os.date('%H:%M:%S', os.time())
	if date_local == '05:59:50' then
		DropPlayer(source, "Toutes les scène RP ont automatiquement pris fin et votre progression a été enregistrée")
	end
	if date_local == '11:59:50' then
		DropPlayer(source, "Toutes les scène RP ont automatiquement pris fin et votre progression a été enregistrée")
	end
	-- if date_local == '16:14:50' then
	-- 	DropPlayer(source, "Toutes les scène RP ont automatiquement pris fin et votre progression a été enregistrée")
	-- end
	if date_local == '23:59:50' then
		DropPlayer(source, "Toutes les scène RP ont automatiquement pris fin et votre progression a été enregistrée")
	end
end)