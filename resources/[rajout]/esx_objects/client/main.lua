ESX = nil
local CurrentActionData   = {}
local lastTime            = 0

Citizen.CreateThread(function()
	while ESX == nil do
	  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	  Citizen.Wait(1)
	end
end)


---- Rose

RegisterNetEvent('esx_items:rose')
AddEventHandler('esx_items:rose', function()

  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

  Citizen.CreateThread(function()
    
    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)
    local boneIndex = GetPedBoneIndex(playerPed, 57005)
        
    RequestAnimDict('amb@code_human_wander_drinking@beer@male@base')
    
    while not HasAnimDictLoaded('amb@code_human_wander_drinking@beer@male@base') do
      Citizen.Wait(1)
    end
    
    ESX.Game.SpawnObject('p_single_rose_s', {
      x = coords.x,
      y = coords.y,
      z = coords.z + 2
    }, function(object)
    
    Citizen.CreateThread(function()
    
      AttachEntityToEntity(object, playerPed, boneIndex, 0.10, 0, -0.001, 80.0, 150.0, 200.0, true, true, false, true, 1, true)
      TaskPlayAnim(playerPed, "amb@code_human_wander_drinking@beer@male@base", "static", 3.5, -8, -1, 49, 0, 0, 0, 0)
      Citizen.Wait(30000)
      DeleteObject(object)
      ClearPedSecondaryTask(playerPed)
      
     end)
    end)
  end)
end)


---- Bong

RegisterNetEvent('esx_items:bong')
AddEventHandler('esx_items:bong', function()

  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

	Citizen.CreateThread(function()
    
    local playerPed  = GetPlayerPed(-1)
    local coords     = GetEntityCoords(playerPed)
    local boneIndex  = GetPedBoneIndex(playerPed, 18905)
    local boneIndex2 = GetPedBoneIndex(playerPed, 57005)

      RequestAnimDict('anim@safehouse@bong')
        
    while not HasAnimDictLoaded('anim@safehouse@bong') do
      Citizen.Wait(1)
    end
    
    ESX.Game.SpawnObject('hei_heist_sh_bong_01', {
      x = coords.x,
      y = coords.y,
      z = coords.z - 3
    }, function(object)

    ESX.Game.SpawnObject('p_cs_lighter_01', {
      x = coords.x,
      y = coords.y,
      z = coords.z - 3
    }, function(object2)
    
    Citizen.CreateThread(function()
    
      TaskPlayAnim(playerPed, "anim@safehouse@bong", "bong_stage1", 3.5, -8, -1, 49, 0, 0, 0, 0)
      Citizen.Wait(1500)
      AttachEntityToEntity(object2, playerPed, boneIndex2, 0.10, 0.0, 0, 99.0, 192.0, 180.0, true, true, false, true, 1, true)
      AttachEntityToEntity(object, playerPed, boneIndex, 0.10, -0.25, 0, 95.0, 190.0, 180.0, true, true, false, true, 1, true)
      Citizen.Wait(6000)
      DeleteObject(object)
      DeleteObject(object2)
      ClearPedSecondaryTask(playerPed)
      TriggerServerEvent('esx_items:bong')
      end)
     end)
    end)
  end)
end)



---- Notepad

RegisterNetEvent('esx_items:notepad')
AddEventHandler('esx_items:notepad', function()

local playerPed = GetPlayerPed(-1)
local coords    = GetEntityCoords(playerPed)

Citizen.CreateThread(function()
  
  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)
  local boneIndex = GetPedBoneIndex(playerPed, 36029)
      
    RequestAnimDict('amb@world_human_clipboard@male@idle_b')
      
  while not HasAnimDictLoaded('amb@world_human_clipboard@male@idle_b') do
    Citizen.Wait(1)
  end

    ESX.Game.SpawnObject('prop_notepad_01', {
      x = coords.x,
      y = coords.y,
      z = coords.z + 2
    }, function(object)
  
      Citizen.CreateThread(function()

        AttachEntityToEntity(object, playerPed, boneIndex, 0.10, 0.08, 0.07, 155.0, 120.0, -180.0, true, true, false, true, 1, true)
        TaskPlayAnim(GetPlayerPed(-1), "amb@world_human_clipboard@male@idle_b", "idle_d" ,3.5, -8, -1, 49, 0,false, false, false )
        Citizen.Wait(25000)
        DeleteObject(object) 
        ClearPedSecondaryTask(playerPed)
      end)
    end)
  end)
