--DO-NOT-EDIT-BELLOW-THIS-LINE--
-- Init ESX
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
-- Fin init ESX


local soundDistance = 20 -- Distance of MP3 sounds

Key = 38 -- ENTER
local times = 0


vehicleMP3Station = {
	{-1387.0628662109,  -618.31188964844,  29.81955909729},
	
}

function showHelpNotification2(mess)
    SetTextComponentFormat('STRING')
    AddTextComponentString(mess)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function es_mp3_DrawNotification(m_text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(m_text)
	DrawNotification(true, false)
end

function startAttitude(lib, anim)
 	Citizen.CreateThread(function()
	
	    local playerPed = GetPlayerPed(-1)
	
	    RequestAnimSet(anim)
	      
	    while not HasAnimSetLoaded(anim) do
	        Citizen.Wait(0)
	    end
	    SetPedMovementClipset(playerPed, anim, true)
	end)

end

function startAnim(lib, anim)
 	
	Citizen.CreateThread(function()

	  RequestAnimDict(lib)
	  
	  while not HasAnimDictLoaded( lib) do
	    Citizen.Wait(0)
	  end

	  TaskPlayAnim(GetPlayerPed(-1), lib ,anim ,8.0, -8.0, -1, 0, 0, false, false, false )

	end)

end

function startScenario(anim)
  TaskStartScenarioInPlace(GetPlayerPed(-1), anim, 0, false)
end

function openMenu()

	local elements = {}

	table.insert(elements, {label = '📀 Eteindre la musique',             value = 'music1'})
	table.insert(elements, {label = '💿 3rd Prototype - Feel So Good',             value = 'music2'})
	table.insert(elements, {label = '💿 Diamond Eyes - Flutter',             value = 'music3'})
	table.insert(elements, {label = '💿 Diamond Eyes - Hold On',             value = 'music4'})
	table.insert(elements, {label = '💿 Focus Fire - Mirage',             value = 'music5'})
	table.insert(elements, {label = '💿 JPB - All Stops Now',             value = 'music6'})
	table.insert(elements, {label = '💿 Lost Sky - Dreams',             value = 'music7'})
	table.insert(elements, {label = '💿 Lost Sky - Dreams pt. II',             value = 'music8'})
	table.insert(elements, {label = '💿 NIVIRO - Dancin',             value = 'music9'})
	table.insert(elements, {label = '💿 Raven & Kreyn - Muffin',             value = 'music10'})
	table.insert(elements, {label = '💿 Robin Hustin x TobiMorrow',             value = 'music11'})
	table.insert(elements, {label = '💿 Showdown - Freedom',             value = 'music12'})
	table.insert(elements, {label = '💿 Subtact - Want You',             value = 'music13'})
	table.insert(elements, {label = '💿 Weero & Mitte - Our Dive',             value = 'music14'})
	table.insert(elements, {label = '💿 WiDE AWAKE - Something More',             value = 'music15'})

	ESX.UI.Menu.Open(
						
    	'default', GetCurrentResourceName(), 'id_card_menu',
		{
			title    = 'Choisir la musique',
			align    = 'top-left',
			elements = elements
		},
	function(data, menu)
		local val = data.current.value
		
		if val == 'music1' then
			TriggerServerEvent("InteractSound_SV:PlayWithinDistance", soundDistance, "vide", 1.0)
		elseif val == 'music2' then
			TriggerServerEvent("InteractSound_SV:PlayWithinDistance", soundDistance, "3rd-prototype-feel-so-good-ncs-release", 1.0)
		elseif val == 'music3' then
			TriggerServerEvent("InteractSound_SV:PlayWithinDistance", soundDistance, "diamond-eyes-flutter-ncs-release", 1.0)
		elseif val == 'music4' then
			TriggerServerEvent("InteractSound_SV:PlayWithinDistance", soundDistance, "diamond-eyes-hold-on-ncs-release", 1.0)
		elseif val == 'music5' then
			TriggerServerEvent("InteractSound_SV:PlayWithinDistance", soundDistance, "focus-fire-mirage-ncs-release", 1.0)
		elseif val == 'music6' then
			TriggerServerEvent("InteractSound_SV:PlayWithinDistance", soundDistance, "jpb-all-stops-now-feat-soundr-ncs-release", 1.0)
		elseif val == 'music7' then
			TriggerServerEvent("InteractSound_SV:PlayWithinDistance", soundDistance, "lost-sky-dreams-ncs-release", 1.0)
		elseif val == 'music8' then
			TriggerServerEvent("InteractSound_SV:PlayWithinDistance", soundDistance, "lost-sky-dreams-pt-ii-feat-sara-skinner-ncs-release", 1.0)
		elseif val == 'music9' then
			TriggerServerEvent("InteractSound_SV:PlayWithinDistance", soundDistance, "niviro-dancin-ncs-surround-release", 1.0)
		elseif val == 'music10' then
			TriggerServerEvent("InteractSound_SV:PlayWithinDistance", soundDistance, "raven-kreyn-muffin-ncs-release", 1.0)
		elseif val == 'music11' then
			TriggerServerEvent("InteractSound_SV:PlayWithinDistance", soundDistance, "robin-hustin-x-tobimorrow-light-it-up-feat-jex-ncs-release", 1.0)
		elseif val == 'music12' then
			TriggerServerEvent("InteractSound_SV:PlayWithinDistance", soundDistance, "showdown-freedom-feat-iman-ncs-release", 1.0)
		elseif val == 'music13' then
			TriggerServerEvent("InteractSound_SV:PlayWithinDistance", soundDistance, "subtact-want-you-feat-sara-skinner-ncs-release", 1.0)
		elseif val == 'music14' then
			TriggerServerEvent("InteractSound_SV:PlayWithinDistance", soundDistance, "weero-mitte-our-dive-ncs-release", 1.0)
		elseif val == 'music15' then
			TriggerServerEvent("InteractSound_SV:PlayWithinDistance", soundDistance, "wide-awake-something-more-ncs-release", 1.0)
		else
			local player, distance = ESX.Game.GetClosestPlayer()
		end
	end,
	function(data, menu)
		menu.close()
	end
)
end

function OpenAnimationsSubMenu(menu)

	local title    = nil
	local elements = {}

	for i=1, #Config.Animations, 1 do
		
		if Config.Animations[i].name == menu then

			title = Config.Animations[i].label

			for j=1, # Config.Animations[i].items, 1 do
				table.insert(elements, {label = Config.Animations[i].items[j].label, type = Config.Animations[i].items[j].type, value = Config.Animations[i].items[j].data})
			end

			break

		end

	end

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'animations_sub',
		{
			title    = title,
			align = 'top-left',
			elements = elements
		},
		function(data, menu)

			local type = data.current.type
			local lib  = data.current.value.lib
			local anim = data.current.value.anim

			if type == 'scenario' then
				startScenario(anim)
			elseif type == 'attitude' then
					startAttitude(lib, anim)
			elseif type =="stop_annim" then
				ClearPedTasks(GetPlayerPed(-1))
			else
					startAnim(lib, anim)
			end

		end,
		function(data, menu)
			menu.close()
		end
	)

