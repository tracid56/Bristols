
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

ESX                           = nil
TimeDiff                      = 0
CurrentAlcool                 = nil
SpawnedObjects                = {}
SpawnedPeds                   = {}
local PlayerData              = {}
local GUI                     = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local LastPart                = nil
local LastData                = {}
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local OnJob                   = false
local TargetCoords            = nil
local CurrentlyTowedVehicle   = nil
local PedBlacklist            = {}
local PedAttacking            = nil
local Blips                   = {}
local JobBlips                = {}
GUI.Time                      = 0

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
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
		       TriggerServerEvent('esx_unicorn:annonce',result)
		        
		    end


		end
	end)
	
end

RegisterNetEvent('esx_unicorn:setTimeDiff')
AddEventHandler('esx_unicorn:setTimeDiff', function(time)
  TimeDiff = GetPosixTime() - time 
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
  CreateJobBlips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
  DeleteJobBlips()
  CreateJobBlips()
end)

function IsJobTrue()
  if PlayerData ~= nil then
    local IsJobTrue = false
    if PlayerData.job ~= nil and PlayerData.job.name == 'unicorn' then
      IsJobTrue = true
    end
    return IsJobTrue
  end
end

function CreateJobBlips()
    if IsJobTrue() then               
      local blip = AddBlipForCoord(Config.Zones.Farm1.Pos.x, Config.Zones.Farm1.Pos.y, Config.Zones.Farm1.Pos.z)
      SetBlipSprite (blip, 238)
      SetBlipDisplay(blip, 4)
      SetBlipScale  (blip, 1.2)
      SetBlipColour (blip, 56)
      SetBlipAsShortRange(blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString("Récolte Unicorn")
      EndTextCommandSetBlipName(blip)
      table.insert(JobBlips, blip) 
    end
    
    if IsJobTrue() then
      local blip2 = AddBlipForCoord(Config.Zones.Farm2.Pos.x, Config.Zones.Farm2.Pos.y, Config.Zones.Farm2.Pos.z)
      SetBlipSprite (blip2, 238)
      SetBlipDisplay(blip2, 4)
      SetBlipScale  (blip2, 1.2)
      SetBlipColour (blip2, 56)
      SetBlipAsShortRange(blip2, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString("Récolte Unicorn")
      EndTextCommandSetBlipName(blip2)
      table.insert(JobBlips, blip2) 
    end    
end

function DeleteJobBlips()
  if JobBlips[1] ~= nil then
    for i=1, #JobBlips, 1 do
      RemoveBlip(JobBlips[i])
      JobBlips[i] = nil
    end
  end
end


function SetVehicleMaxMods(vehicle)

  local props = {
    modEngine       = 3,
    modBrakes       = 3,
    modTransmission = 3,
    modSuspension   = 3,
    modTurbo        = true,
  }

  ESX.Game.SetVehicleProperties(vehicle, props)

end

function StartWalking(ped)
  Citizen.CreateThread(function()
    RequestAnimDict('move_m@generic_variations@walk')
    while not HasAnimDictLoaded('move_m@generic_variations@walk') do
      Citizen.Wait(1)
    end
    TaskPlayAnim(ped,  'move_m@generic_variations@walk',  'walk_a',  1.0,  -1.0,  -1,  0,  1,  false,  false,  false)
  end)
end

function OpenDiscoActionsMenu()

  local elements = {
    {label = _U('deposit_stock'), value = 'put_stock'},
    {label = _U('withdraw_stock'), value = 'get_stock'}
 }
  if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.grade_name == 'boss' or PlayerData.job.grade_name == 'gerant' then
    table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
  end

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'unicorn_actions',
    {
      css = 'unicorn',
      title    = _U('unicorn'),
      elements = elements
    },
    function(data, menu)

      if data.current.value == 'vehicle_list' then

        if Config.EnableSocietyOwnedVehicles then

            local elements = {}

            ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)

              for i=1, #vehicles, 1 do
                table.insert(elements, {label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']', value = vehicles[i]})
              end

              ESX.UI.Menu.Open(
                'default', GetCurrentResourceName(), 'vehicle_spawner',
                {
                  css = 'unicorn',
                  title    = _U('service_vehicle'),
                  align    = 'top-left',
                  elements = elements,
                },
                function(data, menu)

                  menu.close()

                  local vehicleProps = data.current.value
                  local playerPed = GetPlayerPed(-1)
                  local coords    = Config.Zones.VehicleSpawnPoint.Pos
                  local platenum = math.random(100, 900)

                  ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPoint.Pos, 270.0, function(vehicle)
                  ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
                  SetVehicleNumberPlateText(vehicle, "UCN" .. platenum)
                  TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
                  local plate = GetVehicleNumberPlateText(vehicle)
              	  plate = string.gsub(plate, " ", "")
                  TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
                  end)

                  TriggerServerEvent('esx_society:removeVehicleFromGarage', 'unicorn', vehicleProps)

                end,

                function(data, menu)
                  menu.close()
                end
              )

            end, 'unicorn')

          else

            local elements = {
              {label = 'Livraison', value = 'burrito3'},
              {label = 'Chef Equipe', value = 'brioso'}
            }

            if Config.EnablePlayerManagement and PlayerData.job ~= nil and
              (PlayerData.job.grade_name == 'boss') then
              table.insert(elements, {label = 'Véhicule Patron', value = 'cognoscenti'})
            end

            ESX.UI.Menu.CloseAll()

            ESX.UI.Menu.Open(
              'default', GetCurrentResourceName(), 'spawn_vehicle',
              {
                css = 'unicorn',
                title    = _U('service_vehicle'),
                elements = elements
              },
              function(data, menu)
                for i=1, #elements, 1 do

                	local playerPed = GetPlayerPed(-1)
                  local platenum = math.random(100, 900)

                  if Config.MaxInService == -1 then

                    ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 90.0, function(vehicle)
                      local playerPed = GetPlayerPed(-1)
                      local platenum = math.random(100, 900)
                      SetVehicleNumberPlateText(vehicle, "UCN" .. platenum)
                      TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                      local plate = GetVehicleNumberPlateText(vehicle)
                      plate = string.gsub(plate, " ", "")
                      TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock

                    end)

                    break

                  else

                    ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)

                      if canTakeService then

                        ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 90.0, function(vehicle)
                          local playerPed = GetPlayerPed(-1)
                          local platenum = math.random(100, 900)
                          SetVehicleNumberPlateText(vehicle, "UCN" .. platenum)
                          TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
                          local plate = GetVehicleNumberPlateText(vehicle)
                          plate = string.gsub(plate, " ", "")
                          TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock

                        end)

                      else

                        ESX.ShowNotification(_U('service_full') .. inServiceCount .. '/' .. maxInService)
                      end

                    end, 'unicorn')

                    break

                  end

                end
                menu.close()
              end,
              function(data, menu)
                menu.close()
                OpenDiscoActionsMenu()
              end
            )

          end
      end

      if data.current.value == 'cloakroom' then
      TriggerServerEvent("player:serviceOn", "unicorn")	
        menu.close()
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

            if skin.sex == 0 then
                TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
            else
                TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
            end

        end)
      end

      if data.current.value == 'cloakroom2' then
      TriggerServerEvent("player:serviceOff", "unicorn")	
        menu.close()
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

            TriggerEvent('skinchanger:loadSkin', skin)

        end)
      end

      if data.current.value == 'put_stock' then
        OpenPutStocksMenu()
      end

      if data.current.value == 'get_stock' then
        OpenGetStocksMenu()
      end

      if data.current.value == 'boss_actions' then
        TriggerEvent('esx_society:openBossMenu', 'unicorn', function(data, menu)
          menu.close()
        end)
      end

    end,
    function(data, menu)
      menu.close()
      CurrentAction     = 'unicorn_actions_menu'
      CurrentActionMsg  = _U('open_actions')
      CurrentActionData = {}
    end
  )
