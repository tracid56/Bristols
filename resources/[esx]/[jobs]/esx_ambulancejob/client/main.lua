local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX                             = nil
local GUI                       = {}
GUI.Time                        = 0
local PlayerData                = {}
local FirstSpawn                = true
local IsDead                    = false
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local RespawnToHospitalMenu     = nil
local OnJob                     = false
local CurrentCustomer           = nil
local CurrentCustomerBlip       = nil
local DestinationBlip           = nil
local IsNearCustomer            = false
local CustomerIsEnteringVehicle = false
local CustomerEnteredVehicle    = false
local TargetCoords              = nil
local Blips                     = {}
locksound = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1)
	end
end)

function Message()
	Citizen.CreateThread(function()
    while messagenotfinish do
    		Citizen.Wait(1)

			DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 30)
		    while (UpdateOnscreenKeyboard() == 0) do
		        DisableAllControlActions(0);
		       Citizen.Wait(1)
		    end
		    if (GetOnscreenKeyboardResult()) then
		        local result = GetOnscreenKeyboardResult()
		        messagenotfinish = false
		       TriggerServerEvent('esx_ambulancejob:annonce',result)
		        
		    end


		end
	end)
	
end

function SetVehicleMaxMods(vehicle)

  local props = {
    modEngine       = 2,
    modBrakes       = 2,
    modTransmission = 2,
    modSuspension   = 3,
    modTurbo        = true,
  }

  ESX.Game.SetVehicleProperties(vehicle, props)

end

function DrawSub(msg, time)
  ClearPrints()
  SetTextEntry_2("STRING")
  AddTextComponentString(msg)
  DrawSubtitleTimed(time, 1)
end

function ShowLoadingPromt(msg, time, type)
  Citizen.CreateThread(function()
    Citizen.Wait(1)
    N_0xaba17d7ce615adbf("STRING")
    AddTextComponentString(msg)
    N_0xbd12f8228410d9b4(type)
    Citizen.Wait(time)
    N_0x10d373323e5b9c0d()
  end)
end

function GetRandomWalkingNPC()

  local search = {}
  local peds   = ESX.Game.GetPeds()

  for i=1, #peds, 1 do
    if IsPedHuman(peds[i]) and IsPedWalking(peds[i]) and not IsPedAPlayer(peds[i]) then
      table.insert(search, peds[i])
    end
  end

  if #search > 0 then
    return search[GetRandomIntInRange(1, #search)]
  end

  print('Using fallback code to find walking ped')

  for i=1, 250, 1 do

    local ped = GetRandomPedAtCoord(0.0,  0.0,  0.0,  math.huge + 0.0,  math.huge + 0.0,  math.huge + 0.0,  26)

    if DoesEntityExist(ped) and IsPedHuman(ped) and IsPedWalking(ped) and not IsPedAPlayer(ped) then
      table.insert(search, ped)
    end

  end

  if #search > 0 then
    return search[GetRandomIntInRange(1, #search)]
  end

end

function ClearCurrentMission()

  if DoesBlipExist(CurrentCustomerBlip) then
    RemoveBlip(CurrentCustomerBlip)
  end

  if DoesBlipExist(DestinationBlip) then
    RemoveBlip(DestinationBlip)
  end

  CurrentCustomer           = nil
  CurrentCustomerBlip       = nil
  DestinationBlip           = nil
  IsNearCustomer            = false
  CustomerIsEnteringVehicle = false
  CustomerEnteredVehicle    = false
  TargetCoords              = nil

end

function StartAmbulanceJob()

  ShowLoadingPromt(_U('taking_service') .. 'Ambulance', 5000, 0)
  ClearCurrentMission()

  OnJob = true

end

function StopAmbulanceJob()

  local playerPed = GetPlayerPed(-1)

  if IsPedInAnyVehicle(playerPed, false) and CurrentCustomer ~= nil then
    local vehicle = GetVehiclePedIsIn(playerPed,  false)
    TaskLeaveVehicle(CurrentCustomer,  vehicle,  0)

    if CustomerEnteredVehicle then
      TaskGoStraightToCoord(CurrentCustomer,  TargetCoords.x,  TargetCoords.y,  TargetCoords.z,  1.0,  -1,  0.0,  0.0)
    end

  end

  ClearCurrentMission()

  OnJob = false

  DrawSub(_U('mission_complete'), 5000)

end

function RespawnPed(ped, coords)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, coords.heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z, coords.heading)
	ClearPedBloodDamage(ped)
	if RespawnToHospitalMenu ~= nil then
		RespawnToHospitalMenu.close()
		RespawnToHospitalMenu = nil
	end
	ESX.UI.Menu.CloseAll()
end

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(_type)
    local playerPed = GetPlayerPed(-1)
    local maxHealth = GetEntityMaxHealth(playerPed)
    if _type == 'big' then
        SetEntityHealth(playerPed, maxHealth)
    end
    ESX.ShowNotification(_U('healed'))
end)

RegisterNetEvent('esx_ambulancejob:heal2')
AddEventHandler('esx_ambulancejob:heal2', function(_type)
    local playerPed = GetPlayerPed(-1)
    local maxHealth = GetEntityMaxHealth(playerPed)
    if _type == 'other' then
				SetEntityHealth(playerPed, 200)
    end
end)

function StartRespawnToHospitalMenuTimer()

	ESX.SetTimeout(Config.MenuRespawnToHospitalDelay, function()

		if IsDead then

			local elements = {}

			table.insert(elements, {label = _U('yes'), value = 'yes'})

			RespawnToHospitalMenu = ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'menuName',
				{
					css = 'valider',
					title = _U('respawn_at_hospital'),
					align = 'top-left',
					elements = elements
				},
		        function(data, menu) --Submit Cb

		        	menu.close()

		         	Citizen.CreateThread(function()

						DoScreenFadeOut(800)

						while not IsScreenFadedOut() do
							Citizen.Wait(1)
						end

						ESX.TriggerServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function()

							ESX.SetPlayerData('lastPosition', Config.Zones.HospitalInteriorInside1.Pos)
							ESX.SetPlayerData('loadout', {})
							TriggerServerEvent('esx:updateLastPosition', Config.Zones.HospitalInteriorInside1.Pos)

							RespawnPed(GetPlayerPed(-1), Config.Zones.HospitalInteriorInside1.Pos)
							StopScreenEffect('DeathFailOut')
							DoScreenFadeIn(800)
						end)
					end)
		        end,
		        function(data, menu) --Cancel Cb
		                --menu.close()
		        end,
		        function(data, menu) --Change Cb
		                --print(data.current.value)
		        end,
		        function(data, menu) --Close Cb
		            RespawnToHospitalMenu = nil
		        end
			)
		end
	end)
