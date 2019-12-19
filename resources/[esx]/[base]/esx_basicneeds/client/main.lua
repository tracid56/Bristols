ESX          = nil
local IsDead = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1)
	end
end)

AddEventHandler('esx_basicneeds:resetStatus', function()
	TriggerEvent('esx_status:set', 'hunger', 500000)
	TriggerEvent('esx_status:set', 'thirst', 500000)

end)

AddEventHandler('playerSpawned', function()

	if IsDead then
		TriggerEvent('esx_basicneeds:resetStatus')
	end

	IsDead = false
end)

AddEventHandler('esx_status:loaded', function(status)

	TriggerEvent('esx_status:registerStatus', 'hunger', 1000000, '#b51515',
		function(status)
			return true
		end,
		function(status)
			status.remove(200)
		end
	)

	TriggerEvent('esx_status:registerStatus', 'thirst', 1000000, '#0172ba',
		function(status)
			return true
		end,
		function(status)
			status.remove(250)
		end
	)

	Citizen.CreateThread(function()

		while true do

			Wait(1000)

			local playerPed  = GetPlayerPed(-1)
			local prevHealth = GetEntityHealth(playerPed)
			local health     = prevHealth

			TriggerEvent('esx_status:getStatus', 'hunger', function(status)
				
				if status.val == 0 then

					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end

				end

			end)

			TriggerEvent('esx_status:getStatus', 'thirst', function(status)
				
				if status.val == 0 then

					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end

				end

			end)

			if health ~= prevHealth then
				SetEntityHealth(playerPed,  health)
			end

		end

	end)

	Citizen.CreateThread(function()

		while true do

			Wait(0)

			local playerPed = GetPlayerPed(-1)
			
			if IsEntityDead(playerPed) and not IsDead then
				IsDead = true
			end

		end

	end)

end)

RegisterNetEvent('esx_basicneeds:onEat')
AddEventHandler('esx_basicneeds:onEat', function()
  
	Citizen.CreateThread(function()

	  local playerPed = GetPlayerPed(-1)
	  local coords    = GetEntityCoords(playerPed)
	  local boneIndex = GetPedBoneIndex(playerPed, 18905)
	  
	  RequestAnimDict('mp_player_inteat@burger')
	  
	  while not HasAnimDictLoaded('mp_player_inteat@burger') do
	  	Citizen.Wait(1)
	  end

		ESX.Game.SpawnObject('prop_cs_burger_01', {
			x = coords.x,
			y = coords.y,
			z = coords.z + 2
		}, function(object)

			Citizen.CreateThread(function()

			  AttachEntityToEntity(object, playerPed, boneIndex, 0.12, 0, 0.02, 90.0, 90.0, 410.0, true, true, false, true, 1, true)
			  Citizen.Wait(1000)
			  TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 1.0, -1.0, 2000, 0, 1, true, true, true)
			  Citizen.Wait(2000)
			  DeleteObject(object)

			end)

		end)

	end)

end)

RegisterNetEvent('esx_basicneeds:onDrink')
AddEventHandler('esx_basicneeds:onDrink', function()

	Citizen.CreateThread(function()

	  local playerPed = GetPlayerPed(-1)
	  local coords    = GetEntityCoords(playerPed)
	  local boneIndex = GetPedBoneIndex(playerPed, 57005)
	  
	  RequestAnimDict('amb@world_human_drinking@coffee@male@idle_a')
	  
	  while not HasAnimDictLoaded('amb@world_human_drinking@coffee@male@idle_a') do
	  	Citizen.Wait(1)
	  end

		ESX.Game.SpawnObject('prop_ld_flow_bottle', {
				x = coords.x,
				y = coords.y,
				z = coords.z + 2
			}, function(object)

				Citizen.CreateThread(function()

				  AttachEntityToEntity(object, playerPed, boneIndex, 0.12, 0, -0.02, 90.0, 90.0, 210.0, true, true, false, true, 1, true)
				  Citizen.Wait(1000)
				  TaskPlayAnim(playerPed, 'amb@world_human_drinking@coffee@male@idle_a', 'idle_a', 1.0, -1.0, 2000, 0, 1, true, true, true)
				  Citizen.Wait(5000)
				  DeleteObject(object)

				end)

			end)

	 end)

end)

----------------------------------------------------------------------------------------------
---------------------------------------EAT SANDWICH(Hot-Dog) ------------------------------------------
----------------------------------------------------------------------------------------------

