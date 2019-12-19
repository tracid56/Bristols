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
local PlayerData                = {}
local GUI                       = {}
GUI.Time                        = 0
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local HasAlreadyEnteredMarker   = false
local IsHandcuffed              = false
local LastStation               = nil
local LastPart                  = nil
local LastPartNum               = nil
local LastEntity                = nil
local OnFaction                 = false
local hintIsShowed              = false
local hintToDisplay             = "no hint to display"

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(1)
  end

  PlayerData = ESX.GetPlayerData()
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setFaction')
AddEventHandler('esx:setFaction', function(faction)
  PlayerData.faction = faction   
end)

function SetVehicleMaxMods(vehicle)

  local props = {
    color1 = 0,
    color2 = 0,
    pearlescentColor = 0,
    modEngine = 3,
    modBrakes = 2,
    modTransmission = 2,
    modSuspension   = 3,
    modArmor = 4,
    modTurbo        = true,
  }

  ESX.Game.SetVehicleProperties(vehicle, props)

end

function OpenBanditsActionsMenu()

  local elements = {
    {label = 'Liste Véhicules', value = 'vehicle_list'},
    {label = '---------', value = ''},
    {label = 'Déposer Argent sale / Armes', value = 'put_black_money'},
    {label = '---------', value = ''},
    {label = 'Déposer Stock', value = 'put_stock'}
  }
  if Config.EnablePlayerManagement and PlayerData.faction ~= nil and PlayerData.faction.grade_name == 'boss' then
    table.insert(elements, {label = 'Prendre Argent sale / Armes', value = 'get_black_money'})
    table.insert(elements, {label = 'Prendre Stock', value = 'get_stock'})
  end
  if Config.EnablePlayerManagement and PlayerData.faction ~= nil and PlayerData.faction.grade_name == 'boss' then
    table.insert(elements, {label = '---------', value = ''})
    table.insert(elements, {label = 'Actions boss', value = 'boss_actions'})
  end

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'bandits_actions',
    {
      css = 'scarface',
      title    = 'Scarface',
      elements = elements
    },
    function(data, menu)
      if data.current.value == 'vehicle_list' then

        if Config.EnableSocietyOwnedVehicles then

            local elements = {}

            ESX.TriggerServerCallback('esx_societyfaction:getVehiclesInGarage', function(vehicles)

              for i=1, #vehicles, 1 do
                table.insert(elements, {label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']', value = vehicles[i]})
              end

              ESX.UI.Menu.Open(
                'default', GetCurrentResourceName(), 'vehicle_spawner',
                {
                  css = 'scarface',
                  title    = 'Véhicule Scarface',
                  align    = 'top-left',
                  elements = elements,
                },
                function(data, menu)

                  menu.close()

                  local playerPed = GetPlayerPed(-1)
                  local vehicleProps = data.current.value
                  local platenum = math.random(100, 900)

                  ESX.Game.SpawnVehicle(vehicleProps.model, Config.BanditsStations.Bandits.VehicleBanditsSpawnPoint.Pos, 270.0, function(vehicle)
                    ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
                    SetVehicleNumberPlateText(vehicle, "666")
                    TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
                    local plate = GetVehicleNumberPlateText(vehicle)
                    plate = string.gsub(plate, " ", "")
                    TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
                  end)

                  TriggerServerEvent('esx_societyfaction:removeVehicleFromGarage', 'bandits', vehicleProps)
                  -- Restore position
                  SetEntityCoords(playerPed, Config.BanditsStations.Bandits.VehicleBanditsSpawnPoint.Pos.x, Config.BanditsStations.Bandits.VehicleBanditsSpawnPoint.Pos.y, Config.BanditsStations.Bandits.VehicleBanditsSpawnPoint.Pos.z)

                end,
                function(data, menu)
                  menu.close()
                end
              )

            end, 'bandits')

          else

            local elements = {
              {label = 'BMW', value = 'rmodm4gts'},
              {label = 'Demon', value = 'demonhawk'}
              --{label = 'R8 Prior', value = 'r8prior'},
              --{label = 'Ferrari 458', value = 'italia458'}
            }

            if Config.EnablePlayerManagement and PlayerData.faction ~= nil and
              (PlayerData.faction.grade_name == 'boss' or PlayerData.faction.grade_name == '') then
              table.insert(elements, {label = 'Véhicule du Boss', value = 'rmodm4gts'})
            end

            ESX.UI.Menu.CloseAll()

            ESX.UI.Menu.Open(
              'default', GetCurrentResourceName(), 'spawn_vehicle',
              {
                css = 'scarface',
                title    = 'Véhicule Renaissance',
                elements = elements
              },
              function(data, menu)

                for i=1, #elements, 1 do

                  local model = data.current.value
                	local platenum = math.random(100, 900)
                	local playerPed = GetPlayerPed(-1)

                  if Config.MaxInService == -1 then

                    ESX.Game.SpawnVehicle(data.current.value, Config.BanditsStations.Bandits.VehicleBanditsSpawnPoint.Pos, 90.0, function(vehicle)
                      SetVehicleNumberPlateText(vehicle, "666")
                      SetVehicleCustomPrimaryColour(vehicle, 0, 0, 0)
                      SetVehicleWindowTint(vehicle, 1)
                      SetVehicleMaxMods(vehicle)
                      TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                      local plate = GetVehicleNumberPlateText(vehicle)
                      plate = string.gsub(plate, " ", "")
                      TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
                    end)
                    -- Restore position
                    SetEntityCoords(playerPed, Config.BanditsStations.Bandits.VehicleBanditsSpawnPoint.Pos.x, Config.BanditsStations.Bandits.VehicleBanditsSpawnPoint.Pos.y, Config.BanditsStations.Bandits.VehicleBanditsSpawnPoint.Pos.z)

                    break

                  else

                    ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)

                      if canTakeService then

                        ESX.Game.SpawnVehicle(data.current.value, Config.BanditsStations.Bandits.VehicleBanditsSpawnPoint.Pos, 90.0, function(vehicle)
                          SetVehicleNumberPlateText(vehicle, "666")
                          SetVehicleCustomPrimaryColour(vehicle, 0, 0, 0)
                          SetVehicleWindowTint(vehicle, 1)
                          SetVehicleMaxMods(vehicle)
                          TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
                        end)
                      -- Restore position
                      SetEntityCoords(playerPed, Config.BanditsStations.Bandits.VehicleBanditsSpawnPoint.Pos.x, Config.BanditsStations.Bandits.VehicleBanditsSpawnPoint.Pos.y, Config.BanditsStations.Bandits.VehicleBanditsSpawnPoint.Pos.z)

                      else

                        ESX.ShowNotification('service_full' .. inServiceCount .. '/' .. maxInService)

                      end
                    end, 'bandits')

                    break

                  end
                end
                menu.close()
              end,

              function(data, menu)
                menu.close()
                OpenBanditsActionsMenu()
              end
            )

          end
      end

      if data.current.value == 'cloakroom' then
        OpenCloakroomMenu()
      end

      if data.current.value == 'get_black_money' then
        OpenGetBlackMoney()
      end

      if data.current.value == 'put_black_money' then
        OpenPutBlackMoney()
      end

      if data.current.value == 'put_stock' then
        OpenPutStocksBanditsMenu()
      end

      if data.current.value == 'get_stock' then
        OpenGetStocksBanditsMenu()
      end

      if data.current.value == 'boss_actions' then
        TriggerEvent('esx_societyfaction:openBossFactionMenu', 'bandits', function(data, menu)
          menu.close()
        end)
      end

    end,
    function(data, menu)

      menu.close()

      CurrentAction     = 'bandits_actions_menu'
      CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
      CurrentActionData = {}

    end
  )