end

function StartRespawnTimer()

	ESX.SetTimeout(Config.RespawnDelayAfterRPDeath, function()

		if IsDead then

			Citizen.CreateThread(function()

				DoScreenFadeOut(800)

				while not IsScreenFadedOut() do
					Citizen.Wait(1)
				end

				ESX.TriggerServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function()

					ESX.SetPlayerData('lastPosition', Config.Zones.HospitalInteriorInside1.Pos)
					ESX.SetPlayerData('loadout', {})
					TriggerServerEvent('esx:updateLastPosition', Config.Zones.HospitalInteriorInside1.Pos)

					RespawnPed(GetPlayerPed(-1), Config.Zones.HospitalInteriorInside1.Pos)
					StopScreenEffect('DeathFailOut')
					DoScreenFadeIn(800)
					TriggerClientEvent('shakeCam', _source, false)

					
				end)
			end)
		end
	end)
end

function RespawnTimer()

	local timer = Config.RespawnDelayAfterRPDeath
	local allowRespawn = Config.RespawnDelayAfterRPDeath/2
	local enoughMoney = false
	local money = 0

	if IsDead and Config.ShowDeathTimer then
		ESX.TriggerServerCallback('esx_ambulancejob:getBankMoney', function(money)
			if money >= Config.EarlyRespawnFineAmount then
				enoughMoney = true
			else
				enoughMoney = false
			end
		end)
		Citizen.CreateThread(function()

			while timer > 0 and IsDead do
				raw_seconds = timer/1000
				raw_minutes = raw_seconds/60
				minutes = stringsplit(raw_minutes, ".")[1]
				seconds = stringsplit(raw_seconds-(minutes*60), ".")[1]

				if Config.EarlyRespawn and Config.EarlyRespawnFine and enoughMoney then
					SetTextFont(4)
					SetTextProportional(0)
					SetTextScale(0.0, 0.5)
					SetTextColour(255, 255, 255, 255)
					SetTextDropshadow(0, 0, 0, 0, 255)
					SetTextEdge(1, 0, 0, 0, 255)
					SetTextDropShadow()
					SetTextOutline()
					SetTextEntry("STRING")
					AddTextComponentString(_U('please_wait') .. minutes .. _U('minutes') .. seconds .. _U('seconds_fine') .. Config.EarlyRespawnFineAmount .. _U('press_respawn_fine'))
					SetTextCentre(true)
					DrawText(0.5, 0.8)
					timer = timer - 15
					Citizen.Wait(1)
					if IsControlPressed(0,  Keys['E']) then
						DoScreenFadeOut(800)

						while not IsScreenFadedOut() do
							Citizen.Wait(1)
						end

						ESX.TriggerServerCallback('esx_ambulancejob:removeItemsAfterRPDeathRemoveMoney', function()
							TriggerServerEvent('esx_ambulancejob:removeAccountMoney', source)
							ESX.SetPlayerData('lastPosition', Config.Zones.HospitalInteriorInside1.Pos)
							ESX.SetPlayerData('loadout', {})
							TriggerServerEvent('esx:updateLastPosition', Config.Zones.HospitalInteriorInside1.Pos)

							RespawnPed(GetPlayerPed(-1), Config.Zones.HospitalInteriorInside1.Pos)
							StopScreenEffect('DeathFailOut')
							DoScreenFadeIn(800)
							TriggerEvent('shakeCam', true)
						end)
					end
				else
					SetTextFont(4)
					SetTextProportional(0)
					SetTextScale(0.0, 0.5)
					SetTextColour(255, 255, 255, 255)
					SetTextDropshadow(0, 0, 0, 0, 255)
					SetTextEdge(1, 0, 0, 0, 255)
					SetTextDropShadow()
					SetTextOutline()
					SetTextEntry("STRING")
					AddTextComponentString(_U('please_wait') .. minutes .. _U('minutes') .. seconds .. _U('seconds'))
					SetTextCentre(true)
					DrawText(0.5, 0.8)
					timer = timer - 15
					Citizen.Wait(1)
				end
			end

			while timer <= 0 and IsDead do
				SetTextFont(4)
				SetTextProportional(0)
				SetTextScale(0.0, 0.5)
				SetTextColour(255, 255, 255, 255)
				SetTextDropshadow(0, 0, 0, 0, 255)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextDropShadow()
				SetTextOutline()
				SetTextEntry("STRING")
				AddTextComponentString(_U('press_respawn'))
				SetTextCentre(true)
				DrawText(0.5, 0.8)
				Citizen.Wait(1)
				if IsControlPressed(0,  Keys['E']) then
					DoScreenFadeOut(800)

					while not IsScreenFadedOut() do
						Citizen.Wait(1)
					end

					ESX.TriggerServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function()

						ESX.SetPlayerData('lastPosition', Config.Zones.HospitalInteriorInside1.Pos)
						ESX.SetPlayerData('loadout', {})
						TriggerServerEvent('esx:updateLastPosition', Config.Zones.HospitalInteriorInside1.Pos)

						RespawnPed(GetPlayerPed(-1), Config.Zones.HospitalInteriorInside1.Pos)
						StopScreenEffect('DeathFailOut')
						DoScreenFadeIn(800)
						TriggerEvent('shakeCam', true)
					end)
				end
			end
		end)
	end
end

--------Ajout effet lors du revive-----
local time = 0
local shakeEnable = false

RegisterNetEvent('shakeCam')
AddEventHandler('shakeCam', function(status)
	if(status == true)then
		ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 1.0)
		shakeEnable = true
	elseif(status == false)then
		ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 0)
		shakeEnable = false
		time = 0
	end
end)

-----Enable/disable the effect by pills
Citizen.CreateThread(function()
	while true do 
		Wait(100)
		if(shakeEnable)then
			time = time + 100
			if(time > 20000)then -- 20 seconds
				TriggerEvent('shakeCam', false)
			end
		end
	end
end)

function OnPlayerDeath()
    IsDead = true
    if Config.ShowDeathTimer == true then
        ShowTimer()
    end
    StartRespawnTimer()
    if Config.RespawnToHospitalMenuTimer == true then
        StartRespawnToHospitalMenuTimer()
    end
    StartScreenEffect('DeathFailOut',  0,  false)