RegisterNetEvent('esx_basicneeds:sandwich')
AddEventHandler('esx_basicneeds:sandwich', function()

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
    
    ESX.Game.SpawnObject('prop_cs_hotdog_01', {
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


----------------------------------------------------------------------------------------------
---------------------------------------EAT HAMBURGER ------------------------------------------
----------------------------------------------------------------------------------------------

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

----------------------------------------------------------------------------------------------
---------------------------------------EAT BigMac ------------------------------------------
----------------------------------------------------------------------------------------------

RegisterNetEvent('esx_basicneeds:bigmac')
AddEventHandler('esx_basicneeds:bigmac', function()

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

----------------------------------------------------------------------------------------------
---------------------------------------DRINK COCA---------------------------------------------
----------------------------------------------------------------------------------------------

RegisterNetEvent('esx_basicneeds:coca')
AddEventHandler('esx_basicneeds:coca', function()

  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

	Citizen.CreateThread(function()
    
    local playerPed  = GetPlayerPed(-1)
    local coords     = GetEntityCoords(playerPed)
    local boneIndex  = GetPedBoneIndex(playerPed, 18905)
    local boneIndex2 = GetPedBoneIndex(playerPed, 57005)

      RequestAnimDict('amb@world_human_drinking@beer@male@idle_a')
        
    while not HasAnimDictLoaded('amb@world_human_drinking@beer@male@idle_a') do
      Citizen.Wait(1)
    end
    
    ESX.Game.SpawnObject('prop_ecola_can', {
      x = coords.x,
      y = coords.y,
      z = coords.z - 3
    }, function(object)

    
    Citizen.CreateThread(function()
    
      TaskPlayAnim(playerPed, "amb@world_human_drinking@beer@male@idle_a", "idle_c", 3.5, -8, -1, 49, 0, 0, 0, 0)
      AttachEntityToEntity(object, playerPed, boneIndex2, 0.13, 0.02, -0.05, -85.0, 175.0, 0.0, true, true, false, true, 1, true)
      Citizen.Wait(6500)
      DeleteObject(object)
      ClearPedSecondaryTask(playerPed)
      end)
    end)
  end)
end)

----------------------------------------------------------------------------------------------
---------------------------------------DRINK 7up---------------------------------------------
----------------------------------------------------------------------------------------------

RegisterNetEvent('esx_basicneeds:sprunk')
AddEventHandler('esx_basicneeds:sprunk', function()

  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

	Citizen.CreateThread(function()
    
    local playerPed  = GetPlayerPed(-1)
    local coords     = GetEntityCoords(playerPed)
    local boneIndex  = GetPedBoneIndex(playerPed, 18905)
    local boneIndex2 = GetPedBoneIndex(playerPed, 57005)

      RequestAnimDict('amb@world_human_drinking@beer@male@idle_a')
        
    while not HasAnimDictLoaded('amb@world_human_drinking@beer@male@idle_a') do
      Citizen.Wait(1)
    end
    
    ESX.Game.SpawnObject('prop_ld_can_01', {
      x = coords.x,
      y = coords.y,
      z = coords.z - 3
    }, function(object)

    
    Citizen.CreateThread(function()
    
      TaskPlayAnim(playerPed, "amb@world_human_drinking@beer@male@idle_a", "idle_c", 3.5, -8, -1, 49, 0, 0, 0, 0)
      AttachEntityToEntity(object, playerPed, boneIndex2, 0.13, 0.02, -0.05, -85.0, 175.0, 0.0, true, true, false, true, 1, true)
      Citizen.Wait(6500)
      DeleteObject(object)
      ClearPedSecondaryTask(playerPed)
      end)
    end)
  end)
end)

----------------------------------------------------------------------------------------------
---------------------------------------DRINK EAU---------------------------------------------
----------------------------------------------------------------------------------------------

RegisterNetEvent('esx_basicneeds:water')
AddEventHandler('esx_basicneeds:water', function()

  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

	Citizen.CreateThread(function()
    
    local playerPed  = GetPlayerPed(-1)
    local coords     = GetEntityCoords(playerPed)
    local boneIndex  = GetPedBoneIndex(playerPed, 18905)
    local boneIndex2 = GetPedBoneIndex(playerPed, 57005)

      RequestAnimDict('amb@world_human_drinking@beer@male@idle_a')
        
    while not HasAnimDictLoaded('amb@world_human_drinking@beer@male@idle_a') do
      Citizen.Wait(1)
    end
    
    ESX.Game.SpawnObject('prop_ld_flow_bottle', {
      x = coords.x,
      y = coords.y,
      z = coords.z - 3
    }, function(object)

    
    Citizen.CreateThread(function()
    
      TaskPlayAnim(playerPed, "amb@world_human_drinking@beer@male@idle_a", "idle_c", 3.5, -8, -1, 49, 0, 0, 0, 0)
      AttachEntityToEntity(object, playerPed, boneIndex2, 0.13, 0.02, -0.05, -85.0, 175.0, 0.0, true, true, false, true, 1, true)
      Citizen.Wait(6500)
      DeleteObject(object)
      ClearPedSecondaryTask(playerPed)
      end)
    end)
  end)
end)

-----------------------------------------------------------------------------------------------
---------------------------------------DRINK EAU G---------------------------------------------
-----------------------------------------------------------------------------------------------

RegisterNetEvent('esx_basicneeds:waterg')
AddEventHandler('esx_basicneeds:waterg', function()

  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

	Citizen.CreateThread(function()
    
    local playerPed  = GetPlayerPed(-1)
    local coords     = GetEntityCoords(playerPed)
    local boneIndex  = GetPedBoneIndex(playerPed, 18905)
    local boneIndex2 = GetPedBoneIndex(playerPed, 57005)

      RequestAnimDict('amb@world_human_drinking@beer@male@idle_a')
        
    while not HasAnimDictLoaded('amb@world_human_drinking@beer@male@idle_a') do
      Citizen.Wait(1)
    end
    
    ESX.Game.SpawnObject('prop_ld_flow_bottle', {
      x = coords.x,
      y = coords.y,
      z = coords.z - 3
    }, function(object)

    
    Citizen.CreateThread(function()
    
      TaskPlayAnim(playerPed, "amb@world_human_drinking@beer@male@idle_a", "idle_c", 3.5, -8, -1, 49, 0, 0, 0, 0)
      AttachEntityToEntity(object, playerPed, boneIndex2, 0.13, 0.02, -0.05, -85.0, 175.0, 0.0, true, true, false, true, 1, true)
      Citizen.Wait(6500)
      DeleteObject(object)
      ClearPedSecondaryTask(playerPed)
      end)
    end)
  end)
end)

----------------------------------------------------------------------------------------------
---------------------------------------DRINK SODA---------------------------------------------
----------------------------------------------------------------------------------------------

RegisterNetEvent('esx_basicneeds:soda')
AddEventHandler('esx_basicneeds:soda', function()

  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

	Citizen.CreateThread(function()
    
    local playerPed  = GetPlayerPed(-1)
    local coords     = GetEntityCoords(playerPed)
    local boneIndex  = GetPedBoneIndex(playerPed, 18905)
    local boneIndex2 = GetPedBoneIndex(playerPed, 57005)

      RequestAnimDict('amb@world_human_drinking@beer@male@idle_a')
        
    while not HasAnimDictLoaded('amb@world_human_drinking@beer@male@idle_a') do
      Citizen.Wait(1)
    end
    
    ESX.Game.SpawnObject('prop_orang_can_01', {
      x = coords.x,
      y = coords.y,
      z = coords.z - 3
    }, function(object)

    
    Citizen.CreateThread(function()
    
      TaskPlayAnim(playerPed, "amb@world_human_drinking@beer@male@idle_a", "idle_c", 3.5, -8, -1, 49, 0, 0, 0, 0)
      AttachEntityToEntity(object, playerPed, boneIndex2, 0.13, 0.02, -0.05, -85.0, 175.0, 0.0, true, true, false, true, 1, true)
      Citizen.Wait(6500)
      DeleteObject(object)
      ClearPedSecondaryTask(playerPed)
      end)
    end)
  end)
end)

----------------------------------------------------------------------------------------------
---------------------------------------DRINK COCKTAIL---------------------------------------------
----------------------------------------------------------------------------------------------

RegisterNetEvent('esx_basicneeds:cocktail')
AddEventHandler('esx_basicneeds:cocktail', function()

  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

	Citizen.CreateThread(function()
    
    local playerPed  = GetPlayerPed(-1)
    local coords     = GetEntityCoords(playerPed)
    local boneIndex  = GetPedBoneIndex(playerPed, 18905)
    local boneIndex2 = GetPedBoneIndex(playerPed, 57005)

      RequestAnimDict('amb@world_human_drinking@beer@male@idle_a')
        
    while not HasAnimDictLoaded('amb@world_human_drinking@beer@male@idle_a') do
      Citizen.Wait(1)
    end
    
    ESX.Game.SpawnObject('prop_cocktail', {
      x = coords.x,
      y = coords.y,
      z = coords.z - 3
    }, function(object)

    
    Citizen.CreateThread(function()
    
      TaskPlayAnim(playerPed, "amb@world_human_drinking@beer@male@idle_a", "idle_c", 3.5, -8, -1, 49, 0, 0, 0, 0)
      AttachEntityToEntity(object, playerPed, boneIndex2, 0.13, -0.06, -0.05, -85.0, 175.0, 0.0, true, true, false, true, 1, true)
      Citizen.Wait(6500)
      DeleteObject(object)
      ClearPedSecondaryTask(playerPed)
      end)
    end)
  end)
end)