end

function OpenDiscoHarvestMenu()

  --if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.grade_name ~= 'recrue' then
    local elements = {
      {label = 'Menthe', value = 'menthe'},
      {label = 'Patate', value = 'patate'},
      {label = 'Raisin', value = 'raisin'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'unicorn_harvest',
      {
        css = 'unicorn',
        title    = _U('harvest'),
        elements = elements
      },
      function(data, menu)
        if data.current.value == 'menthe' then
          menu.close()
          TriggerServerEvent('esx_unicorn:startHarvest')
        end

        if data.current.value == 'patate' then
          menu.close()
          TriggerServerEvent('esx_unicorn:startHarvest2')
        end

        if data.current.value == 'raisin' then
          menu.close()
          TriggerServerEvent('esx_unicorn:startHarvest3')
        end

      end,
      function(data, menu)
        menu.close()
        CurrentAction     = 'unicorn_harvest_menu'
        CurrentActionMsg  = _U('harvest_menu')
        CurrentActionData = {}
      end
    )
  --else
  --  ESX.ShowNotification(_U('not_experienced_enough'))
  --end
end

function OpenDiscoHarvest2Menu()

 -- if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.grade_name ~= 'recrue' then
    local elements = {
      {label = 'Houblon', value = 'houblon'},
      {label = 'Malte', value = 'malte'},
      {label = 'Sucre', value = 'sucre'},
      {label = 'Fruits', value = 'fruits'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'unicorn_harvest2',
      {
        css = 'unicorn',
        title    = _U('harvest'),
        elements = elements
      },
      function(data, menu)
        if data.current.value == 'houblon' then
          menu.close()
          TriggerServerEvent('esx_unicorn:startHarvest4')
        end

        if data.current.value == 'malte' then
          menu.close()
          TriggerServerEvent('esx_unicorn:startHarvest5')
        end

        if data.current.value == 'sucre' then
          menu.close()
          TriggerServerEvent('esx_unicorn:startHarvest6')
        end

        if data.current.value == 'fruits' then
          menu.close()
          TriggerServerEvent('esx_unicorn:startHarvest7')
        end   
      end,
      function(data, menu)
        menu.close()
        CurrentAction     = 'unicorn_harvest2_menu'
        CurrentActionMsg  = _U('harvest_menu')
        CurrentActionData = {}
      end
    )
  --else
  --  ESX.ShowNotification(_U('not_experienced_enough'))
  --end
end

function OpenDiscoCraftMenu()
  --if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.grade_name ~= 'recrue' then

    local elements = {
      {label = 'Mojito', value = 'mojito'},
      {label = 'Vodka', value = 'vodka'},
      {label = 'Champagne', value = 'champagne'},
      {label = 'Bières', value = 'beer'},
      {label = 'Whisky', value = 'whisky'},
      {label = 'Rhum', value = 'rhum'},
      {label = 'Cocktail', value = 'cocktail'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'unicorn_craft',
      {
        css = 'unicorn',
        title    = _U('craft'),
        elements = elements
      },
      function(data, menu)

        if data.current.value == 'mojito' then
          menu.close()
          TriggerServerEvent('esx_unicorn:startCraft')
        end

        if data.current.value == 'vodka' then
          menu.close()
          TriggerServerEvent('esx_unicorn:startCraft2')
        end

        if data.current.value == 'champagne' then
          menu.close()
          TriggerServerEvent('esx_unicorn:startCraft3')
        end
    
        if data.current.value == 'beer' then
          menu.close()
          TriggerServerEvent('esx_unicorn:startCraft4')
        end

        if data.current.value == 'whisky' then
          menu.close()
          TriggerServerEvent('esx_unicorn:startCraft5')
        end

        if data.current.value == 'rhum' then
          menu.close()
          TriggerServerEvent('esx_unicorn:startCraft6')
        end
        
        if data.current.value == 'cocktail' then
          menu.close()
          TriggerServerEvent('esx_unicorn:startCraft7')
        end

      end,
      function(data, menu)
        menu.close()
        CurrentAction     = 'unicorn_craft_menu'
        CurrentActionMsg  = _U('craft_menu')
        CurrentActionData = {}
      end
    )
  --else
    --ESX.ShowNotification(_U('not_experienced_enough'))
  --end
end

function OpenFactuDiscoActionsMenu()

ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'factu_unicorn_actions',
    {
      css = 'unicorn',
      title    = 'Unicorn Facturation',
      align    = 'top-left',
      elements = {
        {label = 'Intéraction Client',    value = 'facture_client'},
        {label = 'Annonce',    value = 'announce'}       
      },
    },


    function(data, menu)

      if data.current.value == 'facture_client' then

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'facture_client',
          {
            css = 'unicorn',
            title    = 'Facturation Client',
            align    = 'top-left',
            elements = {

              {label = 'Facture',       value = 'billing'}              
            },
          },
             
          function(data2, menu2)
                
            local player, distance = ESX.Game.GetClosestPlayer()        

            if distance ~= -1 and distance <= 3.0 then
            
              if data2.current.value == 'billing' then
                ESX.UI.Menu.Open(
                  'dialog', GetCurrentResourceName(), 'billing',
                  {
                    title = _U('invoice_amount')
                  },
                  function(data2, menu2)
                    local amount = tonumber(data2.value)
                    if amount == nil then
                        ESX.ShowNotification(_U('amount_invalid'))
                      else
                      menu2.close()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                      if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification(_U('no_players_nearby'))
                      else
                        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_unicorn', _U('unicorn'), amount)
                      end
                    end
                  end,
                function(data2, menu2)
                  menu2.close()
                end                  
                )
              end

            else
              ESX.ShowNotification(_U('no_players_nearby'))
            end    
          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end

      if data.current.value == 'announce' then
        messagenotfinish = true
      Message()
    end      

    end,
    function(data, menu)
      menu.close()
    end
  )

end

function OpenGetStocksMenu()

  ESX.TriggerServerCallback('esx_unicorn:getStockItems', function(items)

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
        css = 'unicorn',
        title    = _U('mechanic_stock'),
        elements = elements
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
          {
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

              TriggerServerEvent('esx_unicorn:getStockItem', itemName, count)
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

ESX.TriggerServerCallback('esx_unicorn:getPlayerInventory', function(inventory)

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
        css = 'unicorn',
        title    = _U('inventory'),
        elements = elements
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count',
          {
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

              TriggerServerEvent('esx_unicorn:putStockItems', itemName, count)
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

AddEventHandler('esx_unicorn:hasEnteredMarker', function(zone)

  if zone == 'DiscoActions' then
    CurrentAction     = 'unicorn_actions_menu'
    CurrentActionMsg  = _U('open_actions')
    CurrentActionData = {}
  end

  if zone == 'VehicleActions' then
    CurrentAction     = 'unicorn_vehicles_menu'
    CurrentActionMsg  = _U('open_actions')
    CurrentActionData = {}
  end

  if zone == 'TenuesActions' then
    CurrentAction     = 'unicorn_tenues_menu'
    CurrentActionMsg  = _U('open_actions')
    CurrentActionData = {}
  end

  if zone == 'StockActions' then
    CurrentAction     = 'unicorn_stock_menu'
    CurrentActionMsg  = _U('open_actions')
    CurrentActionData = {}
  end

  if zone == 'Farm1' then
    CurrentAction     = 'unicorn_harvest_menu'
    CurrentActionMsg  = _U('harvest_menu')
    CurrentActionData = {}
  end
  
  if zone == 'Farm2' then
    CurrentAction     = 'unicorn_harvest2_menu'
    CurrentActionMsg  = _U('harvest_menu')
    CurrentActionData = {}
  end  

  if zone == 'Craft' then
    CurrentAction     = 'unicorn_craft_menu'
    CurrentActionMsg  = _U('craft_menu')
    CurrentActionData = {}
  end
  
  if zone == 'VehicleDeleter' then

    local playerPed = GetPlayerPed(-1)

    if IsPedInAnyVehicle(playerPed,  false) then

      local vehicle = GetVehiclePedIsIn(playerPed,  false)

      CurrentAction     = 'delete_vehicle'
      CurrentActionMsg  = _U('veh_stored')
      CurrentActionData = {vehicle = vehicle}
    end
  end

end)


AddEventHandler('esx_unicorn:hasExitedMarker', function(zone)

  if zone == 'Craft' then
    TriggerServerEvent('esx_unicorn:stopCraft')
    TriggerServerEvent('esx_unicorn:stopCraft2')
    TriggerServerEvent('esx_unicorn:stopCraft3')
    TriggerServerEvent('esx_unicorn:stopCraft4')
    TriggerServerEvent('esx_unicorn:stopCraft5')
    TriggerServerEvent('esx_unicorn:stopCraft6')
    TriggerServerEvent('esx_unicorn:stopCraft7')
  end

  if zone == 'Farm1' then
    TriggerServerEvent('esx_unicorn:stopHarvest')
    TriggerServerEvent('esx_unicorn:stopHarvest2')
    TriggerServerEvent('esx_unicorn:stopHarvest3')
  end

  if zone == 'Farm2' then
    TriggerServerEvent('esx_unicorn:stopHarvest4')
    TriggerServerEvent('esx_unicorn:stopHarvest5')
    TriggerServerEvent('esx_unicorn:stopHarvest6')
    TriggerServerEvent('esx_unicorn:stopHarvest7')
  end  

  CurrentAction = nil
  ESX.UI.Menu.CloseAll()
end)


-- Create Blips
Citizen.CreateThread(function()  
  if PlayerData.job ~= nil and PlayerData.job.name == 'unicorn' then
    local blip = AddBlipForCoord(Config.Zones.Farm1.Pos.x, Config.Zones.Farm1.Pos.y, Config.Zones.Farm1.Pos.z)
    SetBlipSprite (blip, 238)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 1.2)
    SetBlipColour (blip, 56)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Récolte Unicorn")
    EndTextCommandSetBlipName(blip)
  end
end)
-- Create Blips
Citizen.CreateThread(function()
  if PlayerData.job ~= nil and PlayerData.job.name == 'unicorn' then  
    local blip = AddBlipForCoord(Config.Zones.Farm2.Pos.x, Config.Zones.Farm2.Pos.y, Config.Zones.Farm2.Pos.z)
    SetBlipSprite (blip, 238)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 1.2)
    SetBlipColour (blip, 56)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Récolte Unicorn")
    EndTextCommandSetBlipName(blip)
  end  
end)



-- Display markers
Citizen.CreateThread(function()
  while true do
    Wait(0)
    if PlayerData.job ~= nil and PlayerData.job.name == 'unicorn' then

      local coords = GetEntityCoords(GetPlayerPed(-1))

      for k,v in pairs(Config.Zones) do
        if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
          DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
        end
      end
    end
  end
end)


-- Enter / Exit marker events
Citizen.CreateThread(function()
  while true do
    Wait(0)
    if PlayerData.job ~= nil and PlayerData.job.name == 'unicorn' then
      local coords      = GetEntityCoords(GetPlayerPed(-1))
      local isInMarker  = false
      local currentZone = nil
      for k,v in pairs(Config.Zones) do
        if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
          isInMarker  = true
          currentZone = k
        end
      end
      if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
        HasAlreadyEnteredMarker = true
        LastZone                = currentZone
        TriggerEvent('esx_unicorn:hasEnteredMarker', currentZone)
      end
      if not isInMarker and HasAlreadyEnteredMarker then
        HasAlreadyEnteredMarker = false
        TriggerEvent('esx_unicorn:hasExitedMarker', LastZone)
      end
    end
  end
end)



-- Key Controls
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if CurrentAction ~= nil then

          SetTextComponentFormat('STRING')
          AddTextComponentString(CurrentActionMsg)
          DisplayHelpTextFromStringLabel(0, 0, 1, -1)

          if IsControlJustReleased(0, 38) and PlayerData.job ~= nil and PlayerData.job.name == 'unicorn' then

            if CurrentAction == 'unicorn_actions_menu' then
                OpenDiscoActionsMenu()
            end

            if CurrentAction == 'unicorn_vehicles_menu' then
                OpenDiscoVehicleMenu()
            end

            if CurrentAction == 'unicorn_tenues_menu' then
                OpenDiscoTenuesMenu()
            end

            if CurrentAction == 'unicorn_stock_menu' then
                OpenDiscoStockBarMenu()
            end

            if CurrentAction == 'unicorn_harvest_menu' then
                OpenDiscoHarvestMenu()
            end

            if CurrentAction == 'unicorn_craft_menu' then
                OpenDiscoCraftMenu()
            end
            
            if CurrentAction == 'unicorn_harvest2_menu' then
                OpenDiscoHarvest2Menu()
            end

            if CurrentAction == 'delete_vehicle' then

              if Config.EnableSocietyOwnedVehicles then

                local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
                TriggerServerEvent('esx_society:putVehicleInGarage', 'unicorn', vehicleProps)

              else

                if
                  GetEntityModel(vehicle) == GetHashKey('burrito3')   or
                  GetEntityModel(vehicle) == GetHashKey('brioso') or
                  GetEntityModel(vehicle) == GetHashKey('cognoscenti')
                then
                  TriggerServerEvent('esx_service:disableService', 'unicorn')
                end

              end

              local plate = GetVehicleNumberPlateText(vehicle)

              ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
              TriggerServerEvent('esx_vehiclelock:deletekeyjobs', 'no', plate) --vehicle lock
            end
            CurrentAction = nil
          end
        end            

        if IsControlJustReleased(0, Keys['F6']) and PlayerData.job ~= nil and PlayerData.job.name == 'unicorn' then
            OpenFactuDiscoActionsMenu()
        end        

        if IsControlJustReleased(0, Keys['F10']) and PlayerData.job ~= nil and PlayerData.job.name == 'unicorn' then

          local playerPed = GetPlayerPed(-1)
          local coords    = GetEntityCoords(playerPed)
          
          local closestPed, closestDistance = ESX.Game.GetClosestPed({
            x = coords.x,
            y = coords.y,
            z = coords.z
          }, {playerPed})

          -- Fallback code
          if closestDistance == -1 then
            
            print('Using fallback code to find ped')

            local success, ped = GetClosestPed(coords.x,  coords.y,  coords.z,  5.0, 1, 0, 0, 0,  26)

            if DoesEntityExist(ped) then
              local pedCoords = GetEntityCoords(ped)
              closestPed      = ped
              closestDistance = GetDistanceBetweenCoords(coords.x,  coords.y,  coords.z,  pedCoords.x,  pedCoords.y,  pedCoords.z,  true)
            end

          end

          if closestPed ~= -1 and closestDistance <= 5.0 then

            if IsPedInAnyVehicle(closestPed,  false) then
              ESX.ShowNotification('Action ~r~impossible~s~, cette personne est en voiture')
            else

              local playerData    = ESX.GetPlayerData()
              local isBlacklisted = false

              for i=1, #PedBlacklist, 1 do
                if PedBlacklist[i] == closestPed then
                  isBlacklisted = true
                end
              end

              if isBlacklisted then
                ESX.ShowNotification('Vous avez déjà traité avec ce client')
              else

                table.insert(PedBlacklist, closestPed)

                local hasAlcool = {}

                for i=1, #playerData.inventory, 1 do
                  for j=1, #Config.Alcool, 1 do
                    if playerData.inventory[i].name == Config.Alcool[j] and playerData.inventory[i].count > 0 then
                      table.insert(hasAlcool,  Config.Alcool[j])
                    end
                  end
                end

                if #hasAlcool > 0 then

                  local magic = GetRandomIntInRange(1, 100)

                  TaskStandStill(closestPed,  -1)
                  TaskLookAtEntity(closestPed,  playerPed,  -1,  2048,  3)

                  if magic <= 1 then

                    ESX.ShowNotification('Le client a refusé votre alcool !')

                    TaskStandStill(closestPed,  -1)

                    ESX.SetTimeout(5000, function()

                      StartWalking(closestPed)

                      ESX.SetTimeout(20000, function()

                        TaskStartScenarioInPlace(closestPed, 'WORLD_HUMAN_STAND_MOBILE', 0, true);

                        TriggerServerEvent('esx_unicorn:pedCallPolice')

                        ESX.SetTimeout(20000, function()
                          StartWalking(closestPed)
                        end)

                      end)

                    end)

                  elseif magic <= 30 then
                    
                    ESX.ShowNotification('Le client n\'a pas acheté votre alcool !')
                    StartWalking(closestPed)

                  elseif magic <= 70 then

                    ESX.ShowNotification('Le client a acheté votre alcool plus cher !')

                    TriggerServerEvent('esx_unicorn:pedBuyAlcool', false)

                    ESX.SetTimeout(5000, function()
                      StartWalking(closestPed)
                    end)

                  elseif magic <= 90 then

                    PedAttacking = closestPed
                    
                    SetPedAlertness(closestPed,  3)
                    SetPedCombatAttributes(closestPed,  46,  true)

                    ESX.SetTimeout(120000, function()
                      PedAttacking = nil
                    end)

                  else
                    
                    TriggerServerEvent('esx_unicorn:pedBuyAlcool', true)
                    
                    ESX.ShowNotification('Le client a acheté votre alcool au prix fort !!')

                    TaskStandStill(closestPed,  -1)

                    ESX.SetTimeout(5000, function()
                      StartWalking(closestPed)
                    end)
                  
                  end

                else
                  ESX.ShowNotification('Vous n\'avez pas d\'alcools sur vous')
                end

              end

            end

          else
            ESX.ShowNotification('Personne à proximité')
          end

        end

    end
end)

Citizen.CreateThread(function()
  while true do

    Citizen.Wait(0)

    if PedAttacking ~= nil then
      TaskCombatPed(PedAttacking,  GetPlayerPed(-1),  0,  16)
    end

  end
end)



-- mojito Effect
RegisterNetEvent('esx_unicorn:drinkmojito')
AddEventHandler('esx_unicorn:drinkmojito', function()
  RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
    while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
        Citizen.Wait(0)
    end
    TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_DRINKING", 0, true)
        Citizen.Wait(5000)
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        ClearPedTasksImmediately(GetPlayerPed(-1))
        SetTimecycleModifier("spectator5")
        SetPedMotionBlur(GetPlayerPed(-1), true)
        SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
        SetPedIsDrunk(GetPlayerPed(-1), true)
        DoScreenFadeIn(1000)
        Citizen.Wait(150000)
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        DoScreenFadeIn(1000)
        ClearTimecycleModifier()
        ResetScenarioTypesEnabled()
        ResetPedMovementClipset(GetPlayerPed(-1), 0)
        SetPedIsDrunk(GetPlayerPed(-1), false)
        SetPedMotionBlur(GetPlayerPed(-1), false)
end)

-- vodka Effect
RegisterNetEvent('esx_unicorn:drinkvodka')
AddEventHandler('esx_unicorn:drinkvodka', function()
  RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK")
    while not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") do
        Citizen.Wait(0)
    end
    TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_DRINKING", 0, true)
        Citizen.Wait(5000)
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        ClearPedTasksImmediately(GetPlayerPed(-1))
        SetTimecycleModifier("spectator5")
        SetPedMotionBlur(GetPlayerPed(-1), true)
        SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
        SetPedIsDrunk(GetPlayerPed(-1), true)
        DoScreenFadeIn(1000)
        Citizen.Wait(250000)
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        DoScreenFadeIn(1000)
        ClearTimecycleModifier()
        ResetScenarioTypesEnabled()
        ResetPedMovementClipset(GetPlayerPed(-1), 0)
        SetPedIsDrunk(GetPlayerPed(-1), false)
        SetPedMotionBlur(GetPlayerPed(-1), false)
end)

-- champagne Effect
RegisterNetEvent('esx_unicorn:drinkchampagne')
AddEventHandler('esx_unicorn:drinkchampagne', function()
  RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK")
    while not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") do
        Citizen.Wait(0)
    end
    TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_DRINKING", 0, true)
        Citizen.Wait(5000)
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        ClearPedTasksImmediately(GetPlayerPed(-1))
        SetTimecycleModifier("spectator5")
        SetPedMotionBlur(GetPlayerPed(-1), true)
        SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@VERYDRUNK", true)
        SetPedIsDrunk(GetPlayerPed(-1), true)
        DoScreenFadeIn(1000)
        Citizen.Wait(350000)
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        DoScreenFadeIn(1000)
        ClearTimecycleModifier()
        ResetScenarioTypesEnabled()
        ResetPedMovementClipset(GetPlayerPed(-1), 0)
        SetPedIsDrunk(GetPlayerPed(-1), false)
        SetPedMotionBlur(GetPlayerPed(-1), false)
end)

-- bières Effect
RegisterNetEvent('esx_unicorn:drinkbeer')
AddEventHandler('esx_unicorn:drinkbeer', function()
  RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK")
    while not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") do
        Citizen.Wait(0)
    end
    TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_DRINKING", 0, true)
        Citizen.Wait(5000)
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        ClearPedTasksImmediately(GetPlayerPed(-1))
        SetTimecycleModifier("spectator5")
        SetPedMotionBlur(GetPlayerPed(-1), true)
        SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@VERYDRUNK", true)
        SetPedIsDrunk(GetPlayerPed(-1), true)
        DoScreenFadeIn(1000)
        Citizen.Wait(350000)
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        DoScreenFadeIn(1000)
        ClearTimecycleModifier()
        ResetScenarioTypesEnabled()
        ResetPedMovementClipset(GetPlayerPed(-1), 0)
        SetPedIsDrunk(GetPlayerPed(-1), false)
        SetPedMotionBlur(GetPlayerPed(-1), false)
end)

-- whisky Effect
RegisterNetEvent('esx_unicorn:drinkwhisky')
AddEventHandler('esx_unicorn:drinkwhisky', function()
  RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK")
    while not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") do
        Citizen.Wait(0)
    end
    TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_DRINKING", 0, true)
        Citizen.Wait(5000)
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        ClearPedTasksImmediately(GetPlayerPed(-1))
        SetTimecycleModifier("spectator5")
        SetPedMotionBlur(GetPlayerPed(-1), true)
        SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@VERYDRUNK", true)
        SetPedIsDrunk(GetPlayerPed(-1), true)
        DoScreenFadeIn(1000)
        Citizen.Wait(350000)
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        DoScreenFadeIn(1000)
        ClearTimecycleModifier()
        ResetScenarioTypesEnabled()
        ResetPedMovementClipset(GetPlayerPed(-1), 0)
        SetPedIsDrunk(GetPlayerPed(-1), false)
        SetPedMotionBlur(GetPlayerPed(-1), false)
end)

-- rhum Effect
RegisterNetEvent('esx_unicorn:drinkrhum')
AddEventHandler('esx_unicorn:drinkrhum', function()
  RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK")
    while not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") do
        Citizen.Wait(0)
    end
    TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_DRINKING", 0, true)
        Citizen.Wait(5000)
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        ClearPedTasksImmediately(GetPlayerPed(-1))
        SetTimecycleModifier("spectator5")
        SetPedMotionBlur(GetPlayerPed(-1), true)
        SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@VERYDRUNK", true)
        SetPedIsDrunk(GetPlayerPed(-1), true)
        DoScreenFadeIn(1000)
        Citizen.Wait(400000)
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        DoScreenFadeIn(1000)
        ClearTimecycleModifier()
        ResetScenarioTypesEnabled()
        ResetPedMovementClipset(GetPlayerPed(-1), 0)
        SetPedIsDrunk(GetPlayerPed(-1), false)
        SetPedMotionBlur(GetPlayerPed(-1), false)
end)

-- Wine Effect
RegisterNetEvent('esx_unicorn:drinkwine')
AddEventHandler('esx_unicorn:drinkwine', function()
	RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
    while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
        Citizen.Wait(0)
    end
    TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_DRINKING", 0, true)
       	Citizen.Wait(5000)
       	DoScreenFadeOut(1000)
       	Citizen.Wait(1000)
       	ClearPedTasksImmediately(GetPlayerPed(-1))
       	SetTimecycleModifier("spectator5")
       	SetPedMotionBlur(GetPlayerPed(-1), true)
       	SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
       	SetPedIsDrunk(GetPlayerPed(-1), true)
       	DoScreenFadeIn(1000)
       	Citizen.Wait(200000)
       	DoScreenFadeOut(1000)
       	Citizen.Wait(1000)
       	DoScreenFadeIn(1000)
       	ClearTimecycleModifier()
       	ResetScenarioTypesEnabled()
       	ResetPedMovementClipset(GetPlayerPed(-1), 0)
       	SetPedIsDrunk(GetPlayerPed(-1), false)
       	SetPedMotionBlur(GetPlayerPed(-1), false)
end)



function OpenDiscoVehicleMenu()

  local elements = {
    {label = _U('vehicle_list'), value = 'vehicle_list'}
 }

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'unicorn_actions',
    {
      css = 'unicorn',
      title    = _U('unicorn'),
      elements = elements
    },
    function(data, menu)

      if data.current.value == 'vehicle_list' then

        if Config.EnableSocietyOwnedVehicles then

            local elements = {}

            ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)

              for i=1, #vehicles, 1 do
                table.insert(elements, {label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']', value = vehicles[i]})
              end

              ESX.UI.Menu.Open(
                'default', GetCurrentResourceName(), 'vehicle_spawner',
                {
                  css = 'unicorn',
                  title    = _U('service_vehicle'),
                  align    = 'top-left',
                  elements = elements,
                },
                function(data, menu)

                  menu.close()

                  local vehicleProps = data.current.value
                  local playerPed = GetPlayerPed(-1)
                  local coords    = Config.Zones.VehicleSpawnPoint.Pos
                  local platenum = math.random(100, 900)

                  ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPoint.Pos, 270.0, function(vehicle)
                  ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
                  SetVehicleNumberPlateText(vehicle, "UCN" .. platenum)
                  TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
                  local plate = GetVehicleNumberPlateText(vehicle)
                  plate = string.gsub(plate, " ", "")
                  TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
                  end)

                  TriggerServerEvent('esx_society:removeVehicleFromGarage', 'unicorn', vehicleProps)

                end,

                function(data, menu)
                  menu.close()
                end
              )

            end, 'unicorn')

          else

            local elements = {
              {label = 'Livraison', value = 'burrito3'},
              {label = 'Chef Equipe', value = 'brioso'}
            }

            if Config.EnablePlayerManagement and PlayerData.job ~= nil and
              (PlayerData.job.grade_name == 'boss') then
              table.insert(elements, {label = 'Véhicule Patron', value = 'cognoscenti'})
            end

            ESX.UI.Menu.CloseAll()

            ESX.UI.Menu.Open(
              'default', GetCurrentResourceName(), 'spawn_vehicle',
              {
                css = 'unicorn',
                title    = _U('service_vehicle'),
                elements = elements
              },
              function(data, menu)
                for i=1, #elements, 1 do

                  local playerPed = GetPlayerPed(-1)
                  local platenum = math.random(100, 900)

                  if Config.MaxInService == -1 then

                    ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 90.0, function(vehicle)
                      local playerPed = GetPlayerPed(-1)
                      local platenum = math.random(100, 900)
                      SetVehicleNumberPlateText(vehicle, "UCN" .. platenum)
                      TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                      local plate = GetVehicleNumberPlateText(vehicle)
                      plate = string.gsub(plate, " ", "")
                      TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock

                    end)

                    break

                  else

                    ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)

                      if canTakeService then

                        ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 90.0, function(vehicle)
                          local playerPed = GetPlayerPed(-1)
                          local platenum = math.random(100, 900)
                          SetVehicleNumberPlateText(vehicle, "UCN" .. platenum)
                          TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
                          local plate = GetVehicleNumberPlateText(vehicle)
                          plate = string.gsub(plate, " ", "")
                          TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock

                        end)

                      else

                        ESX.ShowNotification(_U('service_full') .. inServiceCount .. '/' .. maxInService)
                      end

                    end, 'unicorn')

                    break

                  end

                end
                menu.close()
              end,
              function(data, menu)
                menu.close()
                OpenDiscoVehicleMenu()
              end
            )

          end
      end

    end,
    function(data, menu)
      menu.close()
      CurrentAction     = 'unicorn_vehicles_menu'
      CurrentActionMsg  = _U('open_actions')
      CurrentActionData = {}
    end
  )