end

function TeleportFadeEffect(entity, coords)

	Citizen.CreateThread(function()

		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(1)
		end

		ESX.Game.Teleport(entity, coords, function()
			DoScreenFadeIn(800)
		end)

	end)

end

function WarpPedInClosestVehicle(ped)

	local coords = GetEntityCoords(ped)

  local vehicle, distance = ESX.Game.GetClosestVehicle({
  	x = coords.x,
  	y = coords.y,
  	z = coords.z
  })

  if distance ~= -1 and distance <= 5.0 then

  	local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
  	local freeSeat = nil

  	for i=maxSeats - 1, 0, -1 do
  		if IsVehicleSeatFree(vehicle,  i) then
  			freeSeat = i
  			break
  		end
  	end

  	if freeSeat ~= nil then
  		TaskWarpPedIntoVehicle(ped,  vehicle,  freeSeat)
  	end

  else
  	ESX.ShowNotification(_U('no_vehicles'))
  end

end

function OpenAmbulanceActionsMenu()

	local elements = {
		{label = _U('cloakroom'), value = 'cloakroom'},
		{label = _U('deposit_stock'), value = 'put_stock'},
    	{label = _U('withdraw_stock'), value = 'get_stock'}
	}

	if Config.EnablePlayerManagement and PlayerData.job.grade_name == 'boss' then
  	table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'ambulance_actions',
		{
			css = 'ambulance',
			title    = _U('ambulance'),
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'cloakroom' then
				OpenCloakroomMenu()
			end
			
	        if data.current.value == 'put_stock' then
	            OpenPutStocksMenu()
	        end

	        if data.current.value == 'get_stock' then
	        	OpenGetStocksMenu()
	        end			

			if data.current.value == 'boss_actions' then
				TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
					menu.close()
				end, {wash = false})
			end

		end,
		function(data, menu)

			menu.close()

			CurrentAction     = 'ambulance_actions_menu'
			CurrentActionMsg  = _U('open_menu')
			CurrentActionData = {}

		end
	)

end

function OpenAmbulanceHarvestMenu()

  if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.grade_name ~= 'ambulance' then
    local elements = {
      {label = _U('gas_can'), value = 'defibrilateur'},
      {label = _U('repair_tools'), value = 'dopamine'},
      --{label = _U('body_work_tools'), value = 'caro_tool'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'ambulance_harvest',
      {
				css = 'ambulance',
        title    = _U('harvest'),
        elements = elements
      },
      function(data, menu)

        if data.current.value == 'defibrilateur' then
          menu.close()
          TriggerServerEvent('esx_ambulancejob:startHarvest')
        end

        if data.current.value == 'dopamine' then
          menu.close()
          TriggerServerEvent('esx_ambulancejob:startHarvest2')
        end        

      end,
      function(data, menu)
        menu.close()
        CurrentAction     = 'ambulance_harvest_menu'
        CurrentActionMsg  = _U('harvest_menu')
        CurrentActionData = {}
      end
    )
  else
    ESX.ShowNotification(_U('not_experienced_enough'))
  end
end

function OpenAmbulanceCraftMenu()
  if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.grade_name ~= 'ambulance' then

    local elements = {
      {label = _U('blowtorch'), value = 'medkit'},
      {label = _U('repair_kit'), value = 'adrenaline'},
      --{label = _U('body_kit'), value = 'caro_kit'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'ambulance_craft',
      {
				css = 'ambulance',
        title    = _U('craft'),
        elements = elements
      },
      function(data, menu)
        if data.current.value == 'medkit' then
          menu.close()
          TriggerServerEvent('esx_ambulancejob:startCraft')
        end

        if data.current.value == 'adrenaline' then
          menu.close()
          TriggerServerEvent('esx_ambulancejob:startCraft2')
        end

      end,
      function(data, menu)
        menu.close()
        CurrentAction     = 'ambulance_craft_menu'
        CurrentActionMsg  = _U('craft_menu')
        CurrentActionData = {}
      end
    )
  else
    ESX.ShowNotification(_U('not_experienced_enough'))
  end
end

function OpenGetStocksMenu()

  ESX.TriggerServerCallback('esx_ambulancejob:getStockItems', function(items)

    print(json.encode(items))

    local elements = {}

    for i=1, #items, 1 do

      local item = items[i]

      if item.count > 0 then
        table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
      end

    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'stocks_menu',
      {
				css = 'ambulance',
        title    = _U('ambulance_stock'),
        elements = elements
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
          {
						css = 'ambulance',
            title = _U('quantity')
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('invalid_quantity'))
            else
              menu2.close()
              menu.close()
              OpenGetStocksMenu()

              TriggerServerEvent('esx_ambulancejob:getStockItem', itemName, count)
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenPutStocksMenu()

ESX.TriggerServerCallback('esx_ambulancejob:getPlayerInventory', function(inventory)

    local elements = {}

    for i=1, #inventory.items, 1 do

      local item = inventory.items[i]

      if item.count > 0 then
        table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
      end

    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'stocks_menu',
      {
				css = 'ambulance',
        title    = _U('inventory'),
        elements = elements
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count',
          {
						css = 'ambulance',
            title = _U('quantity')
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('invalid_quantity'))
            else
              menu2.close()
              menu.close()
              OpenPutStocksMenu()

              TriggerServerEvent('esx_ambulancejob:putStockItems', itemName, count)
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)
end

function ShowNotificationMenu(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function OpenMobileAmbulanceActionsMenu()

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'mobile_ambulance_actions',
		{
			css = 'ambulance',
			title    = 'Ambulance',
			elements = {
				{label = _U('ems_menu'), value = 'citizen_interaction'},
				{label = 'Déposer un fauteuil',    value = 'add'},
				{label = 'Ramasser le fauteuil',    value = 'remove'},
			}
		},
		function(data, menu)

			if data.current.value == 'add' then
				TriggerEvent('esx_fauteuil:add')
			end

			if data.current.value == 'remove' then
				TriggerEvent('esx_fauteuil:remove')
			end

			if data.current.value == 'citizen_interaction' then

				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'citizen_interaction',
					{
						css = 'ambulance',
						title    = _U('ems_menu_title'),
						elements = {
						{label = 'Le Reanimer',   value = 'revive'},
						{label = 'Soigner',   value = 'soin'},
					  {label = 'Mettre dans la voiture', value = 'put_in_vehicle'},
						{label = 'Factures',              value = 'fine'},
						{label = 'Passer une annonce',    value = 'announce'},
						}
					},
					function(data, menu)

						if data.current.value == 'announce' then
							messagenotfinish = true
							Message()
						end

						if data.current.value == 'revive' then

							menu.close()

							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

							if closestPlayer == -1 or closestDistance > 3.0 then
								ESX.ShowNotification(_U('no_players'))
							else

								local ped    = GetPlayerPed(closestPlayer)
								local health = GetEntityHealth(ped)

								if health == 0 then

								local playerPed        = GetPlayerPed(-1)
								local closestPlayerPed = GetPlayerPed(closestPlayer)

								Citizen.CreateThread(function()

									ESX.ShowNotification(_U('revive_inprogress'))

									TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									Citizen.Wait(10000)
									ClearPedTasks(playerPed)

									if GetEntityHealth(closestPlayerPed) == 0 then
										TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))
										ESX.ShowNotification(_U('revive_complete') .. GetPlayerName(closestPlayer))
									else
										ESX.ShowNotification(GetPlayerName(closestPlayer) .. _U('isdead'))
									end

								end)

								else
									ESX.ShowNotification(GetPlayerName(closestPlayer) .. _U('unconscious'))
								end

							end

						end	

						if data.current.value == 'soin' then

							menu.close()

							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

							if closestPlayer == -1 or closestDistance > 3.0 then
								ESX.ShowNotification(_U('no_players'))
							else

								local ped    = GetPlayerPed(closestPlayer)

								local playerPed        = GetPlayerPed(-1)
								local closestPlayerPed = GetPlayerPed(closestPlayer)

								Citizen.CreateThread(function()

								TaskStartScenarioInPlace(GetPlayerPed(-1), "CODE_HUMAN_MEDIC_KNEEL", 0, 1)
								PlayAmbientSpeech1(GetPlayerPed(-1), "GENERIC_CURSE_MED", "SPEECH_PARAMS_FORCE")
								ShowNotificationMenu("Soins en cours...")
								TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'small')
								Citizen.Wait(7000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								

								end)

							end

						end	
						
						local player, distance = ESX.Game.GetClosestPlayer()
						
						if distance ~= -1 and distance <= 3.0 then
							if data.current.value == 'put_in_vehicle' then
								menu.close()
								TriggerServerEvent('esx_ambulancejob:putInVehicle', GetPlayerServerId(player))
							end
							
							if data.current.value == 'fine' then
								OpenFineMenu(player)
							end
						else
							ESX.ShowNotification(_U('no_players_nearby'))
						end

					end,
					function(data, menu)
						menu.close()
					end
				)

			end

		end,
		function(data, menu)
			menu.close()
		end
	)

end

function OpenFineMenu(player)

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'fine',
    {
			css = 'ambulance',
      title    = _U('fine'),
      align    = 'top-left',
      elements = {
        {label = _U('ambulance_fines'),   value = 0},
      },
    },
    function(data, menu)

      OpenFineCategoryMenu(player, data.current.value)

    end,
    function(data, menu)
      menu.close()
    end
  )

end

function OpenFineCategoryMenu(player, category)

  ESX.TriggerServerCallback('esx_ambulancejob:getFineList', function(fines)

    local elements = {}

    for i=1, #fines, 1 do
      table.insert(elements, {
        label     = fines[i].label .. ' $' .. fines[i].amount,
        value     = fines[i].id,
        amount    = fines[i].amount,
        fineLabel = fines[i].label
      })
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'fine_category',
      {
				css = 'ambulance',
        title    = _U('fine'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        local label  = data.current.fineLabel
        local amount = data.current.amount

        menu.close()

         if Config.EnablePlayerManagement then
        	local playerPed        = GetPlayerPed(-1)
        	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        	 
             Citizen.CreateThread(function()
                TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
                Citizen.Wait(5000)
                ClearPedTasks(playerPed)
                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_ambulance', _U('fine_total') .. label, amount)
            end)    
         else
          TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), '', _U('fine_total') .. label, amount)
         end

        ESX.SetTimeout(300, function()
          OpenFineCategoryMenu(player, category)
        end)

      end,
      function(data, menu)
        menu.close()
      end
    )

  end, category)