end



function OpenCloakroomMenu()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'cloakroom',
    {
      css = 'scarface',
      title    = 'Tenue',
      align    = 'top-left',
      elements = {
        {label = 'Tenue Civil', value = 'citizen_wear'},
        {label = 'Tenue Bandits', value = 'bandits_wear'},
      },
    },
    function(data, menu)

      menu.close()

      if data.current.value == 'citizen_wear' then

        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, factionSkin)
          TriggerEvent('skinchanger:loadSkin', skin)
        end)

      end

      if data.current.value == 'bandits_wear' then

        ESX.TriggerServerCallback('esx_skin:getPlayerSkinFaction', function(skin, factionSkin)

          if skin.sex == 0 then
            TriggerEvent('skinchanger:loadClothes', skin, factionSkin.skin_male)
          else
            TriggerEvent('skinchanger:loadClothes', skin, factionSkin.skin_female)
          end

        end)

      end

      CurrentAction     = 'bandits_actions_menu'
      CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
      CurrentActionData = {}

    end,
    function(data, menu)
      menu.close()
    end
  )

end

---- Stock Items bandits

function OpenGetStocksBanditsMenu()

  ESX.TriggerServerCallback('esx_scarface:getStockItemsBandits', function(items)

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
        css = 'scarface',
        title    = 'Renaissance Stock',
        elements = elements
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
          {
            css = 'scarface',
            title = 'Quantité'
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification('Quantité Invalide')
            else
              menu2.close()
              menu.close()
              OpenGetStocksBanditsMenu()

              TriggerServerEvent('esx_scarface:getStockItemsBandits', itemName, count)
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



function OpenPutStocksBanditsMenu()

ESX.TriggerServerCallback('esx_faction:getPlayerInventory', function(inventory)

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
        css = 'scarface',
        title    = 'Inventaire',
        elements = elements
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count',
          {
            title = 'Quantité'
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification('Quantité Invalide')
            else
              menu2.close()
              menu.close()
              OpenPutStocksBanditsMenu()

              TriggerServerEvent('esx_scarface:putStockItemsBandits', itemName, count)
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

function OpenArmoryMenu(station)

  if Config.EnableArmoryManagement then

    local elements = {
      {label = 'Prendre Arme', value = 'get_weapon'},
      {label = 'Déposer Arme', value = 'put_weapon'}
      --{label = _U('buy_weapons'), value = 'buy_weapons'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory',
      {
        css = 'scarface',
        title    = _U('armory'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        if data.current.value == 'get_weapon' then
          OpenGetWeaponMenu()
        end

        if data.current.value == 'put_weapon' then
          OpenPutWeaponMenu()
        end

        if data.current.value == 'buy_weapons' then
          OpenBuyWeaponsMenu(station)
        end

      end,
      function(data, menu)

        menu.close()

        CurrentAction     = 'menu_armory'
        CurrentActionMsg  = _U('open_armory')
        CurrentActionData = {station = station}
      end
    )

  else

    local elements = {}

    for i=1, #Config.BanditsStations[station].AuthorizedWeapons, 1 do
      local weapon = Config.BanditsStations[station].AuthorizedWeapons[i]
      table.insert(elements, {label = ESX.GetWeaponLabel(weapon.name), value = weapon.name})
    end

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory',
      {
        css = 'scarface',
        title    = _U('armory'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)
        local weapon = data.current.value
        TriggerServerEvent('esx_scarface:giveWeaponBandits', weapon,  1000)
      end,
      function(data, menu)

        menu.close()

        CurrentAction     = 'menu_armory'
        CurrentActionMsg  = _U('open_armory')
        CurrentActionData = {}

      end
    )

  end

end

function OpenGetWeaponMenu()

  ESX.TriggerServerCallback('esx_scarface:getArmoryWeaponsBandits', function(weapons)

    local elements = {}

    for i=1, #weapons, 1 do
      if weapons[i].count > 0 then
        table.insert(elements, {label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name), value = weapons[i].name})
      end
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory_get_weapon',
      {
        css = 'scarface',
        title    = _U('get_weapon_menu'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        menu.close()

        ESX.TriggerServerCallback('esx_scarface:removeArmoryWeaponBandits', function()
          OpenGetWeaponMenu()
        end, data.current.value)

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenPutWeaponMenu()

  local elements   = {}
  local playerPed  = GetPlayerPed(-1)
  local weaponList = ESX.GetWeaponList()

  for i=1, #weaponList, 1 do

    local weaponHash = GetHashKey(weaponList[i].name)

    if HasPedGotWeapon(playerPed,  weaponHash,  false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
      local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
      table.insert(elements, {label = weaponList[i].label, value = weaponList[i].name})
    end

  end

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'armory_put_weapon',
    {
      css = 'scarface',
      title    = _U('put_weapon_menu'),
      align    = 'top-left',
      elements = elements,
    },
    function(data, menu)

      menu.close()

      ESX.TriggerServerCallback('esx_scarface:addArmoryWeaponBandits', function()
        OpenPutWeaponBanditsMenu()
      end, data.current.value)

    end,
    function(data, menu)
      menu.close()
    end
  )

end

function OpenBuyWeaponsMenu(station)

  ESX.TriggerServerCallback('esx_scarface:getArmoryWeaponsBandits', function(weapons)

    local elements = {}

    for i=1, #Config.BanditsStations[station].Bandits.AuthorizedWeapons, 1 do

      local weapon = Config.BanditsStations[station].Bandits.AuthorizedWeapons[i]
      local count  = 0

      for i=1, #weapons, 1 do
        if weapons[i].name == weapon.name then
          count = weapons[i].count
          break
        end
      end

      table.insert(elements, {label = 'x' .. count .. ' ' .. ESX.GetWeaponLabel(weapon.name) .. ' $' .. weapon.price, value = weapon.name, price = weapon.price})

    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory_buy_weapons',
      {
        css = 'scarface',
        title    = _U('buy_weapon_menu'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        ESX.TriggerServerCallback('esx_scarface:buyBandits', function(hasEnoughMoney)

          if hasEnoughMoney then
            ESX.TriggerServerCallback('esx_scarface:addArmoryWeaponBandits', function()
              OpenBuyWeaponsMenu(station)
            end, data.current.value)
          else
            ESX.ShowNotification(_U('not_enough_money'))
          end

        end, data.current.price)

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenScarfaceActionsMenu()

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'cartel_actions',
    {
      css = 'scarface',
      title    = 'Scarface',
      align    = 'top-left',
      elements = {
        {label = _U('citizen_interaction'), value = 'citizen_interaction'},
        {label = _U('vehicle_interaction'), value = 'vehicle_interaction'},
        {label = _U('object_spawner'),      value = 'object_spawner'},
      },
    },
    function(data, menu)

      if data.current.value == 'citizen_interaction' then

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'citizen_interaction',
          {
            css = 'scarface',
            title    = _U('citizen_interaction'),
            align    = 'top-left',
            elements = {
              {label = _U('id_card'),       value = 'identity_card'},
              {label = _U('search'),        value = 'body_search'},
              {label = _U('handcuff'),    value = 'handcuff'},
              {label = _U('drag'),      value = 'drag'},
              {label = _U('put_in_vehicle'),  value = 'put_in_vehicle'},
              {label = _U('out_the_vehicle'), value = 'out_the_vehicle'},
              --{label = _U('fine'),            value = 'fine'}
            },
          },
          function(data2, menu2)

            local player, distance = ESX.Game.GetClosestPlayer()

            if distance ~= -1 and distance <= 3.0 then

              if data2.current.value == 'identity_card' then
                OpenIdentityCardMenu(player)
              end

              if data2.current.value == 'body_search' then
                OpenBodySearchMenu(player)
              end

              if data2.current.value == 'handcuff' then
                TriggerServerEvent('esx_scarface:handcuff', GetPlayerServerId(player))
              end

              if data2.current.value == 'drag' then
                TriggerServerEvent('esx_scarface:drag', GetPlayerServerId(player))
              end

              if data2.current.value == 'put_in_vehicle' then
                TriggerServerEvent('esx_scarface:putInVehicle', GetPlayerServerId(player))
              end

              if data2.current.value == 'out_the_vehicle' then
                  TriggerServerEvent('esx_scarface:OutVehicle', GetPlayerServerId(player))
              end

              if data2.current.value == 'fine' then
                OpenFineMenu(player)
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

      if data.current.value == 'vehicle_interaction' then

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'vehicle_interaction',
          {
            css = 'scarface',
            title    = _U('vehicle_interaction'),
            align    = 'top-left',
            elements = {
              {label = _U('vehicle_info'), value = 'vehicle_infos'},
              {label = _U('pick_lock'),    value = 'hijack_vehicle'},
            },
          },
          function(data2, menu2)

            local playerPed = GetPlayerPed(-1)
            local coords    = GetEntityCoords(playerPed)
            local vehicle   = GetClosestVehicle(coords.x,  coords.y,  coords.z,  3.0,  0,  71)

            if DoesEntityExist(vehicle) then

              local vehicleData = ESX.Game.GetVehicleProperties(vehicle)

              if data2.current.value == 'vehicle_infos' then
                OpenVehicleInfosMenu(vehicleData)
              end

              if data2.current.value == 'hijack_vehicle' then

                local playerPed = GetPlayerPed(-1)
                local coords    = GetEntityCoords(playerPed)

                if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then

                  local vehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  3.0,  0,  71)

                  if DoesEntityExist(vehicle) then

                    Citizen.CreateThread(function()

                      TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)

                      Wait(20000)

                      ClearPedTasksImmediately(playerPed)

                      SetVehicleDoorsLocked(vehicle, 1)
                      SetVehicleDoorsLockedForAllPlayers(vehicle, false)

                      TriggerEvent('esx:showNotification', _U('vehicle_unlocked'))

                    end)

                  end

                end

              end

            else
              ESX.ShowNotification(_U('no_vehicles_nearby'))
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end

      if data.current.value == 'object_spawner' then

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'citizen_interaction',
          {
            css = 'scarface',
            title    = _U('traffic_interaction'),
            align    = 'top-left',
            elements = {
              {label = _U('cone'),     value = 'prop_roadcone02a'},
              {label = _U('barrier'), value = 'prop_barrier_work06a'},
              {label = _U('spikestrips'),    value = 'p_ld_stinger_s'},
              {label = _U('box'),   value = 'prop_boxpile_07d'},
              {label = _U('cash'),   value = 'hei_prop_cash_crate_half_full'}
            },
          },
          function(data2, menu2)


            local model     = data2.current.value
            local playerPed = GetPlayerPed(-1)
            local coords    = GetEntityCoords(playerPed)
            local forward   = GetEntityForwardVector(playerPed)
            local x, y, z   = table.unpack(coords + forward * 1.0)

            if model == 'prop_roadcone02a' then
              z = z - 2.0
            end

            ESX.Game.SpawnObject(model, {
              x = x,
              y = y,
              z = z
            }, function(obj)
              SetEntityHeading(obj, GetEntityHeading(playerPed))
              PlaceObjectOnGroundProperly(obj)
            end)

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end

    end,
    function(data, menu)

      menu.close()

    end
  )

end

function OpenIdentityCardMenu(player)

  if Config.EnableESXIdentity then

    ESX.TriggerServerCallback('esx_scarface:getOtherPlayerData', function(data)

      local jobLabel    = nil
      local sexLabel    = nil
      local sex         = nil
      local dobLabel    = nil
      local heightLabel = nil
      local idLabel     = nil

      if data.job.grade_label ~= nil and  data.job.grade_label ~= '' then
        jobLabel = 'Métier : ' .. data.job.label .. ' - ' .. data.job.grade_label
      else
        jobLabel = 'Métier : ' .. data.job.label
      end

      if data.sex ~= nil then
        if (data.sex == 'm') or (data.sex == 'M') then
          sex = 'Homme'
        else
          sex = 'Femme'
        end
        sexLabel = 'Sexe : ' .. sex
      else
        sexLabel = 'Sexe : Inconnu'
      end

      if data.dob ~= nil then
        dobLabel = 'Date de naissance : ' .. data.dob
      else
        dobLabel = 'Date de naissance : Inconnu'
      end

      if data.height ~= nil then
        heightLabel = 'Taille : ' .. data.height
      else
        heightLabel = 'Taille : Inconnu'
      end

      if data.name ~= nil then
        idLabel = 'ID : ' .. data.name
      else
        idLabel = 'ID : Inconnu'
      end

      local elements = {
        {label = _U('name') .. data.firstname .. " " .. data.lastname, value = nil},
        {label = sexLabel,    value = nil},
        {label = dobLabel,    value = nil},
        {label = heightLabel, value = nil},
        {label = jobLabel,    value = nil},
        {label = idLabel,     value = nil},
      }

      if data.drunk ~= nil then
        table.insert(elements, {label = _U('bac') .. data.drunk .. '%', value = nil})
      end

      if data.licenses ~= nil then

        table.insert(elements, {label = '--- Licenses ---', value = nil})

        for i=1, #data.licenses, 1 do
          table.insert(elements, {label = data.licenses[i].label, value = nil})
        end

      end

      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'citizen_interaction',
        {
          css = 'scarface',
          title    = _U('citizen_interaction'),
          align    = 'top-left',
          elements = elements,
        },
        function(data, menu)

        end,
        function(data, menu)
          menu.close()
        end
      )

    end, GetPlayerServerId(player))

  else

    ESX.TriggerServerCallback('esx_scarface:getOtherPlayerData', function(data)

      local jobLabel = nil

      if data.job.grade_label ~= nil and  data.job.grade_label ~= '' then
        jobLabel = 'Métier : ' .. data.job.label .. ' ' .. data.job.grade_label
      else
        jobLabel = 'Métier : ' .. data.job.label
      end

        local elements = {
          {label = _U('name') .. data.name, value = nil},
          {label = jobLabel,              value = nil},
        }

      if data.drunk ~= nil then
        table.insert(elements, {label = 'Alcoolémie : ' .. data.drunk .. '%', value = nil})
      end

      if data.licenses ~= nil then

        table.insert(elements, {label = '--- Licenses ---', value = nil})

        for i=1, #data.licenses, 1 do
          table.insert(elements, {label = data.licenses[i].label, value = nil})
        end

      end

      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'citizen_interaction',
        {
          css = 'scarface',
          title    = _U('citizen_interaction'),
          align    = 'top-left',
          elements = elements,
        },
        function(data, menu)

        end,
        function(data, menu)
          menu.close()
        end
      )

    end, GetPlayerServerId(player))

  end

end

function OpenBodySearchMenu(player)

  ESX.TriggerServerCallback('esx_scarface:getOtherPlayerData', function(data)

    local elements = {}

    local blackMoney = 0

    for i=1, #data.accounts, 1 do
      if data.accounts[i].name == 'black_money' then
        blackMoney = data.accounts[i].money
      end
    end

    table.insert(elements, {
      label          = 'Confisquer '..blackMoney..'$ d\'argent sale',
      value          = 'black_money',
      itemType       = 'item_account',
      amount         = blackMoney
    })

    table.insert(elements, {label = '--- Armes ---', value = nil})

    for i=1, #data.weapons, 1 do
      table.insert(elements, {
        label          = 'Confisquer ' .. ESX.GetWeaponLabel(data.weapons[i].name),
        value          = data.weapons[i].name,
        itemType       = 'item_weapon',
        amount         = data.ammo,
      })
    end

    table.insert(elements, {label = '--- Inventaire ---', value = nil})

    for i=1, #data.inventory, 1 do
      if data.inventory[i].count > 0 then
        table.insert(elements, {
          label          = 'Confisquer x' .. data.inventory[i].count .. ' ' .. data.inventory[i].label,
          value          = data.inventory[i].name,
          itemType       = 'item_standard',
          amount         = data.inventory[i].count,
        })
      end
    end


    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'body_search',
      {
        css = 'scarface',
        title    = 'Fouiller',
        align    = 'left',
        elements = elements,
      },
      function(data, menu)

        local itemType = data.current.itemType
        local itemName = data.current.value
        local amount   = data.current.amount

        if data.current.value ~= nil then

          TriggerServerEvent('esx_scarface:confiscatePlayerItem', GetPlayerServerId(player), itemType, itemName, amount)

          OpenBodySearchMenu(player)

        end

      end,
      function(data, menu)
        menu.close()
      end
    )

  end, GetPlayerServerId(player))

end

function OpenFineMenu(player)

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'fine',
    {
      css = 'scarface',
      title    = _U('fine'),
      align    = 'top-left',
      elements = {
        {label = _U('traffic_offense'),   value = 0},
        {label = _U('minor_offense'),     value = 1},
        {label = _U('average_offense'),   value = 2},
        {label = _U('major_offense'),     value = 3}
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

  ESX.TriggerServerCallback('esx_scarface:getFineList', function(fines)

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
        css = 'scarface',
        title    = 'Amende: ',
        align    = 'left',
        elements = elements,
      },
      function(data, menu)

        local label  = data.current.fineLabel
        local amount = data.current.amount

        menu.close()

        if Config.EnablePlayerManagement then
          local playerPed        = GetPlayerPed(-1)
            
            Citizen.CreateThread(function()
                TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
                Citizen.Wait(5000)
                ClearPedTasks(playerPed)
                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_bandits', 'Racket: ' .. label, amount)
            end)    
        else
          TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), '', 'Racket:' .. label, amount)
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

function OpenVehicleInfosMenu(vehicleData)

  ESX.TriggerServerCallback('esx_scarface:getVehicleInfos', function(infos)

    local elements = {}

    table.insert(elements, {label = 'N°:' .. infos.plate, value = nil})

    if infos.owner == nil then
      table.insert(elements, {label = 'propriétaire : Inconnu', value = nil})
    else
      table.insert(elements, {label = 'propriétaire' .. infos.owner, value = nil})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'vehicle_infos',
      {
        css = 'scarface',
        title    = 'Infos véhicule',
        align    = 'left',
        elements = elements,
      },
      nil,
      function(data, menu)
        menu.close()
      end
    )

  end, vehicleData.plate)

end

function OpenBanditsActionseMenu()

  local elements = {
    {label = 'Liste Véhicules', value = 'vehicle_list1'}
    --{label = 'Tenue', value = 'cloakroom'},
    --{label = '---------', value = ''},
    --{label = 'Déposer Argent sale / Armes', value = 'put_black_money'},
    --{label = 'Prendre Argent sale / Armes', value = 'get_black_money'},
    --{label = '---------', value = ''},
    --{label = 'Déposer Stock', value = 'put_stock'},
    --{label = 'Prendre Stock', value = 'get_stock'}
  }

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'bandits_actionse1',
    {
      css = 'scarface',
      title    = 'Scarface',
      elements = elements
    },
    function(data, menu)
      if data.current.value == 'vehicle_list1' then

        if Config.EnableSocietyOwnedVehicles1 then

            local elements = {}

            ESX.TriggerServerCallback('esx_societyfaction:getVehiclesInGarage', function(vehicles)

              for i=1, #vehicles, 1 do
                table.insert(elements, {label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']', value = vehicles[i]})
              end

              ESX.UI.Menu.Open(
                'default', GetCurrentResourceName(), 'vehicle_spawner1',
                {
                  css = 'scarface',
                  title    = 'Véhicule Scarface',
                  align    = 'top-left',
                  elements = elements,
                },
                function(data, menu)

                  menu.close()

                  local playerPed = GetPlayerPed(-1)
                  local vehicleProps = data.current.value
                  local platenum = math.random(100, 900)

                  ESX.Game.SpawnVehicle(vehicleProps.model, Config.BanditsStations.VehicleBanditsSpawnPoint1.Pos, 270.0, function(vehicle)
                    ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
                    SetVehicleNumberPlateText(vehicle, "ACE" .. platenum)
                    TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
                    local plate = GetVehicleNumberPlateText(vehicle)
                    plate = string.gsub(plate, " ", "")
                    TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
                  end)

                  TriggerServerEvent('esx_societyfaction:removeVehicleFromGarage', 'bandits', vehicleProps)
                  -- Restore position
                  SetEntityCoords(playerPed, Config.BanditsStations.VehicleBanditsSpawnPoint1.Pos.x, Config.BanditsStations.VehicleBanditsSpawnPoint1.Pos.y, Config.BanditsStations.VehicleBanditsSpawnPoint1.Pos.z)

                end,
                function(data, menu)
                  menu.close()
                end
              )

            end, 'bandits')

          else

            local elements = {
              {label = 'BMW', value = 'rmodm4gts'},
              {label = 'Demon', value = 'demonhawk'}
              --{label = 'Ferrari 458', value = 'italia458'}
            }

            if Config.EnablePlayerManagement and PlayerData.faction ~= nil and
              (PlayerData.faction.grade_name == 'boss' or PlayerData.faction.grade_name == '') then
              table.insert(elements, {label = 'Véhicule du Boss', value = 'rmodm4gts'})
            end

            ESX.UI.Menu.CloseAll()

            ESX.UI.Menu.Open(
              'default', GetCurrentResourceName(), 'spawn_vehicle1',
              {
                css = 'scarface',
                title    = 'Véhicule Renaissance',
                elements = elements
              },
              function(data, menu)

                for i=1, #elements, 1 do

                    local model = data.current.value
                	local playerPed = GetPlayerPed(-1)

                  if Config.MaxInService == -1 then

                    ESX.Game.SpawnVehicle(data.current.value, Config.BanditsStations.Bandits.VehicleBanditsSpawnPoint1.Pos, 90.0, function(vehicle)
                      SetVehicleNumberPlateText(vehicle, "666")
                      SetVehicleCustomPrimaryColour(vehicle, 0, 0, 0)
                      SetVehicleWindowTint(vehicle, 1)
                      SetVehicleMaxMods(vehicle)
                      TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                      local plate = GetVehicleNumberPlateText(vehicle)
                      plate = string.gsub(plate, " ", "")
                      TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
                    end)
                    -- Restore position
                    SetEntityCoords(playerPed, Config.BanditsStations.Bandits.VehicleBanditsSpawnPoint1.Pos.x, Config.BanditsStations.Bandits.VehicleBanditsSpawnPoint1.Pos.y, Config.BanditsStations.Bandits.VehicleBanditsSpawnPoint1.Pos.z)
                    break

                  else

                    ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)

                      if canTakeService then

                        ESX.Game.SpawnVehicle(data.current.value, Config.BanditsStations.Bandits.VehicleBanditsSpawnPoint1.Pos, 90.0, function(vehicle)
                          SetVehicleNumberPlateText(vehicle, "666")
                          SetVehicleCustomPrimaryColour(vehicle, 0, 0, 0)
                          SetVehicleWindowTint(vehicle, 1)
                          SetVehicleMaxMods(vehicle)
                          TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
                        end)
                        -- Restore position
                        SetEntityCoords(playerPed, Config.BanditsStations.Bandits.VehicleBanditsSpawnPoint1.Pos.x, Config.BanditsStations.Bandits.VehicleBanditsSpawnPoint1.Pos.y, Config.BanditsStations.Bandits.VehicleBanditsSpawnPoint1.Pos.z)
                      else
                        ESX.ShowNotification('service_full' .. inServiceCount .. '/' .. maxInService)
                      end
                    end, 'bandits')

                    break

                  end
                end
                menu.close()
              end,

              function(data, menu)
                menu.close()
                OpenBanditsActionseMenu()
              end
            )

          end
      end

      if data.current.value == 'cloakroom' then
        OpenCloakroomMenu()
      end

      if data.current.value == 'get_black_money' then
        OpenGetBlackMoney()
      end

      if data.current.value == 'put_black_money' then
        OpenPutBlackMoney()
      end

      if data.current.value == 'put_stock' then
        OpenPutStocksBanditsMenu()
      end

      if data.current.value == 'get_stock' then
        OpenGetStocksBanditsMenu()
      end

      if data.current.value == 'boss_actions1' then
        TriggerEvent('esx_societyfaction:openBossFactionMenu', 'bandits', function(data, menu)
          menu.close()
        end)
      end

    end,
    function(data, menu)

      menu.close()

      CurrentAction     = 'bandits_actionse_menu1'
      CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
      CurrentActionData = {}

    end
  )

end

AddEventHandler('esx_scarface:hasEnteredMarker', function(station, part, partNum)

  if part == 'CryptedActions' then
    CurrentAction     = 'bandits_actions_menu'
    CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
    CurrentActionData = {}
  end

  if part == 'CryptedActions1' then
    CurrentAction     = 'bandits_actionse_menu1'
    CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu.'
    CurrentActionData = {}
  end      

  if part == 'Armory' then
    CurrentAction     = 'menu_armory'
    CurrentActionMsg  = _U('open_armory')
    CurrentActionData = {station = station}
  end    

  if part == 'VehicleDeleter1' then

    local playerPed = GetPlayerPed(-1)

    if IsPedInAnyVehicle(playerPed,  false) then
      CurrentAction     = 'delete_vehicle1'
      CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour ranger le véhicule.'
      CurrentActionData = {}
    end

  end

end)

AddEventHandler('esx_scarface:hasExitedMarker', function(station, part, partNum)
  ESX.UI.Menu.CloseAll()
  CurrentAction = nil
end)

RegisterNetEvent('esx_scarface:handcuff')
AddEventHandler('esx_scarface:handcuff', function()

  IsHandcuffed    = not IsHandcuffed;
  local playerPed = GetPlayerPed(-1)

  Citizen.CreateThread(function()

    if IsHandcuffed then

      RequestAnimDict('mp_arresting')

      while not HasAnimDictLoaded('mp_arresting') do
        Wait(100)
      end

      TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
      SetEnableHandcuffs(playerPed, true)
      SetPedCanPlayGestureAnims(playerPed, false)
      FreezeEntityPosition(playerPed,  true)

    else

      ClearPedSecondaryTask(playerPed)
      SetEnableHandcuffs(playerPed, false)
      SetPedCanPlayGestureAnims(playerPed,  true)
      FreezeEntityPosition(playerPed, false)

    end

  end)
end)

RegisterNetEvent('esx_scarface:drag')
AddEventHandler('esx_scarface:drag', function(cop)
  -- TriggerServerEvent('esx:clientLog', 'starting dragging')
  IsDragged = not IsDragged
  CopPed = tonumber(cop)
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsHandcuffed then
      if IsDragged then
        local ped = GetPlayerPed(GetPlayerFromServerId(CopPed))
        local myped = GetPlayerPed(-1)
        AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
      else
        DetachEntity(GetPlayerPed(-1), true, false)
      end
    end
  end
end)

RegisterNetEvent('esx_scarface:putInVehicle')
AddEventHandler('esx_scarface:putInVehicle', function()

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

RegisterNetEvent('esx_scarface:OutVehicle')
AddEventHandler('esx_scarface:OutVehicle', function(t)
	local ped = GetPlayerPed(t)
	ClearPedTasksImmediately(ped)
	plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
	local xnew = plyPos.x+2
	local ynew = plyPos.y+2

	SetEntityCoords(GetPlayerPed(-1), xnew, ynew, plyPos.z)
end)

-- Handcuff
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if IsHandcuffed then
			DisableControlAction(0, 142, true) -- MeleeAttackAlternate
			DisableControlAction(0, 30,  true) -- MoveLeftRight
			DisableControlAction(0, 31,  true) -- MoveUpDown
			DisableControlAction(0, 24,  true) -- Shoot 
			DisableControlAction(0, 92,  true) -- Shoot in car
			DisableControlAction(0, 75,  true) -- Leave Vehicle
		end
	end
end)

RegisterNetEvent('esx_cryptedhone:loaded')
AddEventHandler('esx_cryptedhone:loaded', function(phoneNumber, contacts)

  local specialContact = {
    name       = 'bandits',
    number     = 'bandits',
    base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4QkDEBcG/q8tywAABhRJREFUWMOtl0tsVdcVhr+1z+M+zb3Y2Mb4RRzAUewkJQ2ERhVx4uBkEPUx6iNSSQeV+pAYlQ4SUAfpqKnatBmYQQYgJWRYqarUglqESlOFWjZtY2Jsyiv4eW2Mn9e+vvfs1cGxARNf+7rKPzrSfvz/+vc6e60tbIBjHScAXGC3wIvA80ArUAMkAQHmgRGgFzgPnAMdAApvnf3RuvtLsYHjHZ0AjiJfFngdeBloWBazHgrAIPBn4KRCN1D4xdkflibgWEcngqCwQ+AI8H2gaiOniiADnAT9LcgwKA87skrAmy+dwPMgCNgHvA0cXM+lEqHABeBozi79M+HE+PmZH9wbdFY+3jjUiecI1uoLIO8Bz3wB5CtBNlq1B2cW7vQdavn2DS3k+c/IxfsOHDvUiYigsF/gFPDYpkJUxYu4JFIxZibmUTSM+4HxyWyGqYWJAat6WLEfe+Lzfs87mFCGQHjmv9wsOQKRuE/zs41U1KbY+WQNXsT9HPndhXGs2j2gbzti6gIthEdwvOMEohiEN4DXNuvvtro0T7Xvof6xKqp2lnOzd4SZ8fnPkaves6QBsI7jnmut2a8GQIV9hL/aJnwHP+Zx4But7Hv1cSobttL9pz6Gr06sR76y9HAQBM+qKsaijsD3gOrN8NvAUtW4lSfaduFFHM5/0M1nfWMYI+uSL6NS4bAR3zWC7AFe2Qy54xpS1UkaW2vwoy5/+/ASV7tul0q+4kOHtflmV+AFoH5T9ovQ2FJDJO5x/d/DXL5wPUz6kskBqANtN0Ab4G2Gv5ArsJhd4so/blLIFahtrsIGwWbIAVyFNkNYWEqG2vCfT1UmKeQDXN+hae8OZvJ3mJzPlEq+sluLIaxqJZNvrdnC/q+1MDeZJTu9yO0rGZKPONQ/lyaeim5SADXO84+++hYPXMnFIAK7nqln974GbvxriOH/ThBPRej/tJ+cP0tj63aqdpazOL/EzJ35UgV4BpZvww3w+Feb2N60ja4/fsr47Sm2bIsznBlkeGKIga7PsNZSUZfiK998gqYv1ZZsgQHmNrK9rrmKLZUJLv6hFz/qUb5jCzdu3WDs7ggiMJ2ZZWEmB6pE4j5Pte+mfEeqlOPIGmB0vRmu79DQup2+j26STMfwog59vX2MT48SSYQ/jypkZxdBwnsgkY7RtLcWkQ2L6YghbKPWjl6VRCqGWiWXXSKS9BjoH2CeKfyYS24+j+OGJ2iD1dFWNaSJxL1VVfFhiEivIezhCmsrAC/qks8ViCZ8bt2+xYI7gxd1lyOGQj7AcUxYUPX+ukjcx4u4YWleGwWQ80bhHHB7bYkQFCwITMyNcWd2DD/qMjuZxfNdEqkojusQiXu4/upWMQjssitFj2EQOGdUtR84U8Qi5qcXmJgZZXI+gx93sYFFAyWa9Mll80TiHol0DD/m3bdAYGZ8jlx2iWJpIMhZz/hXjBEJCLugzFo5MDoxxED/VdLbkxjXkCyP43gGMUKQD/CjHpGEj+c798wO8gE3PxmhsBQUi34c4VTe5goGVdQGXcsiVpGv3O1DVzPEyqIkt8aJlUVIV5chIvgxDz/uUVYex/UdZNnu65eGGOzLIGbt8AU55Rr3ohETrjgePj5qgdPAwYdLqipE4h4NLdtJpKNooExl5oiVRah5dBvVj5TjRVwW53JcuzTE5QvXyWXzxez/uxHzHVUGP7z0bvjI0MAijhkCfmbVnrqbHW9+sKqJwFI2z7WeQdLVZVTWp6moSxFN+CAw1J/h7tgso9fuMDkygw20GPmAiDlqrR10HXclXUK8+VInv//kPdp2fb19amG806rdvdYOK6KMY8IGBNBAsdbeS9wiuAry48Vg9i9Jt4L3e369WgDAt/b+hKjjsGTtAVX9FfAcX8zD5CPBHM0H0x/7XgWnu39zb3BVFbw82sWT1QcIRAeNmLPL3f0eIP5/ko8LdBoxP1VsX8RL8kH3O6smFI3utaePIGLcQIP9qL6uaAdhopbyOB0COSMiJx1juqy1hdM97645eUN7v/v0EYyIF6htRmkHbVO0hbCRWXEmC4wI0otwXpC/isiAKvnTPb9bd///AREkvT6wEkCGAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDE3LTA5LTAzVDE2OjIzOjA2LTA0OjAwXHE1uQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAxNy0wOS0wM1QxNjoyMzowNi0wNDowMC0sjQUAAAAASUVORK5CYII='
  }

  TriggerEvent('esx_cryptedhone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)

end)

-- Display markers
Citizen.CreateThread(function()
  while true do

    Wait(0)

    if PlayerData.faction ~= nil and PlayerData.faction.name == 'bandits' then

        local playerPed = GetPlayerPed(-1)
        local coords = GetEntityCoords(GetPlayerPed(-1))

        for k,v in pairs(Config.BanditsStations) do
          for i=1, #v.Armories, 1 do
            if GetDistanceBetweenCoords(coords,  v.Armories[i].x,  v.Armories[i].y,  v.Armories[i].z,  true) < Config.DrawDistance then
              DrawMarker(Config.MarkerType, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
            end
          end

          for i=1, #v.CryptedActions, 1 do
            if GetDistanceBetweenCoords(coords,  v.CryptedActions[i].x,  v.CryptedActions[i].y,  v.CryptedActions[i].z,  true) < Config.DrawDistance then
              DrawMarker(Config.MarkerType, v.CryptedActions[i].x, v.CryptedActions[i].y, v.CryptedActions[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
            end
          end 

          for i=1, #v.CryptedActions1, 1 do
            if GetDistanceBetweenCoords(coords,  v.CryptedActions1[i].x,  v.CryptedActions1[i].y,  v.CryptedActions1[i].z,  true) < Config.DrawDistance then
              DrawMarker(Config.MarkerType, v.CryptedActions1[i].x, v.CryptedActions1[i].y, v.CryptedActions1[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
            end
          end
        end
    
    end

  end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
  while true do

    Wait(0)

    if PlayerData.faction ~= nil and PlayerData.faction.name == 'bandits' then

      local playerPed      = GetPlayerPed(-1)
      local coords         = GetEntityCoords(playerPed)
      local isInMarker     = false
      local currentStation = nil
      local currentPart    = nil
      local currentPartNum = nil

      for k,v in pairs(Config.BanditsStations) do

        for i=1, #v.Armories, 1 do
          if GetDistanceBetweenCoords(coords,  v.Armories[i].x,  v.Armories[i].y,  v.Armories[i].z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'Armory'
            currentPartNum = i
          end
        end

        for i=1, #v.CryptedActions, 1 do
          if GetDistanceBetweenCoords(coords,  v.CryptedActions[i].x,  v.CryptedActions[i].y,  v.CryptedActions[i].z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'CryptedActions'
            currentPartNum = i
          end
        end

        for i=1, #v.CryptedActions1, 1 do
          if GetDistanceBetweenCoords(coords,  v.CryptedActions1[i].x,  v.CryptedActions1[i].y,  v.CryptedActions1[i].z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'CryptedActions1'
            currentPartNum = i
          end
        end
      end      

      local hasExited = false

      if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum) ) then

        if
          (LastStation ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
          (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
        then
          TriggerEvent('esx_scarface:hasExitedMarker', LastStation, LastPart, LastPartNum)
          hasExited = true
        end

        HasAlreadyEnteredMarker = true
        LastStation             = currentStation
        LastPart                = currentPart
        LastPartNum             = currentPartNum

        TriggerEvent('esx_scarface:hasEnteredMarker', currentStation, currentPart, currentPartNum)
      end

      if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
        HasAlreadyEnteredMarker = false
        TriggerEvent('esx_scarface:hasExitedMarker', LastStation, LastPart, LastPartNum)
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

      if IsControlPressed(0,  Keys['E']) and PlayerData.faction ~= nil and PlayerData.faction.name == 'bandits' and (GetGameTimer() - GUI.Time) > 300 then

        if CurrentAction == 'bandits_actions_menu' then
          OpenBanditsActionsMenu()
        end
            
        if CurrentAction == 'menu_armory' then
          OpenArmoryMenu(CurrentActionData.station)
        end                     

        if CurrentAction == 'bandits_actionse_menu1' then
          OpenBanditsActionseMenu()
        end          

        if CurrentAction == 'delete_vehicle1' then

          local playerPed = GetPlayerPed(-1)
          local vehicle   = GetVehiclePedIsIn(playerPed,  false)
          local hash      = GetEntityModel(vehicle)
          local plate     = GetVehicleNumberPlateText(vehicle)
          if hash == GetHashKey('oracle') or hash == GetHashKey('r8prior') or hash == GetHashKey('italia458') or hash == GetHashKey('w124') or hash == GetHashKey('baller6')then
           if Config.MaxInService ~= -1 then
              TriggerServerEvent('esx_service:disableService', 'bandits')
           end
            ESX.Game.DeleteVehicle(vehicle)
            TriggerServerEvent('esx_vehiclelock:deletekeyjobs', 'no', plate) --vehicle lock
          else
            ESX.ShowNotification('Vous ne pouvez ranger que des ~b~véhicules de Faction~s~.')
          end

        end

        CurrentAction = nil
        GUI.Time      = GetGameTimer()

      end

    end

    if IsControlPressed(0,  Keys['F9']) and GetLastInputMethod(2) and PlayerData.faction ~= nil and PlayerData.faction.name == 'bandits' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'cartel_actions') and (GetGameTimer() - GUI.Time) > 150 then
      OpenScarfaceActionsMenu()
      GUI.Time = GetGameTimer()
    end
  end
end)


-----------------------
----- TELEPORTERS -----

AddEventHandler('esx_scarface:teleportMarkers', function(position)
  local pos = GetEntityCoords(GetPlayerPed(-1), true)
  local ped = GetPlayerPed(-1)
  local vehicle = GetVehiclePedIsIn(ped)
  local model = GetEntityModel(vehicle)

  DoScreenFadeOut(1000)
  Citizen.Wait(2500)
  SetEntityCoords(GetPlayerPed(-1), position.x, position.y, position.z)
  local licenseplate = GetVehicleNumberPlateText(vehicle)
  local prop = ESX.Game.GetVehicleProperties(vehicle)
  ESX.Game.DeleteVehicle(vehicle)
  ESX.Game.SpawnVehicle(model, {
    x = position.x,
    y = position.y,
    z = position.z
  }, position.h, function(vehicle)
  ESX.Game.SetVehicleProperties(vehicle, prop)
  TaskWarpPedIntoVehicle(ped, vehicle, -1)
  SetVehicleNumberPlateText(vehicle, licenseplate)
  end)
  DoScreenFadeIn(1000)
end)

function hintShowed(mess)
  SetTextComponentFormat('STRING')
  AddTextComponentString(mess)
  DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

-- Display teleport markers
Citizen.CreateThread(function()
  while true do
    Wait(0)

    if PlayerData.faction ~= nil and PlayerData.faction.name == 'bandits' then

        local coords = GetEntityCoords(GetPlayerPed(-1))
        for k,v in pairs(Config.TeleportZonesBandits) do
          if(v.Marker ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
            DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
          end
        end

        for k,v in pairs(Config.TeleportZonesBandits1) do
          if(v.Marker ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
            DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
          end
        end

        for k,v in pairs(Config.TeleportZonesBandits2) do
          if(v.Marker ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
            DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
          end
        end

        for k,v in pairs(Config.TeleportZonesBandits3) do
          if(v.Marker ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
            DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
          end
        end

    end

  end
end)

-- Activate teleport marker
Citizen.CreateThread(function()
  while true do
    Wait(0)
    local coords      = GetEntityCoords(GetPlayerPed(-1))
    local position    = nil
    local zone        = nil

    if PlayerData.faction ~= nil and PlayerData.faction.name == 'bandits' then

        for k,v in pairs(Config.TeleportZonesBandits) do
          if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
            isInPublicMarker = true
            position = v.Teleport
            zone = v
            hintShowed(zone.Hint)
            break
          else
            isInPublicMarker  = false
          end
        end

        for k,v in pairs(Config.TeleportZonesBandits1) do
          if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
            isInPublicMarker1 = true
            position = v.Teleport
            zone = v
            hintShowed(zone.Hint)
            break
          else
            isInPublicMarker1  = false
          end
        end

        for k,v in pairs(Config.TeleportZonesBandits2) do
          if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
            isInPublicMarker2 = true
            position = v.Teleport
            zone = v
            hintShowed(zone.Hint)
            break
          else
            isInPublicMarker2  = false
          end
        end

        for k,v in pairs(Config.TeleportZonesBandits3) do
          if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
            isInPublicMarker3 = true
            position = v.Teleport
            zone = v
            hintShowed(zone.Hint)
            break
          else
            isInPublicMarker3  = false
          end
        end

        if IsControlJustReleased(0, Keys["E"]) and isInPublicMarker then
          TriggerEvent('esx_scarface:teleportMarkers', position)
        end

        if IsControlJustReleased(0, Keys["E"]) and isInPublicMarker1 then
          TriggerEvent('esx_scarface:teleportMarkers', position)
        end

        if IsControlJustReleased(0, Keys["E"]) and isInPublicMarker2 then
          TriggerEvent('esx_scarface:teleportMarkers', position)
        end

        if IsControlJustReleased(0, Keys["E"]) and isInPublicMarker3 then
          TriggerEvent('esx_scarface:teleportMarkers', position)
        end

    end

  end
end)

function OpenGetBlackMoney()

  ESX.TriggerServerCallback('esx_scarface:getBlackMoneySociety', function(inventory)

    local elements = {}

    table.insert(elements, {label = 'Argent sale : ' .. inventory.blackMoney, type = 'item_account', value = 'black_money'})

    for i=1, #inventory.items, 1 do

      local item = inventory.items[i]

      if item.count > 0 then
        table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
      end
    end

    for i=1, #inventory.weapons, 1 do
      local weapon = inventory.weapons[i]
      table.insert(elements, {label = ESX.GetWeaponLabel(weapon.name) .. ' [' .. weapon.ammo .. ']', type = 'item_weapon', value = weapon.name, ammo = weapon.ammo})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'get_black_money',
      {
        css = 'scarface',
        title    = 'Inventaire',
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)
        if data.current.type == 'item_weapon' then
          menu.close()
          TriggerServerEvent('esx_scarface:getItem', data.current.type, data.current.value, data.current.ammo)
          ESX.SetTimeout(300, function()
            OpenGetBlackMoney()
          end)

        else
          ESX.UI.Menu.Open(
            'dialog', GetCurrentResourceName(), 'get_item_count',
            {
              title = 'Montant',
            },
            function(data2, menu)

              local quantity = tonumber(data2.value)

              if quantity == nil then
                ESX.ShowNotification('Montant invalide')
              else
                menu.close()
                TriggerServerEvent('esx_scarface:getItem', data.current.type, data.current.value, quantity)
                ESX.SetTimeout(300, function()
                  OpenGetBlackMoney()
                end)
              end
            end,
            function(data2,menu)
              menu.close()
            end
          )
        end
      end,
      function(data, menu)
        menu.close()
      end
    )
  end)
end

function OpenPutBlackMoney()

  ESX.TriggerServerCallback('esx_scarface:getPlayerInventory2', function(inventory)

    local elements = {}

    table.insert(elements, {label = 'Argent sale : ' .. inventory.blackMoney, type = 'item_account', value = 'black_money'})

    local playerPed  = GetPlayerPed(-1)
    local weaponList = ESX.GetWeaponList()

    for i=1, #weaponList, 1 do
      local weaponHash = GetHashKey(weaponList[i].name)

      if HasPedGotWeapon(playerPed,  weaponHash,  false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
        local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
        table.insert(elements, {label = weaponList[i].label .. ' [' .. ammo .. ']', type = 'item_weapon', value = weaponList[i].name, ammo = ammo})
      end
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'put_black_money',
      {
        css = 'scarface',
        title    = 'Inventaire',
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        if data.current.type == 'item_weapon' then

          menu.close()

          TriggerServerEvent('esx_scarface:putItem', data.current.type, data.current.value, data.current.ammo)

          ESX.SetTimeout(300, function()
            OpenPutBlackMoney()
          end)
        else

          ESX.UI.Menu.Open(
            'dialog', GetCurrentResourceName(), 'put_item_count',
            {
              title = 'Montant',
            },
            function(data2, menu)

              menu.close()

              TriggerServerEvent('esx_scarface:putItem', data.current.type, data.current.value, tonumber(data2.value))

              ESX.SetTimeout(300, function()
                OpenPutBlackMoney()
              end)

            end,
            function(data2,menu)
              menu.close()
            end
          )

        end

      end,
      function(data, menu)
        menu.close()
      end
    )
  end)
end