end)
---- Ball

RegisterNetEvent('esx_items:ball')
  AddEventHandler('esx_items:ball', function()

    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)

 ESX.Game.SpawnObject('prop_beach_volball01',  {
      x = coords.x +1.5,
      y = coords.y +1.5,
      z = coords.z -1
    }, function(object)
  end)

end)



--- Parapluie

RegisterNetEvent('esx_items:parapluie')
AddEventHandler('esx_items:parapluie', function()

  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

  Citizen.CreateThread(function()
    
    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)
    local boneIndex = GetPedBoneIndex(playerPed, 57005)
        
    RequestAnimDict('amb@code_human_wander_drinking@beer@male@base')
    
    while not HasAnimDictLoaded('amb@code_human_wander_drinking@beer@male@base') do
      Citizen.Wait(1)
    end
    
    ESX.Game.SpawnObject('p_amb_brolly_01', {
      x = coords.x,
      y = coords.y,
      z = coords.z + 2
    }, function(object)
    
    Citizen.CreateThread(function()
    
      AttachEntityToEntity(object, playerPed, boneIndex, 0.10, 0, -0.001, 80.0, 150.0, 200.0, true, true, false, true, 1, true)
      TaskPlayAnim(playerPed, "amb@code_human_wander_drinking@beer@male@base", "static", 3.5, -8, -1, 49, 0, 0, 0, 0)
      Citizen.Wait(30000)
      DeleteObject(object)
      ClearPedSecondaryTask(playerPed)
      
     end)
    end)
  end)
end)

---- Bullet1

RegisterNetEvent('esx_items:bullet1')
  AddEventHandler('esx_items:bullet1', function()

    local playerPed = GetPlayerPed(-1)
      SetPedArmour(playerPed, 50)
      ClearPedBloodDamage(playerPed)
      ResetPedVisibleDamage(playerPed)
      ClearPedLastWeaponDamage(playerPed)

    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function()
      SetPedComponentVariation(GetPlayerPed(-1), 9, 3, 1, 2) --Gilet
    end)

end)


---- Bullet2

RegisterNetEvent('esx_items:bullet2')
  AddEventHandler('esx_items:bullet2', function()

    local playerPed = GetPlayerPed(-1)
      SetPedArmour(playerPed, 75)
      ClearPedBloodDamage(playerPed)
      ResetPedVisibleDamage(playerPed)
      ClearPedLastWeaponDamage(playerPed)

    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function()
      SetPedComponentVariation(GetPlayerPed(-1), 9, 19, 9, 2) --Gilet
    end)

end)


---- Bullet3

RegisterNetEvent('esx_items:bullet3')
  AddEventHandler('esx_items:bullet3', function()

    local playerPed = GetPlayerPed(-1)
      SetPedArmour(playerPed, 100)
      ClearPedBloodDamage(playerPed)
      ResetPedVisibleDamage(playerPed)
      ClearPedLastWeaponDamage(playerPed)

    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function()
      SetPedComponentVariation(GetPlayerPed(-1), 9, 12, 1, 2) --Gilet
    end)

end)

 ---- Bullet4

RegisterNetEvent('esx_items:bullet4')
  AddEventHandler('esx_items:bullet4', function()

    local playerPed = GetPlayerPed(-1)
      SetPedArmour(playerPed, 200)
      ClearPedBloodDamage(playerPed)
      ResetPedVisibleDamage(playerPed)
      ClearPedLastWeaponDamage(playerPed)

    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function()
      SetPedComponentVariation(GetPlayerPed(-1), 9, 27, 9, 2) --Gilet
    end)

end)