end

function OpenCloakroomMenu()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'cloakroom',
		{
			css = 'vestiaire',
			title    = _U('cloakroom'),
			align    = 'top-left',
			elements = {
				{label = _U('ems_clothes_civil'), value = 'citizen_wear'},
				{label = _U('ems_clothes_ems'), value = 'ambulance_wear'},
			},
		},
		function(data, menu)

			menu.close()

			if data.current.value == 'citizen_wear' then
            TriggerServerEvent("player:serviceOff", "ambulance")
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)

			end

			if data.current.value == 'ambulance_wear' then
			TriggerServerEvent("player:serviceOn", "ambulance")
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
					else
						TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
					end

				end)

			end

			CurrentAction     = 'ambulance_actions_menu'
			CurrentActionMsg  = _U('open_menu')
			CurrentActionData = {}

		end,
		function(data, menu)
			menu.close()
		end
	)

end

function OpenVehicleSpawnerMenu()

	ESX.UI.Menu.CloseAll()

	if Config.EnableSocietyOwnedVehicles then

		local elements = {}

		ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)

			for i=1, #vehicles, 1 do
				table.insert(elements, {label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']', value = vehicles[i]})
			end

			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'vehicle_spawner',
				{
					css = 'vehicle',
					title    = _U('veh_menu'),
					align    = 'top-left',
					elements = elements,
				},
				function(data, menu)

					menu.close()

					local vehicleProps = data.current.value

					ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPoint.Pos, 270.0, function(vehicle)
						ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
						local playerPed = GetPlayerPed(-1)
						TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
					end)

					TriggerServerEvent('esx_society:removeVehicleFromGarage', 'ambulance', vehicleProps)

				end,
				function(data, menu)

					menu.close()

					CurrentAction     = 'vehicle_spawner_menu'
					CurrentActionMsg  = _U('veh_spawn')
					CurrentActionData = {}

				end
			)

		end, 'ambulance')

	else

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'vehicle_spawner',
			{
				css = 'vehicle',
				title    = _U('veh_menu'),
				align    = 'top-left',
				elements = {
					{label = 'Ambulance',  value = 'sams1'},
					{label = 'Dodge Samu',  value = 'dodgesamu'},
					{label = 'Ford 4x4',  value = 'qrv'},
					{label = _U('firetruk'),  value = 'firetruk'},
				},
			},
			function(data, menu)

				menu.close()

				local model = data.current.value
				local playerPed = GetPlayerPed(-1)
				local platenum = math.random(100, 900)
				local vehicle = GetVehiclePedIsIn(playerPed)

				ESX.Game.SpawnVehicle(model, Config.Zones.VehicleSpawnPoint.Pos, 270.0, function(vehicle)
					SetVehicleMaxMods(vehicle)
					SetVehicleNumberPlateText(vehicle, "LSMD" .. platenum)
					TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
					local plate = GetVehicleNumberPlateText(vehicle)
					plate = string.gsub(plate, " ", "")
					TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock

				end)

			end,
			function(data, menu)

				menu.close()

				CurrentAction     = 'vehicle_spawner_menu'
				CurrentActionMsg  = _U('veh_spawn')
				CurrentActionData = {}

			end
		)

	end

