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

local PID           	      = 0
local GUI           	      = {}
ESX 			    		  = nil
GUI.Time            		  = 0
local PlayerData 			  = {}
local GUI 				      = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1)
	end
end)

AddEventHandler('esx_various:hasEnteredMarker', function(zone)
    
   ESX.UI.Menu.CloseAll()
    
    for i=1, #Config.OrangeFarms, 1 do       
        if zone == 'OrangeFarm' .. i then
          CurrentAction     = 'orange_harvest'
          CurrentActionMsg  = _U('press_collect_orange')
          CurrentActionData = {}
        end
    end

end)

AddEventHandler('esx_various:hasExitedMarker', function(zone)

	CurrentAction = nil
	ESX.UI.Menu.CloseAll()

	TriggerServerEvent('esx_various:stopHarvestOrange')


end)

----------------------------
------ RENDER MARKERS ------
----------------------------
Citizen.CreateThread(function()
    while true do

        Citizen.Wait(1)

        local coords = GetEntityCoords(GetPlayerPed(-1))

        for k,v in pairs(Config.Zones) do
            if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
                DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
            end
        end
    end
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
    while true do
        
        Citizen.Wait(1)
        
        local coords      = GetEntityCoords(GetPlayerPed(-1))
        local isInMarker  = false
        local currentZone = nil

        for k,v in pairs(Config.Zones) do
            if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x / 2) then
                isInMarker  = true
                currentZone = k
            end
        end

        if isInMarker and not HasAlreadyEnteredMarker then
            HasAlreadyEnteredMarker = true
            LastZone                = currentZone
            TriggerEvent('esx_various:hasEnteredMarker', currentZone)
        end

        if not isInMarker and HasAlreadyEnteredMarker then
            HasAlreadyEnteredMarker = false
            TriggerEvent('esx_various:hasExitedMarker', LastZone)
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
      if IsControlJustReleased(0, 38) then
        
        if CurrentAction == 'orange_harvest' then
          if (IsPedSittingInAnyVehicle(GetPlayerPed(-1)) ) then
            ESX.ShowNotification('~r~Vous devez sortir de votre vehicule')
          else
          TriggerServerEvent('esx_various:startHarvestOrange')
          end
        end
         
				CurrentAction = nil				
			end
		end
	end
end)

--------------------------------------------------------------------
------------------------------ BLIPS--------------------------------
--------------------------------------------------------------------

local blips = {
    --{title="Champs d\'oranges", id=93, x=281.966,  y=6506.6, z=29.1286},
}

Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.9)
      SetBlipAsShortRange(info.blip, true)
	    BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

-----//////////////////////////////////////////////////////////-----
-----////////////////////////Use Objetc////////////////////////-----
-----//////////////////////////////////////////////////////////-----


----------------------------
---- UTILISER CIGARETTE ----
----------------------------
RegisterNetEvent('esx_teamsterjob:onSmoke')
AddEventHandler('esx_teamsterjob:onSmoke', function()
  TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_SMOKING", 0, 1)
  emotePlay = true
  Citizen.Wait(90000)
  ClearPedTasksImmediately(GetPlayerPed(-1))
  emotePlay = false
end)

function stopEmote()
  ClearPedTasks(GetPlayerPed(-1))
  emotePlay = false
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    if emotePlay then
      if IsControlJustPressed(1, 22) or IsControlJustPressed(1, 30) or IsControlJustPressed(1, 31) then
        stopEmote()
      end
    end
  end
end)

----------------------------
--- UTILISER COCOCA COLA ---
----------------------------
RegisterNetEvent('esx_teamsterjob:onDrink')
AddEventHandler('esx_teamsterjob:onDrink', function()

  Citizen.CreateThread(function()

    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)
    local boneIndex = GetPedBoneIndex(playerPed, 57005)
    
    RequestAnimDict('amb@world_human_drinking@coffee@male@idle_a')
    
    while not HasAnimDictLoaded('amb@world_human_drinking@coffee@male@idle_a') do
      Citizen.Wait(1)
    end

    ESX.Game.SpawnObject('ng_proc_sodabot_01a', {
        x = coords.x,
        y = coords.y,
        z = coords.z + 2
      }, function(object)

        Citizen.CreateThread(function()

          AttachEntityToEntity(object, playerPed, boneIndex, 0.12, 0, -0.02, 70.0, 70.0, 190.0, true, true, false, true, 1, true)
          Citizen.Wait(1000)
          TaskPlayAnim(playerPed, 'amb@world_human_drinking@coffee@male@idle_a', 'idle_a', 1.0, -1.0, 2000, 0, 1, true, true, true)
          Citizen.Wait(5000)
          DeleteObject(object)

        end)
      end)
   end)
end)

----------------------------
-- UTILISER COFEE & Choco --
----------------------------
RegisterNetEvent('esx_teamsterjob:onDrink2')
AddEventHandler('esx_teamsterjob:onDrink2', function()

  Citizen.CreateThread(function()

    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)
    local boneIndex = GetPedBoneIndex(playerPed, 57005)
    
    RequestAnimDict('amb@world_human_drinking@coffee@male@idle_a')
    
    while not HasAnimDictLoaded('amb@world_human_drinking@coffee@male@idle_a') do
      Citizen.Wait(1)
    end

    ESX.Game.SpawnObject('p_ing_coffeecup_01', {
        x = coords.x,
        y = coords.y,
        z = coords.z + 2
      }, function(object)

        Citizen.CreateThread(function()

          AttachEntityToEntity(object, playerPed, boneIndex, 0.12, 0, -0.02, 70.0, 70.0, 190.0, true, true, false, true, 1, true)
          Citizen.Wait(1000)
          TaskPlayAnim(playerPed, 'amb@world_human_drinking@coffee@male@idle_a', 'idle_a', 1.0, -1.0, 2000, 0, 1, true, true, true)
          Citizen.Wait(4500)
          DeleteObject(object)
          
        end)
      end)
   end)
end)


-------------------------------------------------------------------------------------------
------------------------------------- Burger Viande ---------------------------------------
-------------------------------------------------------------------------------------------

RegisterNetEvent('esx_basicneeds:hamburger')
AddEventHandler('esx_basicneeds:hamburger', function()

  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

  Citizen.CreateThread(function()
    
    local playerPed  = GetPlayerPed(-1)
    local coords     = GetEntityCoords(playerPed)
    local boneIndex  = GetPedBoneIndex(playerPed, 18905)
    local boneIndex2 = GetPedBoneIndex(playerPed, 57005)

      RequestAnimDict('amb@code_human_wander_eating_donut@male@idle_a')
        
    while not HasAnimDictLoaded('amb@code_human_wander_eating_donut@male@idle_a') do
      Citizen.Wait(1)
    end
    
    ESX.Game.SpawnObject('prop_cs_burger_01', {
      x = coords.x,
      y = coords.y,
      z = coords.z - 3
    }, function(object)

    
    Citizen.CreateThread(function()
    
      TaskPlayAnim(playerPed, "amb@code_human_wander_eating_donut@male@idle_a", "idle_c", 3.5, -8, -1, 49, 0, 0, 0, 0)
      AttachEntityToEntity(object, playerPed, boneIndex2, 0.15, 0.01, -0.06, 185.0, 215.0, 180.0, true, true, false, true, 1, true)
      Citizen.Wait(6500)
      DeleteObject(object)
      ClearPedSecondaryTask(playerPed)
      end)
    end)
  end)
end)