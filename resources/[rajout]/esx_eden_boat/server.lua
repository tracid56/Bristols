ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


--Recupere les véhicules
ESX.RegisterServerCallback('eden_garage_boat:getVehicles', function(source, cb, KindOfVehicle)
	local _source = source
	local vehicules = {}
	local identifier = ""
	if KindOfVehicle ~= "personal" then
		identifier = KindOfVehicle
	else
		identifier = GetPlayerIdentifiers(_source)[1]
	end

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles_boat WHERE owner=@identifier",{['@identifier'] = identifier}, function(data) 
		for _,v in pairs(data) do
			table.insert(vehicules, {vehicle = v.vehicle, state = v.state, fourrieremecano = v.fourrieremecano, plate = v.plate, vehiclename = v.vehiclename})
		end
		cb(vehicules)
	end)
end)
-- Fin --Recupere les véhicules$

--Recupere les véhicules
ESX.RegisterServerCallback('eden_garage_boat:getVehiclesMecano', function(source, cb)
	local _source = source
	local vehicules = {}

	MySQL.Async.fetchAll("select * from owned_vehicles_boat inner join characters on owned_vehicles_boat.owner = characters.identifier where fourrieremecano=@fourrieremecano",{['@fourrieremecano'] = true}, function(data) 
		for _,v in pairs(data) do
			table.insert(vehicules, {vehicle = v.vehicle, state = v.state, fourrieremecano = v.fourrieremecano, firstname = v.firstname, lastname = v.lastname, plate = v.plate})
		end
		cb(vehicules)
	end)
end)
-- Fin --Recupere les véhicules

--Stock les véhicules
ESX.RegisterServerCallback('eden_garage_boat:stockv',function(source,cb, vehicleProps, KindOfVehicle)
	local identifier = ""
	local _source = source
	if KindOfVehicle ~= "personal" then
		identifier = KindOfVehicle
	else
		identifier = GetPlayerIdentifiers(_source)[1]
	end
	local vehplate = vehicleProps.plate:match("^%s*(.-)%s*$")
	local vehiclemodel = vehicleProps.model
	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles_boat where plate=@plate and owner=@identifier",{['@plate'] = vehplate, ['@identifier'] = identifier}, function(result)  
		if result[1] ~= nil then
			local vehprop = json.encode(vehicleProps)
			local originalvehprops = json.decode(result[1].vehicle)
			if originalvehprops.model == vehiclemodel then
				MySQL.Sync.execute("UPDATE owned_vehicles_boat SET vehicle =@vehprop WHERE plate=@plate",{['@vehprop'] = vehprop, ['@plate'] = vehplate})
				cb(true)
			else
				DropPlayer(_source, "Tu es kick du serveur, voilà ce qu'il se passe quand on essaye de cheater.")
				print("[esx_eden_garage_boat] player "..identifier..' tried to spawn a vehicle with hash:'..vehiclemodel..". his original vehicle: "..originalvehprops.model)
				cb(false)
			end
		else
			cb(false)
		end
	end)
end)
--Fin stock les vehicules

ESX.RegisterServerCallback('eden_garage_boat:stockvmecano',function(source,cb, vehicleProps)
	local _source = source
	local plate = vehicleProps.plate:match("^%s*(.-)%s*$")
	local vehiclemodel = vehicleProps.model
	local identifier = GetPlayerIdentifiers(_source)[1]
	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles_boat where plate=@plate",{['@plate'] = plate}, function(result) 
		if result[1] ~= nil then
			local vehprop = json.encode(vehicleProps)
			local originalvehprops = json.decode(result[1].vehicle)
			if originalvehprops.model == vehiclemodel then
				MySQL.Sync.execute("UPDATE owned_vehicles_boat SET vehicle =@vehprop WHERE plate=@plate",{['@vehprop'] = vehprop, ['@plate'] = plate})
				cb(true)
			else
				DropPlayer(_source, "Tu es kick du serveur, voilà ce qu'il se passe quand on essaye de cheater.")
				print("[esx_eden_garage_boat] player "..identifier..' tried to spawn a vehicle with hash:'..vehiclemodel..". his original vehicle: "..originalvehprops.model)
				cb(false)
			end
		else
			cb(false)
		end
	end)
