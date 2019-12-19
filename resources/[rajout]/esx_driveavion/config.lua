Config                 = {}
Config.DrawDistance    = 100.0
Config.MaxErrors       = 7
Config.SpeedMultiplier = 3.6
Config.Locale          = 'fr'

Config.Prices = {
  dmv_air     = 15000,
  drive_avion = 65000,
  drive_heli  = 50000
}

Config.VehicleModels = {
  drive_avion = 'mammatus',
  drive_heli  = 'frogger'
}

Config.SpeedLimits = {
  residence = 150,
  town      = 170,
  freeway   = 170
}

Config.Zones = {

  DMVSchool = {
    Pos   = {x = -1153.804, y = -2714.862, z = 18.887},
    Size  = {x = 1.5, y = 1.5, z = 1.0},
    Color = {r = 204, g = 204, b = 0},
    Type  = 1
  },

  VehicleSpawnPoint = {
    Pos   = {x = -890.115, y = -3271.003, z = 12.944},
    Size  = {x = 1.5, y = 1.5, z = 1.0},
    Color = {r = 204, g = 204, b = 0},
    Type  = -1
  },

}

Config.CheckPoints = {

  {
    Pos = {x = -1116.909, y = -3076.565, z = 13.101},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('go_next_point') .. Config.SpeedLimits['residence'] .. 'km/h', 5000)
    end
  },

  {
    Pos = {x = -1606.190, y = -2792.115, z = 50.432},
    Action = function(playerPed, vehicle, setCurrentZoneType)
    setCurrentZoneType('town')
      DrawMissionText(_U('go_next_point2') .. Config.SpeedLimits['town'] .. 'km/h', 5000)
    end
  },

  {
    Pos = {x = -2144.878, y = -1678.267, z = 140.503},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('go_next_point3') .. Config.SpeedLimits['town'] .. 'km/h', 5000)
    end
  },

  {
    Pos = {x = -757.745, y = -350.345, z = 373.593},
    Action = function(playerPed, vehicle, setCurrentZoneType)
    setCurrentZoneType('freeway')
      DrawMissionText(_U('go_next_point4') .. Config.SpeedLimits['freeway'] .. 'km/h', 5000)
    end
  },

  {
    Pos = {x = -12.718, y = -1460.511, z = 254.441},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('go_next_point5'), 5000)
    end
  },

  {
    Pos = {x = -1648.950, y = -2776.109, z = 55.394},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('go_next_point6') .. Config.SpeedLimits['freeway'] .. 'km/h', 5000)
    end
  },

  {
    Pos = {x = -976.503, y = -3160.678, z = 13.1011},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('go_next_point7'), 5000)
      ESX.Game.DeleteVehicle(vehicle)
    end
  },

}