--Tenue Hazmat Noir
RegisterNetEvent('esx_objects:settenuehaz1')
AddEventHandler('esx_objects:settenuehaz1', function()
  if UseTenu then

    TriggerEvent('skinchanger:getSkin', function(skin)

        if skin.sex == 0 then
            local clothesSkin = {
                ['tshirt_1']  = 62, ['tshirt_2']  = 1,
                ['torso_1']   = 67, ['torso_2']   = 1,
                ['decals_1']  = 0,  ['decals_2']  = 0,
                ['mask_1']    = 46, ['mask_2']  = 0,
                ['arms']    = 38,
                ['pants_1']   = 40, ['pants_2']   = 1,
                ['shoes_1']   = 25, ['shoes_2']   = 0,
                ['helmet_1']  = -1, ['helmet_2']  = 0,
                ['bags_1']    = 44, ['bags_2']  = 0,
                ['bproof_1']  = 0,  ['bproof_2']  = 0
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        else
            local clothesSkin = {
                ['tshirt_1']  = 43, ['tshirt_2']  = 1,
                ['torso_1']   = 61, ['torso_2']   = 1,
                ['decals_1']  = 0,  ['decals_2']  = 0,
                ['mask_1']    = 46, ['mask_2']  = 0,
                ['arms']    = 101,
                ['pants_1']   = 40, ['pants_2']   = 1,
                ['shoes_1']   = 25, ['shoes_2']   = 0,
                ['helmet_1']  = -1, ['helmet_2']  = 0,
                ['bags_1']    = 44, ['bags_2']  = 0,
                ['bproof_1']  = 0,  ['bproof_2']  = 0
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
          end
          local playerPed = GetPlayerPed(-1)
        ClearPedBloodDamage(playerPed)
        ResetPedVisibleDamage(playerPed)
        ClearPedLastWeaponDamage(playerPed)
      end)
  else

    TriggerEvent('skinchanger:getSkin', function(skin)

      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, hasSkin)

        if hasSkin then

          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        end
      end)
    end)
  end

  UseTenu  = not UseTenu
  GUI.Time = GetGameTimer()

end)

--Tenue Hazmat Bleu
RegisterNetEvent('esx_objects:settenuehaz2')
AddEventHandler('esx_objects:settenuehaz2', function()
  if UseTenu then

    TriggerEvent('skinchanger:getSkin', function(skin)

        if skin.sex == 0 then
            local clothesSkin = {
                ['tshirt_1']  = 62, ['tshirt_2']  = 3,
                ['torso_1']   = 67, ['torso_2']   = 3,
                ['decals_1']  = 0,  ['decals_2']  = 0,
                ['mask_1']    = 46, ['mask_2']  = 0,
                ['arms']    = 38,
                ['pants_1']   = 40, ['pants_2']   = 3,
                ['shoes_1']   = 25, ['shoes_2']   = 0,
                ['helmet_1']  = -1, ['helmet_2']  = 0,
                ['bags_1']    = 44, ['bags_2']  = 0,
                ['bproof_1']  = 0,  ['bproof_2']  = 0
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        else
            local clothesSkin = {
                ['tshirt_1']  = 43, ['tshirt_2']  = 3,
                ['torso_1']   = 61, ['torso_2']   = 3,
                ['decals_1']  = 0,  ['decals_2']  = 0,
                ['mask_1']    = 46, ['mask_2']  = 0,
                ['arms']    = 101,
                ['pants_1']   = 40, ['pants_2']   = 3,
                ['shoes_1']   = 25, ['shoes_2']   = 0,
                ['helmet_1']  = -1, ['helmet_2']  = 0,
                ['bags_1']    = 44, ['bags_2']  = 0,
                ['bproof_1']  = 0,  ['bproof_2']  = 0
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
          end
          local playerPed = GetPlayerPed(-1)
        --SetPedArmour(playerPed, 100)
        ClearPedBloodDamage(playerPed)
        ResetPedVisibleDamage(playerPed)
        ClearPedLastWeaponDamage(playerPed)
      end)
  else

    TriggerEvent('skinchanger:getSkin', function(skin)

      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, hasSkin)

        if hasSkin then

          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        end
      end)
    end)
  end

  UseTenu  = not UseTenu
  GUI.Time = GetGameTimer()

end)