end)

--Change le state du véhicule
RegisterServerEvent('eden_garage_boat:modifystate')
AddEventHandler('eden_garage_boat:modifystate', function(plate, state)
	MySQL.Sync.execute("UPDATE owned_vehicles_boat SET state =@state WHERE plate=@plate",{['@state'] = state , ['@plate'] = plate:match("^%s*(.-)%s*$")})
end)	
--Fin change le state du véhicule

RegisterServerEvent('eden_garage_boat:ChangeStateFromFourriereMecano')
AddEventHandler('eden_garage_boat:ChangeStateFromFourriereMecano', function(vehicleProps, fourrieremecano)
	local _source = source
	local vehicleplate = vehicleProps.plate:match("^%s*(.-)%s*$")
	local fourrieremecano = fourrieremecano
	
	MySQL.Sync.execute("UPDATE owned_vehicles_boat SET fourrieremecano =@fourrieremecano WHERE plate=@plate",{['@fourrieremecano'] = fourrieremecano , ['@plate'] = vehicleplate})
end)


RegisterServerEvent('eden_garage_boat:renamevehicle')
AddEventHandler('eden_garage_boat:renamevehicle', function(vehicleplate, name)
	MySQL.Sync.execute("UPDATE owned_vehicles_boat SET vehiclename =@vehiclename WHERE plate=@plate",{['@vehiclename'] = name , ['@plate'] = vehicleplate:match("^%s*(.-)%s*$")})
end)

ESX.RegisterServerCallback('eden_garage_boat:getOutVehicles',function(source, cb, KindOfVehicle)	
	local _source = source
	local vehicules = {}
	local identifier = ""
	if KindOfVehicle ~= "personal" then
		identifier = KindOfVehicle
	else
		identifier = GetPlayerIdentifiers(_source)[1]
	end

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles_boat WHERE owner=@identifier AND (state=false OR fourrieremecano=true)",{['@identifier'] = identifier}, function(data) 
		for _,v in pairs(data) do
			table.insert(vehicules, {vehicle = v.vehicle, fourrieremecano = v.fourrieremecano, vehiclename =  v.vehiclename})
		end
		cb(vehicules)
	end)
end)

--Foonction qui check l'argent
ESX.RegisterServerCallback('eden_garage_boat:buy', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local societyAccount = nil

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_police', function(account)
		societyAccount = account
	end)

  if xPlayer.get('money') >= Config.Price then
		xPlayer.removeMoney(Config.Price)
		societyAccount.addMoney(Config.Price)
    cb(true)
  elseif xPlayer.get('bank') >= Config.Price then
		xPlayer.removeAccountMoney('bank', Config.Price)
		societyAccount.addMoney(Config.Price)
    cb(true)
  else
    cb(false)
  end

end)
--Fin Foonction qui check l'argent

-- Fonction qui change les etats sorti en rentré lors d'un restart
-- AddEventHandler('onMySQLReady', function()

	-- MySQL.Sync.execute("UPDATE owned_vehicles_boat SET state=true WHERE state=false", {})

-- end)
-- Fin Fonction qui change les etats sorti en rentré lors d'un restart

function dump(o, nb)
  if nb == nil then
    nb = 0
  end
   if type(o) == 'table' then
      local s = ''
      for i = 1, nb + 1, 1 do
        s = s .. "    "
      end
      s = '{\n'
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
          for i = 1, nb, 1 do
            s = s .. "    "
          end
         s = s .. '['..k..'] = ' .. dump(v, nb + 1) .. ',\n'
      end
      for i = 1, nb, 1 do
        s = s .. "    "
      end
      return s .. '}'
   else
      return tostring(o)
   end
end