end


function OpenDiscoTenuesMenu()

  local elements = {
    {label = _U('work_wear'), value = 'cloakroom'},
    {label = _U('civ_wear'), value = 'cloakroom2'}
 }
  if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.grade_name == 'boss' or PlayerData.job.grade_name == 'gerant' then
    table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
  end

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'unicorn_actions',
    {
      css = 'unicorn',
      title    = _U('unicorn'),
      elements = elements
    },
    function(data, menu)

      if data.current.value == 'cloakroom' then
      TriggerServerEvent("player:serviceOn", "unicorn") 
        menu.close()
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

            if skin.sex == 0 then
                TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
            else
                TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
            end

        end)
      end

      if data.current.value == 'cloakroom2' then
      TriggerServerEvent("player:serviceOff", "unicorn")  
        menu.close()
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

            TriggerEvent('skinchanger:loadSkin', skin)

        end)
      end

    end,
    function(data, menu)
      menu.close()
      CurrentAction     = 'unicorn_tenues_menu'
      CurrentActionMsg  = _U('open_actions')
      CurrentActionData = {}
    end
  )
end

function OpenDiscoStockBarMenu()

  local elements = {
    {label = _U('deposit_stock'), value = 'put_stock'},
    {label = _U('withdraw_stock'), value = 'get_stock'}
 }
  if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.grade_name == 'boss' or PlayerData.job.grade_name == 'gerant' then
    table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
  end

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'unicorn_actions',
    {
      css = 'unicorn',
      title    = _U('unicorn'),
      elements = elements
    },
    function(data, menu)

      if data.current.value == 'put_stock' then
        OpenPutStocksMenu()
      end

      if data.current.value == 'get_stock' then
        OpenGetStocksMenu()
      end

      if data.current.value == 'boss_actions' then
        TriggerEvent('esx_society:openBossMenu', 'unicorn', function(data, menu)
          menu.close()
        end)
      end

    end,
    function(data, menu)
      menu.close()
      CurrentAction     = 'unicorn_stock_menu'
      CurrentActionMsg  = _U('open_actions')
      CurrentActionData = {}
    end
  )
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
                  DrawAdvancedTextCNN(0.588, 0.14, 0.005, 0.0028, 0.8, "~r~ UNICORN ~d~", 255, 255, 255, 255, 1, 0)
                  DrawAdvancedTextCNN(0.586, 0.199, 0.005, 0.0028, 0.6, texteafiche, 255, 255, 255, 255, 7, 0)
                  DrawAdvancedTextCNN(0.588, 0.246, 0.005, 0.0028, 0.4, "", 255, 255, 255, 255, 0, 0)

          end                
     end
  end)



RegisterNetEvent('esx_unicorn:annonce')
AddEventHandler('esx_unicorn:annonce', function(text)
   texteafiche = text
   affichenews = true
  
end) 


RegisterNetEvent('esx_unicorn:annoncestop')
AddEventHandler('esx_unicorn:annoncestop', function()
   affichenews = false
   
end) 