--Tenue Hazmat Jaune
RegisterNetEvent('esx_objects:settenuehaz3')
AddEventHandler('esx_objects:settenuehaz3', function()
  if UseTenu then

    TriggerEvent('skinchanger:getSkin', function(skin)

        if skin.sex == 0 then
            local clothesSkin = {
                ['tshirt_1']  = 62, ['tshirt_2']  = 2,
                ['torso_1']   = 67, ['torso_2']   = 2,
                ['decals_1']  = 0,  ['decals_2']  = 0,
                ['mask_1']    = 46, ['mask_2']  = 0,
                ['arms']    = 38,
                ['pants_1']   = 40, ['pants_2']   = 2,
                ['shoes_1']   = 25, ['shoes_2']   = 0,
                ['helmet_1']  = -1, ['helmet_2']  = 0,
                ['bags_1']    = 44, ['bags_2']  = 0,
                ['bproof_1']  = 0,  ['bproof_2']  = 0
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        else
            local clothesSkin = {
                ['tshirt_1']  = 43, ['tshirt_2']  = 2,
                ['torso_1']   = 61, ['torso_2']   = 2,
                ['decals_1']  = 0,  ['decals_2']  = 0,
                ['mask_1']    = 46, ['mask_2']  = 0,
                ['arms']    = 101,
                ['pants_1']   = 40, ['pants_2']   = 2,
                ['shoes_1']   = 25, ['shoes_2']   = 0,
                ['helmet_1']  = -1, ['helmet_2']  = 0,
                ['bags_1']    = 44, ['bags_2']  = 0,
                ['bproof_1']  = 0,  ['bproof_2']  = 0
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
          end
          local playerPed = GetPlayerPed(-1)
        --SetPedArmour(playerPed, 100)
        ClearPedBloodDamage(playerPed)
        ResetPedVisibleDamage(playerPed)
        ClearPedLastWeaponDamage(playerPed)
      end)
  else

    TriggerEvent('skinchanger:getSkin', function(skin)

      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, hasSkin)

        if hasSkin then

          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        end
      end)
    end)
  end

  UseTenu  = not UseTenu
  GUI.Time = GetGameTimer()

end)


--Tenue Hazmat Blanche
RegisterNetEvent('esx_objects:settenuehaz4')
AddEventHandler('esx_objects:settenuehaz4', function()
  if UseTenu then

    TriggerEvent('skinchanger:getSkin', function(skin)

        if skin.sex == 0 then
            local clothesSkin = {
                ['tshirt_1']  = 62, ['tshirt_2']  = 0,
                ['torso_1']   = 67, ['torso_2']   = 0,
                ['decals_1']  = 0,  ['decals_2']  = 0,
                ['mask_1']    = 46, ['mask_2']  = 0,
                ['arms']    = 38,
                ['pants_1']   = 40, ['pants_2']   = 0,
                ['shoes_1']   = 25, ['shoes_2']   = 0,
                ['helmet_1']  = -1, ['helmet_2']  = 0,
                ['bags_1']    = 44, ['bags_2']  = 0,
                ['bproof_1']  = 0,  ['bproof_2']  = 0
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        else
            local clothesSkin = {
                ['tshirt_1']  = 43, ['tshirt_2']  = 0,
                ['torso_1']   = 61, ['torso_2']   = 0,
                ['decals_1']  = 0,  ['decals_2']  = 0,
                ['mask_1']    = 46, ['mask_2']  = 0,
                ['arms']    = 101,
                ['pants_1']   = 40, ['pants_2']   = 0,
                ['shoes_1']   = 25, ['shoes_2']   = 0,
                ['helmet_1']  = -1, ['helmet_2']  = 0,
                ['bags_1']    = 44, ['bags_2']  = 0,
                ['bproof_1']  = 0,  ['bproof_2']  = 0
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
          end
          local playerPed = GetPlayerPed(-1)
        --SetPedArmour(playerPed, 100)
        ClearPedBloodDamage(playerPed)
        ResetPedVisibleDamage(playerPed)
        ClearPedLastWeaponDamage(playerPed)
      end)
  else

    TriggerEvent('skinchanger:getSkin', function(skin)

      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, hasSkin)

        if hasSkin then

          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        end
      end)
    end)
  end

  UseTenu  = not UseTenu
  GUI.Time = GetGameTimer()

end)