end

function OpenHelicoSpawnerMenu()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'helico_spawner',
		{
			css = 'vehicle',
			title    = _U('helico_menu'),
			align    = 'top-left',
			elements = {
				{label = _U('helicopter'), value = 'aw139'},
			},
		},
		function(data, menu)

			menu.close()

			local model = data.current.value

			ESX.Game.SpawnVehicle(model, Config.Zones.HelicoSpawnPoint.Pos, 270.0, function(vehicle)

				local playerPed = GetPlayerPed(-1)
				local platenum = math.random(100, 900)

				if model == 'aw139' then
					SetVehicleModKit(vehicle, 0)
					SetVehicleLivery(vehicle, 1)
					SetVehicleNumberPlateText(vehicle, "LSMD" .. platenum)
				end

				TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
				local plate = GetVehicleNumberPlateText(vehicle)
                plate = string.gsub(plate, " ", "")
                TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock

			end)

		end,
		function(data, menu)

			menu.close()

			CurrentAction     = 'helico_spawner_menu'
			CurrentActionMsg  = _U('helico_spawn')
			CurrentActionData = {}

		end
	)

end

function ShowNotificationSpawn(text)
	SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    SetNotificationMessage("CHAR_ALL_PLAYERS_CONF", "CHAR_ALL_PLAYERS_CONF", true, 1, "Bristols", "~r~Serveur LaSalle");
	DrawNotification(false, false)
end

AddEventHandler('playerSpawned', function()

	IsDead = false

	if FirstSpawn then
		ShowNotificationSpawn("Bienvenue, ~b~"..GetPlayerName(PlayerId()).."")
		TriggerServerEvent('esx_ambulancejob:firstSpawn')
		exports.spawnmanager:setAutoSpawn(false)
		FirstSpawn = false
	end

end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)

	PlayerData = xPlayer

	if PlayerData.job.name == 'ambulance' then

		Config.Zones.AmbulanceActions.Type  = 1
		Config.Zones.VehicleSpawner.Type    = 1
		Config.Zones.HelicoSpawner.Type     = 1
		Config.Zones.VehicleDeleter.Type    = 1
		Config.Zones.VehicleDeleter2.Type   = 1

	else

		Config.Zones.AmbulanceActions.Type  = -1
		Config.Zones.VehicleSpawner.Type    = -1
		Config.Zones.HelicoSpawner.Type     = -1
		Config.Zones.VehicleDeleter.Type    = -1
		Config.Zones.VehicleDeleter2.Type   = -1

	end

end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)

	PlayerData.job = job

	if PlayerData.job.name == 'ambulance' then

		Config.Zones.AmbulanceActions.Type  = 1
		Config.Zones.VehicleSpawner.Type    = 1
		Config.Zones.HelicoSpawner.Type     = 1
		Config.Zones.VehicleDeleter.Type    = 1
		Config.Zones.VehicleDeleter2.Type   = 1

	else

		Config.Zones.AmbulanceActions.Type  = -1
		Config.Zones.VehicleSpawner.Type    = -1
		Config.Zones.HelicoSpawner.Type     = -1
		Config.Zones.VehicleDeleter.Type    = -1
		Config.Zones.VehicleDeleter2.Type   = -1

	end

end)

AddEventHandler('baseevents:onPlayerDied', function(killerType, coords)
	TriggerEvent('esx_ambulancejob:onPlayerDeath')
end)

AddEventHandler('baseevents:onPlayerKilled', function(killerId, data)
	TriggerEvent('esx_ambulancejob:onPlayerDeath')
end)



Citizen.CreateThread(function()
   while true do
       Citizen.Wait(0)      
            if IsEntityDead(PlayerPedId()) then 
			
					StartScreenEffect("DeathFailOut", 0, 0)
					if not locksound then
                    PlaySoundFrontend(-1, "Bed", "WastedSounds", 1)
					locksound = true
					end
					ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)
					
					local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")

					if HasScaleformMovieLoaded(scaleform) then
						Citizen.Wait(0)

					PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
					BeginTextComponent("STRING")
					AddTextComponentString("~r~Vous êtes dans le coma")
					EndTextComponent()
					PopScaleformMovieFunctionVoid()

				    Citizen.Wait(500)

					PlaySoundFrontend(-1, "TextHit", "WastedSounds", 1)
                    while IsEntityDead(PlayerPedId()) do
					  DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
					  Citizen.Wait(0)
                     end
					 
				  StopScreenEffect("DeathFailOut")
				  locksound = false
			end
		end
    end
end)

AddEventHandler('esx_ambulancejob:onPlayerDeath', function()

	IsDead = true

	if Config.ShowDeathTimer == true then
		RespawnTimer()
	else
		StartRespawnTimer()
		StartRespawnToHospitalMenuTimer()
	end

	StartScreenEffect('DeathFailOut',  0,  false)

end)

RegisterNetEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function()

	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', 0)

	Citizen.CreateThread(function()

		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(1)
		end

		ESX.SetPlayerData('lastPosition', {
			x = coords.x,
			y = coords.y,
			z = coords.z
		})

		TriggerServerEvent('esx:updateLastPosition', {
			x = coords.x,
			y = coords.y,
			z = coords.z
		})

		RespawnPed(playerPed, {
			x = coords.x,
			y = coords.y,
			z = coords.z
		})

		StopScreenEffect('DeathFailOut')

		DoScreenFadeIn(800)

	end)

end)

RegisterNetEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function()

  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

    local vehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  5.0,  0,  71)

    if DoesEntityExist(vehicle) then

      local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
      local freeSeat = nil

      for i=maxSeats - 1, 0, -1 do
        if IsVehicleSeatFree(vehicle,  i) then
          freeSeat = i
          break
        end
      end

      if freeSeat ~= nil then
        TaskWarpPedIntoVehicle(playerPed,  vehicle,  freeSeat)
      end

    end

  end

end)

AddEventHandler('esx_ambulancejob:hasEnteredMarker', function(zone)

	if zone == 'HospitalInteriorEntering1' then
		TeleportFadeEffect(GetPlayerPed(-1), Config.Zones.HospitalInteriorInside1.Pos)
	end

	if zone == 'HospitalInteriorExit1' then
		TeleportFadeEffect(GetPlayerPed(-1), Config.Zones.HospitalInteriorOutside1.Pos)
	end

	if zone == 'HospitalInteriorEntering2' then
		TeleportFadeEffect(GetPlayerPed(-1), Config.Zones.HospitalInteriorInside2.Pos)
	end

	if zone == 'HospitalInteriorExit2' then
		TeleportFadeEffect(GetPlayerPed(-1), Config.Zones.HospitalInteriorOutside2.Pos)
	end

	if zone == 'AmbulanceActions' and PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' then
		CurrentAction     = 'ambulance_actions_menu'
		CurrentActionMsg  = _U('open_menu')
		CurrentActionData = {}
	end

	if zone == 'VehicleSpawner' and PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' then
		CurrentAction     = 'vehicle_spawner_menu'
		CurrentActionMsg  = _U('veh_spawn')
		CurrentActionData = {}
	end

	if zone == 'HelicoSpawner' and PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' then
		CurrentAction     = 'helico_spawner_menu'
		CurrentActionMsg  = _U('helico_spawn')
		CurrentActionData = {}
	end
	
	if PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' then
	  if zone == 'Garage' then
		  CurrentAction     = 'ambulance_harvest_menu'
		  CurrentActionMsg  = _U('harvest_menu')
		  CurrentActionData = {}
		end
	end

	if zone == 'Craft' then
		CurrentAction     = 'ambulance_craft_menu'
		CurrentActionMsg  = _U('craft_menu')
		CurrentActionData = {}
	end

	if zone == 'VehicleDeleter' and PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' then

		local playerPed = GetPlayerPed(-1)
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed,  false) then

			local vehicle = GetVehiclePedIsIn(playerPed, false)

			if DoesEntityExist(vehicle) then
			CurrentAction     = 'delete_vehicle'
			CurrentActionMsg  = _U('store_vehicle')
			CurrentActionData = {vehicle = vehicle}
			end

		end

	end

	if zone == 'VehicleDeleter2' and PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' then

		local playerPed = GetPlayerPed(-1)
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed,  false) then

			local vehicle = GetVehiclePedIsIn(playerPed, false)

			if DoesEntityExist(vehicle) then
			CurrentAction     = 'delete_helico'
			CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour ranger l\'hélico.'
			CurrentActionData = {}
			end

		end
	end

end)

AddEventHandler('esx_ambulancejob:hasExitedMarker', function(zone)

  if zone == 'Craft' then
    TriggerServerEvent('esx_ambulancejob:stopCraft')
    TriggerServerEvent('esx_ambulancejob:stopCraft2')
  end

  if zone == 'Garage' then
    TriggerServerEvent('esx_ambulancejob:stopHarvest')
    TriggerServerEvent('esx_ambulancejob:stopHarvest2')
  end

  CurrentAction = nil
  ESX.UI.Menu.CloseAll()
end)

AddEventHandler('esx_ambulancejob:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

AddEventHandler('esx_ambulancejob:hasEnteredEntityZone', function(entity)

  local playerPed = GetPlayerPed(-1)

  if PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' and not IsPedInAnyVehicle(playerPed, false) then
    CurrentAction     = 'remove_entity'
    CurrentActionMsg  = _U('remove_object')
    CurrentActionData = {entity = entity}
  end

  if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then

    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)

    if IsPedInAnyVehicle(playerPed,  false) then

      local vehicle = GetVehiclePedIsIn(playerPed)

      for i=0, 7, 1 do
        SetVehicleTyreBurst(vehicle,  i,  true,  1000)
      end

    end

  end

end)

AddEventHandler('esx_ambulancejob:hasExitedEntityZone', function(entity)

  if CurrentAction == 'remove_entity' then
    CurrentAction = nil
  end

end)


-- Create blips
Citizen.CreateThread(function()

	local blip = AddBlipForCoord(Config.Zones.HospitalInteriorOutside1.Pos.x, Config.Zones.HospitalInteriorOutside1.Pos.y, Config.Zones.HospitalInteriorOutside1.Pos.z)

  SetBlipSprite (blip, 61)
  SetBlipDisplay(blip, 4)
  SetBlipScale  (blip, 1.0)
  SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(_U('hospital'))
  EndTextCommandSetBlipName(blip)

end)

-- Create blips
Citizen.CreateThread(function()

	local blip = AddBlipForCoord(Config.Zones.Garage.Pos.x, Config.Zones.Garage.Pos.y, Config.Zones.Garage.Pos.z)

  SetBlipSprite (blip, 61)
  SetBlipDisplay(blip, 4)
  SetBlipColour (blip, 69)
  SetBlipScale  (blip, 1.0)
  SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(_U('Materiel_Medical'))
  EndTextCommandSetBlipName(blip)
end)

-- Display markers
Citizen.CreateThread(function()
	while true do

		Wait(0)

		local coords = GetEntityCoords(GetPlayerPed(-1))

		for k,v in pairs(Config.Zones) do

			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			end
		end

	end
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	while true do

		Wait(0)

		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
				isInMarker  = true
				currentZone = k
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			lastZone                = currentZone
			TriggerEvent('esx_ambulancejob:hasEnteredMarker', currentZone)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_ambulancejob:hasExitedMarker', lastZone)
		end

	end
end)

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(_type)
	local playerPed = GetPlayerPed(-1)
	local maxHealth = GetEntityMaxHealth(playerPed)
	if _type == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth , math.floor(health + maxHealth/8))
		SetEntityHealth(playerPed, newHealth)
	elseif _type == 'big' then
		SetEntityHealth(playerPed, maxHealth)
	end
	ShowNotificationMain("vous avez été soigné")
end)