end

function CloseAnimationsSubMenu()
	ESX.UI.Menu.CloseAll()
end

local function startPointing()
  
  local playerPed = GetPlayerPed(-1)

  RequestAnimDict("anim@mp_point")
  
  while not HasAnimDictLoaded("anim@mp_point") do
    Citizen.Wait(0)
  end
  
  SetPedCurrentWeaponVisible(playerPed, 0, 1, 1, 1)
  SetPedConfigFlag(playerPed, 36, 1)
  
  Citizen.InvokeNative(0x2D537BA194896636, playerPed, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
end

local function stopPointing()

    local playerPed = GetPlayerPed(-1)

    Citizen.InvokeNative(0xD01015C7316AE176, playerPed, "Stop")
   
    if not IsPedInjured(playerPed) then
      ClearPedSecondaryTask(playerPed)
    end

    if not IsPedInAnyVehicle(playerPed, 1) then
      SetPedCurrentWeaponVisible(playerPed, 1, 1, 1, 1)
    end

    SetPedConfigFlag(playerPed, 36, 0)
    
    ClearPedSecondaryTask(PlayerPedId())
end






Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
			local coords      = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker  = false
			local currentZone = nil
		for i = 1, #vehicleMP3Station do
				discoCoords = vehicleMP3Station[i]
				DrawMarker(1, discoCoords[1], discoCoords[2], discoCoords[3], 0, 0, 0, 0, 0, 0, 5.0, 5.0, 0.1, 240, 240, 0, 150, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), discoCoords[1], discoCoords[2], discoCoords[3], true ) < 25 then
					showHelpNotification2("Appuyez sur ~INPUT_CONTEXT~ pour écouter de la musique !")
					if IsControlJustPressed(1, Key) then
						--local music = Songs[ math.random( #Songs ) ]
						ESX.TriggerServerCallback('es_mp3:checkmoney',function(valid)
							if (valid) then
								times = 1
								openMenu()
								--TriggerServerEvent("InteractSound_SV:PlayWithinDistance", soundDistance, music, 1.0)
								TriggerEvent('esx:showNotification', "Choisiez votre music")
							else
								TriggerEvent('esx:showNotification', "Vous n'avez pas assez d'argent")
							end
						end)
					end
				 isInMarker  = true
				 currentZone = k
				 else
				 if times == 1 then
					 CloseAnimationsSubMenu()
					 times = 0
				 end
				end
		end
		
		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then			
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone


		end

		if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerServerEvent("InteractSound_SV:PlayWithinDistance", soundDistance, "vide", 1.0)
		end
		
	end
	
end)


RegisterNetEvent('es_mp3:success')
AddEventHandler('es_mp3:success', function (price)
	es_mp3_DrawNotification("En Avant la ~y~Musique~s~! ~g~-$" .. price .. "~s~!")
end)

RegisterNetEvent('es_mp3:notenoughmoney')
AddEventHandler('es_mp3:notenoughmoney', function (moneyleft)
	es_mp3_DrawNotification("~h~~r~Tu n'as pas accès d'argent! $" .. moneyleft .. " Bye!")
end)

RegisterNetEvent('es_mp3:free')
AddEventHandler('es_mp3:free', function ()
	es_mp3_DrawNotification("En Avant la ~y~Musique~s~ Gratuite!")
end)