--Tenue Tenue Casa Papel
RegisterNetEvent('esx_objects:settenuecasa')
AddEventHandler('esx_objects:settenuecasa', function()
  if UseTenu then

    TriggerEvent('skinchanger:getSkin', function(skin)

        if skin.sex == 0 then
            local clothesSkin = {
                ['tshirt_1']  = 15, ['tshirt_2']  = 0,
                ['torso_1']   = 65, ['torso_2']   = 0,
                ['decals_1']  = 0,  ['decals_2']  = 0,
                ['mask_1']    = 50, ['mask_2']    = 6,
                ['arms']      = 17,
                ['pants_1']   = 38, ['pants_2']   = 0,
                ['shoes_1']   = 54, ['shoes_2']   = 0,
                ['helmet_1']  = -1, ['helmet_2']  = 0,
                ['bags_1']    = 44, ['bags_2']    = 0,
                ['bproof_1']  = 0,  ['bproof_2']  = 0
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        else
            local clothesSkin = {
                ['tshirt_1']  = 14, ['tshirt_2']  = 0,
                ['torso_1']   = 59, ['torso_2']   = 0,
                ['decals_1']  = 0,  ['decals_2']  = 0,
                ['mask_1']    = 50, ['mask_2']    = 6,
                ['arms']      = 18,
                ['pants_1']   = 38, ['pants_2']   = 0,
                ['shoes_1']   = 55, ['shoes_2']   = 0,
                ['helmet_1']  = -1, ['helmet_2']  = 0,
                ['bags_1']    = 44, ['bags_2']  = 0,
                ['bproof_1']  = 0,  ['bproof_2']  = 0
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
          end
          local playerPed = GetPlayerPed(-1)
        SetPedArmour(playerPed, 100)
        ClearPedBloodDamage(playerPed)
        ResetPedVisibleDamage(playerPed)
        ClearPedLastWeaponDamage(playerPed)
      end)
  else

    TriggerEvent('skinchanger:getSkin', function(skin)

      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, hasSkin)

        if hasSkin then

          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        end
      end)
    end)
  end

  UseTenu  = not UseTenu
  GUI.Time = GetGameTimer()

end)

--Tenue Karting
RegisterNetEvent('esx_objects:settenuekarting1')
AddEventHandler('esx_objects:settenuekarting1', function()
  if UseTenu then

    TriggerEvent('skinchanger:getSkin', function(skin)

        if skin.sex == 0 then
            local clothesSkin = {
                ['tshirt_1']  = 15, ['tshirt_2']  = 0,
                ['torso_1']   = 147,['torso_2']   = 2,
                ['decals_1']  = 0,  ['decals_2']  = 0,
                ['mask_1']    = 0,  ['mask_2']  = 0,
                ['arms']      = 22,
                ['pants_1']   = 66, ['pants_2']   = 2,
                ['shoes_1']   = 46, ['shoes_2']   = 2,
                ['helmet_1']  = 62, ['helmet_2']  = 4,
                ['bags_1']    = 0,  ['bags_2']  = 0,
                ['bproof_1']  = 0,  ['bproof_2']  = 0
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        else
            local clothesSkin = {
                ['tshirt_1']  = 34, ['tshirt_2']  = 0,
                ['torso_1']   = 144,['torso_2']   = 9,
                ['decals_1']  = 0,  ['decals_2']  = 0,
                ['mask_1']    = 0,  ['mask_2']  = 0,
                ['arms']      = 36,
                ['pants_1']   = 68, ['pants_2']   = 9,
                ['shoes_1']   = 47, ['shoes_2']   = 9,
                ['helmet_1']  = 71, ['helmet_2']  = 3,
                ['bags_1']    = 0,  ['bags_2']  = 0,
                ['bproof_1']  = 0,  ['bproof_2']  = 0
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
          end
          local playerPed = GetPlayerPed(-1)
        --SetPedArmour(playerPed, 100)
        ClearPedBloodDamage(playerPed)
        ResetPedVisibleDamage(playerPed)
        ClearPedLastWeaponDamage(playerPed)
      end)
  else

    TriggerEvent('skinchanger:getSkin', function(skin)

      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, hasSkin)

        if hasSkin then

          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        end
      end)
    end)
  end

  UseTenu  = not UseTenu
  GUI.Time = GetGameTimer()

end)

