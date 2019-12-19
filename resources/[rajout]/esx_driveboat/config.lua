Config                 = {}
Config.DrawDistance    = 100.0
Config.MaxErrors       = 7
Config.SpeedMultiplier = 3.6
Config.Locale          = 'fr'

Config.Prices = {
  dmv_boat    = 10000,
  drive_boat  = 45000
}

Config.VehicleModels = {
  drive_boat  = 'tropic',
}

Config.SpeedLimits = {
  residence = 50,
  town      = 70,
  freeway   = 100
}

Config.Zones = {

  DMVSchool = {
    Pos   = {x = -816.247, y = -1345.766, z = 4.150},
    Size  = {x = 1.5, y = 1.5, z = 1.0},
    Color = {r = 204, g = 204, b = 0},
    Type  = 1
  },

  VehicleSpawnPoint = {
    Pos   = {x = -871.721, y = -1361.721, z = 0.297},
    Size  = {x = 1.5, y = 1.5, z = 1.0},
    Heading = 199.49409,
    Color = {r = 204, g = 204, b = 0},
    Type  = -1
  },

}

Config.CheckPoints = {

  {
    Pos = {x = -853.573, y = -1412.715, z = 0.290},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('next_point_speed') .. Config.SpeedLimits['residence'] .. 'km/h', 5000)
    end
  },

  {
    Pos = {x = -857.258, y = -1550.523, z = 0.295},
    Action = function(playerPed, vehicle, setCurrentZoneType)

      setCurrentZoneType('town')

      DrawMissionText(_U('go_next_point') .. Config.SpeedLimits['town'] .. 'km/h', 5000)
    end
  },

  {
    Pos = {x = -1260.161, y = -1957.458, z = 0.575},
    Action = function(playerPed, vehicle, setCurrentZoneType)

      setCurrentZoneType('freeway')

      Citizen.CreateThread(function()
        DrawMissionText(_U('stop_for_ped') .. Config.SpeedLimits['freeway'] .. 'km/h', 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
        FreezeEntityPosition(vehicle, true)
        Citizen.Wait(4000)
        FreezeEntityPosition(vehicle, false)
        DrawMissionText(_U('good_lets_cont'), 5000)

      end)
    end
  },

  {
    Pos = {x = -1535.301, y = -1617.938, z = 0.961},
    Action = function(playerPed, vehicle, setCurrentZoneType)

      Citizen.CreateThread(function()
        DrawMissionText(_U('stop_look_left') .. Config.SpeedLimits['freeway'] .. 'km/h', 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
        FreezeEntityPosition(vehicle, true)
        Citizen.Wait(6000)
        FreezeEntityPosition(vehicle, false)
        DrawMissionText(_U('good_lets_cont'), 5000)
      end)
    end
  },

  {
    Pos = {x = -2039.079, y = -1062.479, z = 0.513},
    Action = function(playerPed, vehicle, setCurrentZoneType)

      Citizen.CreateThread(function()
        DrawMissionText(_U('stop_look_left2'), 5000)
        PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
        FreezeEntityPosition(vehicle, true)
        Citizen.Wait(6000)
        FreezeEntityPosition(vehicle, false)
        DrawMissionText(_U('good_lets_cont'), 5000)
      end)
    end
  },

  {
    Pos = {x = -2173.002, y = -1442.939, z = -0.155},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('go_next_point3'), 5000)
    end
  },

  {
    Pos = {x = -1852.249, y = -1758.283, z = 0.237},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('go_next_point2'), 5000)
    end
  },

  {
    Pos = {x = -1163.061, y = -1872.402, z = 0.158},
    Action = function(playerPed, vehicle, setCurrentZoneType)

      setCurrentZoneType('town')

      DrawMissionText(_U('go_next_point4').. Config.SpeedLimits['town'] .. 'km/h', 5000)
    end
  },

  {
    Pos = {x = -852.756, y = -1545.164, z = 0.303},
    Action = function(playerPed, vehicle, setCurrentZoneType)

      setCurrentZoneType('residence')

      DrawMissionText(_U('go_next_point5').. Config.SpeedLimits['residence'] .. 'km/h', 5000)
    end
  },

  {
    Pos = {x = -845.117, y = -1364.036, z = 0.305},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      ESX.Game.DeleteVehicle(vehicle)
    end
  },

}