-- Ambulance Job
Citizen.CreateThread(function()

  while true do

    Citizen.Wait(1)

    local playerPed = GetPlayerPed(-1)

    if OnJob then

      if CurrentCustomer == nil then

        DrawSub(_U('drive_search_pass'), 5000)

        if IsPedInAnyVehicle(playerPed,  false) and GetEntitySpeed(playerPed) > 0 then

          local waitUntil = GetGameTimer() + GetRandomIntInRange(30000,  45000)

          while OnJob and waitUntil > GetGameTimer() do
            Citizen.Wait(1)
          end

          if OnJob and IsPedInAnyVehicle(playerPed,  false) and GetEntitySpeed(playerPed) > 0 then

            CurrentCustomer = GetRandomWalkingNPC()

            if CurrentCustomer ~= nil then

              CurrentCustomerBlip = AddBlipForEntity(CurrentCustomer)

              SetBlipAsFriendly(CurrentCustomerBlip, 1)
              SetBlipColour(CurrentCustomerBlip, 2)
              SetBlipCategory(CurrentCustomerBlip, 3)
              SetBlipRoute(CurrentCustomerBlip,  true)

              SetEntityAsMissionEntity(CurrentCustomer,  true, false)
              ClearPedTasksImmediately(CurrentCustomer)
              SetBlockingOfNonTemporaryEvents(CurrentCustomer, 1)

              local standTime = GetRandomIntInRange(60000,  180000)

              TaskStandStill(CurrentCustomer, standTime)

              ESX.ShowNotification(_U('customer_found'))

            end

          end


        end

      else

        if IsPedFatallyInjured(CurrentCustomer) then

          ESX.ShowNotification(_U('client_unconcious'))

          if DoesBlipExist(CurrentCustomerBlip) then
            RemoveBlip(CurrentCustomerBlip)
          end

          if DoesBlipExist(DestinationBlip) then
            RemoveBlip(DestinationBlip)
          end

          SetEntityAsMissionEntity(CurrentCustomer,  false, true)

          CurrentCustomer           = nil
          CurrentCustomerBlip       = nil
          DestinationBlip           = nil
          IsNearCustomer            = false
          CustomerIsEnteringVehicle = false
          CustomerEnteredVehicle    = false
          TargetCoords              = nil

        end

        if IsPedInAnyVehicle(playerPed,  false) then

          local vehicle          = GetVehiclePedIsIn(playerPed,  false)
          local playerCoords     = GetEntityCoords(playerPed)
          local customerCoords   = GetEntityCoords(CurrentCustomer)
          local customerDistance = GetDistanceBetweenCoords(playerCoords.x,  playerCoords.y,  playerCoords.z,  customerCoords.x,  customerCoords.y,  customerCoords.z)

          if IsPedSittingInVehicle(CurrentCustomer,  vehicle) then

            if CustomerEnteredVehicle then

              local targetDistance = GetDistanceBetweenCoords(playerCoords.x,  playerCoords.y,  playerCoords.z,  TargetCoords.x,  TargetCoords.y,  TargetCoords.z)

              if targetDistance <= 10.0 then

                TaskLeaveVehicle(CurrentCustomer,  vehicle,  0)

                ESX.ShowNotification(_U('arrive_dest'))

                TaskGoStraightToCoord(CurrentCustomer,  TargetCoords.x,  TargetCoords.y,  TargetCoords.z,  1.0,  -1,  0.0,  0.0)
                SetEntityAsMissionEntity(CurrentCustomer,  false, true)

                TriggerServerEvent('esx_ambulancejob:success')

                RemoveBlip(DestinationBlip)

                local scope = function(customer)
                  ESX.SetTimeout(60000, function()
                    DeletePed(customer)
                  end)
                end

                scope(CurrentCustomer)

                CurrentCustomer           = nil
                CurrentCustomerBlip       = nil
                DestinationBlip           = nil
                IsNearCustomer            = false
                CustomerIsEnteringVehicle = false
                CustomerEnteredVehicle    = false
                TargetCoords              = nil

              end

              if TargetCoords ~= nil then
                DrawMarker(1, TargetCoords.x, TargetCoords.y, TargetCoords.z - 1.0, 0, 0, 0, 0, 0, 0, 4.0, 4.0, 2.0, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
              end

            else

              RemoveBlip(CurrentCustomerBlip)

              CurrentCustomerBlip = nil

              TargetCoords = Config.JobLocations[GetRandomIntInRange(1,  #Config.JobLocations)]

              local street = table.pack(GetStreetNameAtCoord(TargetCoords.x, TargetCoords.y, TargetCoords.z))
              local msg    = nil

              if street[2] ~= 0 and street[2] ~= nil then
                msg = string.format(_U('take_me_to_near', GetStreetNameFromHashKey(street[1]),GetStreetNameFromHashKey(street[2])))
              else
                msg = string.format(_U('take_me_to', GetStreetNameFromHashKey(street[1])))
              end

              ESX.ShowNotification(msg)

              DestinationBlip = AddBlipForCoord(TargetCoords.x, TargetCoords.y, TargetCoords.z)

              BeginTextCommandSetBlipName("STRING")
              AddTextComponentString("Destination")
              EndTextCommandSetBlipName(blip)

              SetBlipRoute(DestinationBlip,  true)

              CustomerEnteredVehicle = true

            end

          else

            DrawMarker(1, customerCoords.x, customerCoords.y, customerCoords.z - 1.0, 0, 0, 0, 0, 0, 0, 4.0, 4.0, 2.0, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)

            if not CustomerEnteredVehicle then

              if customerDistance <= 30.0 then

                if not IsNearCustomer then
                  ESX.ShowNotification(_U('close_to_client'))
                  IsNearCustomer = true
                end

              end

              if customerDistance <= 100.0 then

                if not CustomerIsEnteringVehicle then

                  ClearPedTasksImmediately(CurrentCustomer)

                  local seat = 2

                  for i=4, 0, 1 do
                    if IsVehicleSeatFree(vehicle,  seat) then
                      seat = i
                      break
                    end
                  end

                  TaskEnterVehicle(CurrentCustomer,  vehicle,  -1,  seat,  2.0,  1)

                  CustomerIsEnteringVehicle = true

                end

              end

            end

          end

        else

          DrawSub(_U('return_to_veh'), 5000)

        end


      end


    end

  end
end)

-- Enter / Exit entity zone events
Citizen.CreateThread(function()

  local trackedEntities = {
    'prop_roadcone02a',
    'prop_barrier_work06a',
    'p_ld_stinger_s',
    'prop_boxpile_07d',
    'hei_prop_cash_crate_half_full'
  }

  while true do

    Citizen.Wait(1)

    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)

    local closestDistance = -1
    local closestEntity   = nil

    for i=1, #trackedEntities, 1 do

      Citizen.Wait(1000)

      local object = GetClosestObjectOfType(coords.x,  coords.y,  coords.z,  3.0,  GetHashKey(trackedEntities[i]), false, false, false)

      if DoesEntityExist(object) then

        local objCoords = GetEntityCoords(object)
        local distance  = GetDistanceBetweenCoords(coords.x,  coords.y,  coords.z,  objCoords.x,  objCoords.y,  objCoords.z,  true)

        if closestDistance == -1 or closestDistance > distance then
          closestDistance = distance
          closestEntity   = object
        end

      end

    end

    if closestDistance ~= -1 and closestDistance <= 3.0 then

      if LastEntity ~= closestEntity then
        TriggerEvent('esx_ambulancejob:hasEnteredEntityZone', closestEntity)
        LastEntity = closestEntity
      end

    else

      if LastEntity ~= nil then
        TriggerEvent('esx_ambulancejob:hasExitedEntityZone', LastEntity)
        LastEntity = nil
      end

    end

  end
end)


-- Key Controls
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(1)

		if CurrentAction ~= nil then

			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

      if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' then

        if CurrentAction == 'ambulance_actions_menu' then
          OpenAmbulanceActionsMenu()
        end
        
        if CurrentAction == 'ambulance_harvest_menu' then
          OpenAmbulanceHarvestMenu()
        end

        if CurrentAction == 'ambulance_craft_menu' then
          OpenAmbulanceCraftMenu()
        end

        if CurrentAction == 'vehicle_spawner_menu' then
          OpenVehicleSpawnerMenu()
        end

        if CurrentAction == 'helico_spawner_menu' then
		  OpenHelicoSpawnerMenu()
		end

        if CurrentAction == 'delete_vehicle' then

          if Config.EnableSocietyOwnedVehicles then
            local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
            local playerPed    = GetPlayerPed(-1)
            local vehicle      = GetVehiclePedIsIn(playerPed,  false)
            local hash         = GetEntityModel(vehicle)
            local plate        = GetVehicleNumberPlateText(vehicle)
            TriggerServerEvent('esx_society:putVehicleInGarage', 'ambulance', vehicleProps)
          end

          ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
          TriggerServerEvent('esx_vehiclelock:deletekeyjobs', 'no', plate) --vehicle lock
        end

        if CurrentAction == 'delete_helico' then
            local playerPed = GetPlayerPed(-1)
            local vehicle   = GetVehiclePedIsIn(playerPed,  false)
            local hash      = GetEntityModel(vehicle)
            local plate        = GetVehicleNumberPlateText(vehicle)
            if hash == GetHashKey('aw139') or hash == GetHashKey('maverick') then                        
                DeleteVehicle(vehicle)
                TriggerServerEvent('esx_vehiclelock:deletekeyjobs', 'no', plate) --vehicle lock
            else
                ESX.ShowNotification('Vous ne pouvez ranger que des ~b~véhicules des urgences ~s~.')
            end
         end

        if CurrentAction == 'remove_entity' then
		     DeleteEntity(CurrentActionData.entity)
		end

        CurrentAction = nil

      end

    end

    --if IsControlJustReleased(0, Keys['F6']) and PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' then
      --OpenMobileAmbulanceActionsMenu()
    --end
		
    if IsControlPressed(0,  Keys['DELETE']) and (GetGameTimer() - GUI.Time) > 150 then

      if OnJob then
        StopAmbulanceJob()
      else

        if PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' then

          local playerPed = GetPlayerPed(-1)

          if IsPedInAnyVehicle(playerPed,  false) then

            local vehicle = GetVehiclePedIsIn(playerPed,  false)

            if PlayerData.job.grade >= 3 then
              StartAmbulanceJob()
            else
              if GetEntityModel(vehicle) == GetHashKey('ambulance1') or GetHashKey('dodgesamu') then
                StartAmbulanceJob()
              else
                ESX.ShowNotification(_U('must_in_ambulance'))
              end
            end

          else

            if PlayerData.job.grade >= 3 then
              ESX.ShowNotification(_U('must_in_vehicle'))
            else
              ESX.ShowNotification(_U('must_in_ambulance'))
            end

          end

        end

      end

      GUI.Time = GetGameTimer()

    end
    end
end)

-- Load unloaded IPLs
--Citizen.CreateThread(function()
  --LoadMpDlcMaps()
  --EnableMpDlcMaps(true)
  --RequestIpl('Coroner_Int_on') -- Morgue
--end)

-- String string
function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

function DrawAdvancedTextCNN (x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
    N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - 0.1+w, y - 0.02+h)
end


 Citizen.CreateThread(function()
		    while true do
		        Citizen.Wait(1)    
		                       
		            if (affichenews == true) then
		           
				            DrawRect(0.494, 0.227, 5.185, 0.118, 0, 0, 0, 150)
				            DrawAdvancedTextCNN(0.588, 0.14, 0.005, 0.0028, 0.8, "~r~ AMBULANCE ~d~", 255, 255, 255, 255, 1, 0)
				            DrawAdvancedTextCNN(0.586, 0.199, 0.005, 0.0028, 0.6, texteafiche, 255, 255, 255, 255, 7, 0)
				            DrawAdvancedTextCNN(0.588, 0.246, 0.005, 0.0028, 0.4, "", 255, 255, 255, 255, 0, 0)

				    end                
		   end
		end)



RegisterNetEvent('esx_ambulancejob:annonce')
AddEventHandler('esx_ambulancejob:annonce', function(text)
 		texteafiche = text
 		affichenews = true
		
  end) 


RegisterNetEvent('esx_ambulancejob:annoncestop')
AddEventHandler('esx_ambulancejob:annoncestop', function()
 		affichenews = false
 		
	end)
	
RegisterNetEvent('esx_ambulancejob:requestDeath')
AddEventHandler('esx_ambulancejob:requestDeath', function()
  Wait(7000)
  SetEntityHealth(GetPlayerPed(-1), 0)
end)


---------------------------------------------------------------------------------------------------------
--NB : gestion des menu
---------------------------------------------------------------------------------------------------------

RegisterNetEvent('NB:openMenuAmbulance')
AddEventHandler('NB:openMenuAmbulance', function()
	OpenMobileAmbulanceActionsMenu()
end)