--Tenue Karting boss
RegisterNetEvent('esx_objects:settenuekarting2')
AddEventHandler('esx_objects:settenuekarting2', function()
  if UseTenu then

    TriggerEvent('skinchanger:getSkin', function(skin)

        if skin.sex == 0 then
            local clothesSkin = {
                ['tshirt_1']  = 15, ['tshirt_2']  = 0,
                ['torso_1']   = 147,['torso_2']   = 3,
                ['decals_1']  = 0,  ['decals_2']  = 0,
                ['mask_1']    = 0,  ['mask_2']  = 0,
                ['arms']      = 17,
                ['pants_1']   = 66, ['pants_2']   = 3,
                ['shoes_1']   = 46, ['shoes_2']   = 3,
                ['helmet_1']  = 58, ['helmet_2']  = 2,
                ['bags_1']    = 0,  ['bags_2']  = 0,
                ['bproof_1']  = 0,  ['bproof_2']  = 0
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        else
            local clothesSkin = {
                ['tshirt_1']  = 34, ['tshirt_2']  = 0,
                ['torso_1']   = 144,['torso_2']   = 9,
                ['decals_1']  = 0,  ['decals_2']  = 0,
                ['mask_1']    = 0,  ['mask_2']  = 0,
                ['arms']      = 36,
                ['pants_1']   = 68, ['pants_2']   = 9,
                ['shoes_1']   = 47, ['shoes_2']   = 9,
                ['helmet_1']  = 71, ['helmet_2']  = 3,
                ['bags_1']    = 0,  ['bags_2']  = 0,
                ['bproof_1']  = 0,  ['bproof_2']  = 0
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
          end
          local playerPed = GetPlayerPed(-1)
        --SetPedArmour(playerPed, 100)
        ClearPedBloodDamage(playerPed)
        ResetPedVisibleDamage(playerPed)
        ClearPedLastWeaponDamage(playerPed)
      end)
  else

    TriggerEvent('skinchanger:getSkin', function(skin)

      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, hasSkin)

        if hasSkin then

          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        end
      end)
    end)
  end

  UseTenu  = not UseTenu
  GUI.Time = GetGameTimer()

end)


--Tenue Plongée
RegisterNetEvent('esx_objects:settenueswim')
AddEventHandler('esx_objects:settenueswim', function()
  if UseTenu then
        local player = GetPlayerPed(-1)
        model = GetHashKey("player_zero")
        RequestModel(model)
        while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(1)
        end

        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)

        SetPedComponentVariation(GetPlayerPed(-1), 8, 21, 0, 0) --Bouteilles d'oxy
        SetPedComponentVariation(GetPlayerPed(-1), 6, 3, 0, 0) -- Palmes
        SetPedComponentVariation(GetPlayerPed(-1),3, 4, 0, 0) -- Combi haut
        SetPedComponentVariation(GetPlayerPed(-1),4, 3, 0, 0)-- Combi bas
        SetPedComponentVariation(GetPlayerPed(-1),5, 7, 0, 0)-- Combi bas
        SetPedComponentVariation(GetPlayerPed(-1),2, 1, 0, 0)-- Chauve
        SetPedComponentVariation(GetPlayerPed(-1),9, 7, 0, 0)-- Accessoires

        SetEnableScuba(GetPlayerPed(-1),true)
        SetPedMaxTimeUnderwater(GetPlayerPed(-1), 2500.00)
        onDivingSuit = true

  else

    TriggerEvent('skinchanger:getSkin', function(skin)

      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)

        if skin.sex == 0 then
          local player = GetPlayerPed(-1)
          model2 = GetHashKey("mp_m_freemode_01")
          RequestModel(model2)
          while not HasModelLoaded(model2) do
          RequestModel(model)
          Citizen.Wait(1)
          end

          SetPlayerModel(PlayerId(), model2)
          SetModelAsNoLongerNeeded(model2)

          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        else
          local player = GetPlayerPed(-1)
          model3 = GetHashKey("mp_f_freemode_01")
          RequestModel(model3)
          while not HasModelLoaded(model3) do
          RequestModel(model)
          Citizen.Wait(1)
          end

          SetPlayerModel(PlayerId(), model3)
          SetModelAsNoLongerNeeded(model3)

          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        end
      end)
    end)
  end

  TriggerEvent('esx:restoreLoadout')
  
  local playerPed = GetPlayerPed(-1)
  ClearPedBloodDamage(playerPed)
  ResetPedVisibleDamage(playerPed)
  ClearPedLastWeaponDamage(playerPed)
  UseTenu  = not UseTenu

end)

--Tenue Parachute
RegisterNetEvent('esx_objects:settenueskydivingcl')
AddEventHandler('esx_objects:settenueskydivingcl', function()
  if UseTenu then

    TriggerEvent('skinchanger:getSkin', function(skin)

        if skin.sex == 0 then
            local clothesSkin = {
                ['tshirt_1']  = 15, ['tshirt_2']  = 1,
                ['torso_1']   = 148,['torso_2']   = 1,
                ['decals_1']  = 0,  ['decals_2']  = 0,
                ['mask_1']    = 0,  ['mask_2']  = 0,
                ['arms']      = 17,
                ['pants_1']   = 67, ['pants_2']   = 3,
                ['shoes_1']   = 25, ['shoes_2']   = 0,
                ['helmet_1']  = -1, ['helmet_2']  = 0,
                ['glasses_1']  = 25, ['glasses_2']  = 0,
                ['bags_1']    = 31,  ['bags_2']  = 0,
                ['bproof_1']  = 0,  ['bproof_2']  = 0
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        else
            local clothesSkin = {
                ['tshirt_1']  = 14, ['tshirt_2']  = 0,
                ['torso_1']   = 145,['torso_2']   = 1,
                ['decals_1']  = 0,  ['decals_2']  = 0,
                ['mask_1']    = 0,  ['mask_2']  = 0,
                ['arms']      = 42,
                ['pants_1']   = 69, ['pants_2']   = 1,
                ['shoes_1']   = 25, ['shoes_2']   = 0,
                ['helmet_1']  = 19, ['helmet_2']  = 0,
                ['glasses_1']  = 27, ['glasses_2']  = 0,
                ['bags_1']    = 52,  ['bags_2']  = 9,
                ['bproof_1']  = 0,  ['bproof_2']  = 0
            }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
          end
          local playerPed = GetPlayerPed(-1)
        --SetPedArmour(playerPed, 100)
        ClearPedBloodDamage(playerPed)
        ResetPedVisibleDamage(playerPed)
        ClearPedLastWeaponDamage(playerPed)
      end)
  else

    TriggerEvent('skinchanger:getSkin', function(skin)

      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, hasSkin)

        if hasSkin then

          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        end
      end)
    end)
  end

  UseTenu  = not UseTenu
  GUI.Time = GetGameTimer()

end)


--Tenue Jailer
RegisterNetEvent('esx_objects:settenuejailer')
AddEventHandler('esx_objects:settenuejailer', function()
  if UseTenu then

    TriggerEvent('skinchanger:getSkin', function(skin)

				if skin.sex == 0 then

					local clothesSkin = {
						['tshirt_1'] = 15, ['tshirt_2'] = 0,
						['torso_1'] = 146, ['torso_2'] = 0,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 0,
						['pants_1'] = 3, ['pants_2'] = 7,
						['shoes_1'] = 12, ['shoes_2'] = 12,
						['chain_1'] = 0, ['chain_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

				else

					local clothesSkin = {
						['tshirt_1'] = 3, ['tshirt_2'] = 0,
						['torso_1'] = 38, ['torso_2'] = 3,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 2,
						['pants_1'] = 3, ['pants_2'] = 15,
						['shoes_1'] = 66, ['shoes_2'] = 5,
						['chain_1'] = 0, ['chain_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

				end

				local playerPed = GetPlayerPed(-1)
				ClearPedBloodDamage(playerPed)
				ResetPedVisibleDamage(playerPed)
				ClearPedLastWeaponDamage(playerPed)
				ResetPedMovementClipset(playerPed, 0)
			end)
  else

    TriggerEvent('skinchanger:getSkin', function(skin)

      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, hasSkin)

        if hasSkin then

          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        end
      end)
    end)
  end

  UseTenu  = not UseTenu
  GUI.Time = GetGameTimer()

end)


---- Key Controls

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(1)

      if CurrentAction ~= nil then
         
        SetTextComponentFormat('STRING')
        AddTextComponentString(CurrentActionMsg)
        DisplayHelpTextFromStringLabel(0, 0, 1, -1)
        
      if IsControlJustReleased(0, 38) then              

        if CurrentAction == 'remove_entity' then
          DeleteEntity(CurrentActionData.entity)
        end

        if CurrentAction == 'open_bin' then
          if GetGameTimer() - lastTime >= 15000 then 
            OpenBin()
            lastTime = GetGameTimer()
          end
        end

          CurrentAction = nil               
      end
    end
  end
end)



