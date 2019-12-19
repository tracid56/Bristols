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

local PlayerData                = {}
local GUI                       = {}
local HasAlreadyEnteredMarker   = false
local LastStation               = nil
local LastPart                  = nil
local LastPartNum               = nil
local LastEntity                = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local IsHandcuffed              = false
local IsDragged                 = false
local CopPed                    = 0
local hasAlreadyJoined          = false
local blipsCops                 = {}
local playerInService           = false
local isDead                    = false
local OnJob                     = false
CurrentTask                     = {}

ESX                             = nil
GUI.Time                        = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
end)

function DrawSub(msg, time)
  ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(msg)
	DrawSubtitleTimed(time, 1)
end

function Pompier()
  Citizen.CreateThread(function()
    while messagenotfinish do
        Citizen.Wait(1)

      AddTextEntry('FMMC_MPM_NA', "Message de l'annonce")
      DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 44)
        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0);
           Citizen.Wait(1)
        end
        if (GetOnscreenKeyboardResult()) then
            local result = GetOnscreenKeyboardResult()
            messagenotfinish = false
            TriggerServerEvent('esx_pompierjob:pompier',result)
            
        end


    end
  end)
  
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

function StartPompierJob()

	ShowLoadingPromt(_U('taking_service') .. 'LSFD', 5000, 3)
	ClearCurrentMission()

	OnJob = true

end

function StopPompierJob()

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

	DrawSub('Mission terminée', 5000)

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

function getJob()
  if PlayerData.job ~= nil then
	return PlayerData.job.name	
  end  
end


function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
  ResetPedMovementClipset(playerPed, 0)
end

function setUniform(job, playerPed)
  TriggerEvent('skinchanger:getSkin', function(skin)

    if skin.sex == 0 then
      if Config.Uniforms[job].male ~= nil then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
      else
        CopsNotification('Il n\'y a pas d\'uniforme à votre taille...')
      end
      if job == 'bullet_wear' then
        SetPedArmour(playerPed, 100)
      end
    else
      if Config.Uniforms[job].female ~= nil then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
      else
        CopsNotification('Il n\'y a pas d\'uniforme à votre taille...')
      end
      if job == 'bullet_wear' then
        SetPedArmour(playerPed, 100)
      end
    end
  end)
end

function OpenCloakroomMenu()

  local playerPed = GetPlayerPed(-1)

  local elements = {
    { label = 'Tenue Civil', value = 'citizen_wear' }
    -- { label = 'Mettre le gilet pare-balles', value = 'veste_wear' },
    -- { label = 'Enlever le gilet pare-balles', value = 'gilet_wear' }
  }

  if PlayerData.job.grade_name == 'sapeurtest' then
    table.insert(elements, {label = 'Tenue LSFD', value = 'lsfd_wear'})
    -- table.insert(elements, {label = 'Tenue Secouriste', value = 'secouriste'})
  end

  if PlayerData.job.grade_name == 'caporal' then
    table.insert(elements, {label = 'Tenue LSFD', value = 'lsfd_wear'})
    -- table.insert(elements, {label = 'Tenue Secouriste', value = 'secouriste'})
  end

  if PlayerData.job.grade_name == 'sergentsp' then
    table.insert(elements, {label = 'Tenue LSFD', value = 'lsfd_wear'})
    -- table.insert(elements, {label = 'Tenue Secouriste', value = 'secouriste'})
  end

  if PlayerData.job.grade_name == 'adjudant' then
    table.insert(elements, {label = 'Tenue LSFD', value = 'lsfd_wear'})
    -- table.insert(elements, {label = 'Tenue Secouriste', value = 'secouriste'})
  end

  if PlayerData.job.grade_name == 'boss' then
    table.insert(elements, {label = 'Tenue LSFD', value = 'lsfd_wear'})
    -- ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
    -- if skin.sex == 1 then
    -- table.insert(elements, {label = 'Tenue Secouriste', value = 'secouriste'})
    -- end
  end

  if Config.EnableNonFreemodePeds then
    table.insert(elements, {label = 'Tenue sheriff', value = 'sheriff_wear_freemode'})
    table.insert(elements, {label = 'Tenue Swatt', value = 'lieutenant_wear_freemode'})
    table.insert(elements, {label = 'Tenue Commandant', value = 'commandant_wear_freemode'})
  end

  ESX.UI.Menu.CloseAll()

  if Config.EnableNonFreemodePeds then
    table.insert(elements, {label = 'Tenue Sheriff', value = 'sheriff_wear'})
    table.insert(elements, {label = 'Tenue Commandant', value = 'commandant_wear'})
  end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'cloakroom',
      {
        title    = 'Vestiaire',
        align    = 'top-left',
        elements = elements,
        },

        function(data, menu)

      menu.close()

      cleanPlayer(playerPed)


      if data.current.value == 'citizen_wear' then
        TriggerServerEvent('esx_pompierjob:removeWeapon', "WEAPON_FIREEXTINGUISHER")
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
          local model = nil

          if skin.sex == 0 then
            model = GetHashKey("mp_m_freemode_01")
          else
            model = GetHashKey("mp_f_freemode_01")
          end

          RequestModel(model)
          while not HasModelLoaded(model) do
            RequestModel(model)
            Citizen.Wait(1)
          end

          SetPlayerModel(PlayerId(), model)
          SetModelAsNoLongerNeeded(model)
          
          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        end)
      end

      if data.current.value == 'lsfd_wear' then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
          if skin.sex == 0 then
      TriggerServerEvent('esx_pompierjob:giveWeapon', "WEAPON_FIREEXTINGUISHER",  1000)
			SetPedComponentVariation(GetPlayerPed(-1), 9, 0, 0, 2)   -- retrait parballes du swat
			SetPedComponentVariation(GetPlayerPed(-1), 1, 0, 0, 0)   -- retrait Mask du swat
			SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2)	  --retrait cravate
			SetPedComponentVariation(GetPlayerPed(-1), 10, 0, 0, 2)	  --retrait grade
			SetPedPropIndex(GetPlayerPed(-1), 0, 11,0, 0) -- casque
		    local playerPed = GetPlayerPed(-1)
            SetPedArmour(playerPed, 0)
			
			SetPedPropIndex(GetPlayerPed(-1), 0, 111,8, 0) -- Casquette police	
			SetPedComponentVariation(GetPlayerPed(-1), 3, 96, 0, 0)--gants/top
			SetPedComponentVariation(GetPlayerPed(-1), 4, 97, 0, 0)--/pentalon/pant
			SetPedComponentVariation(GetPlayerPed(-1), 6, 24, 0, 0)--chaussures/shoes
			SetPedComponentVariation(GetPlayerPed(-1), 8, 16, 0, 0)--mattraque (shirt)
			SetPedComponentVariation(GetPlayerPed(-1), 11, 251, 0, 0)--veste/jacket
			SetPedPropIndex(GetPlayerPed(-1), 2, 2, 0, 1) --Oreillete
			SetPedPropIndex(GetPlayerPed(-1), 1, 5, 0, 1) -- lunette
			-- SetPedComponentVariation(GetPlayerPed(-1), 8, 59, 1, 0) --GiletJaune

          end
        end)
      end

      if data.current.value == 'lsfd_wear' then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
          if skin.sex == 1 then
      TriggerServerEvent('esx_pompierjob:giveWeapon', "WEAPON_FIREEXTINGUISHER",  1000)
			SetPedComponentVariation(GetPlayerPed(-1), 9, 0, 0, 2)   -- retrait parballes du swat
			SetPedComponentVariation(GetPlayerPed(-1), 1, 0, 0, 0)   -- retrait Mask du swat
			SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2)	  --retrait cravate		
			SetPedComponentVariation(GetPlayerPed(-1), 10, 0, 0, 2)	  --retrait grade
			SetPedPropIndex(GetPlayerPed(-1), 0, 57,0, 0) -- casque
			local playerPed = GetPlayerPed(-1)
            SetPedArmour(playerPed, 0)

			SetPedPropIndex(GetPlayerPed(-1), 0, 46,0, 0) -- Casquette police	
			SetPedComponentVariation(GetPlayerPed(-1), 3, 111, 0, 0)--gants/top
			SetPedComponentVariation(GetPlayerPed(-1), 4, 95, 14, 2) --Jean
			SetPedComponentVariation(GetPlayerPed(-1), 6, 24, 0, 2)--Chaussure
			SetPedComponentVariation(GetPlayerPed(-1), 8, 3, 0, 2)--mattraque (shirt)
			SetPedComponentVariation(GetPlayerPed(-1), 11, 256, 0, 2)--Veste
			SetPedPropIndex(GetPlayerPed(-1), 2, 0, 0, 2)--Oreillete
			SetPedPropIndex(GetPlayerPed(-1), 1, 11, 3, 2) -- lunette femme
			-- SetPedComponentVariation(GetPlayerPed(-1), 8, 36, 0, 2) --GiletJaune

          end
        end)
      end

      if data.current.value == 'secouriste' then --Ajout de tenue par grades

        Citizen.CreateThread(function()
    
    local model = GetHashKey("s_f_y_scrubs_01")

    RequestModel(model)
    while not HasModelLoaded(model) do
      RequestModel(model)
      Citizen.Wait(0)
    end
   
    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)
    RemoveAllPedWeapons(GetPlayerPed(-1), false)
  end)

      end

      if data.current.value == 'lsfd' then --Ajout de tenue par grades

        Citizen.CreateThread(function()
    
    local model = GetHashKey("s_m_y_fireman_01")

    RequestModel(model)
    while not HasModelLoaded(model) do
      RequestModel(model)
      Citizen.Wait(0)
    end
   
    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)
    
    RemoveAllPedWeapons(GetPlayerPed(-1), false)
  end)

      end

      CurrentAction     = 'menu_cloakroom'
      CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour vous changer'
      CurrentActionData = {}

    end,
    function(data, menu)
      menu.close()
      CurrentAction     = 'menu_cloakroom'
      CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour vous changer'
      CurrentActionData = {}
    end
  )
end

function OpenCloakroomMenuF6()

  local playerPed = GetPlayerPed(-1)

  local elements = {
    { label = 'Tenue Civil', value = 'citizen_wear' }
    -- { label = 'Mettre le gilet pare-balles', value = 'veste_wear' },
    -- { label = 'Enlever le gilet pare-balles', value = 'gilet_wear' }
  }

  if PlayerData.job.grade_name == 'sapeurtest' then
    table.insert(elements, {label = 'Tenue LSFD', value = 'lsfd_wear'})
    -- table.insert(elements, {label = 'Tenue Secouriste', value = 'secouriste'})
  end

  if PlayerData.job.grade_name == 'caporal' then
    table.insert(elements, {label = 'Tenue LSFD', value = 'lsfd_wear'})
    -- table.insert(elements, {label = 'Tenue Secouriste', value = 'secouriste'})
  end

  if PlayerData.job.grade_name == 'sergentsp' then
    table.insert(elements, {label = 'Tenue LSFD', value = 'lsfd_wear'})
    -- table.insert(elements, {label = 'Tenue Secouriste', value = 'secouriste'})
  end

  if PlayerData.job.grade_name == 'adjudant' then
    table.insert(elements, {label = 'Tenue LSFD', value = 'lsfd_wear'})
    -- table.insert(elements, {label = 'Tenue Secouriste', value = 'secouriste'})
  end

  if PlayerData.job.grade_name == 'boss' then
    table.insert(elements, {label = 'Tenue LSFD', value = 'lsfd_wear'})
    -- ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
    -- if skin.sex == 1 then
    -- table.insert(elements, {label = 'Tenue Secouriste', value = 'secouriste'})
    -- end
  end

  if Config.EnableNonFreemodePeds then
    table.insert(elements, {label = 'Tenue sheriff', value = 'sheriff_wear_freemode'})
    table.insert(elements, {label = 'Tenue Swatt', value = 'lieutenant_wear_freemode'})
    table.insert(elements, {label = 'Tenue Commandant', value = 'commandant_wear_freemode'})
  end

  ESX.UI.Menu.CloseAll()

  if Config.EnableNonFreemodePeds then
    table.insert(elements, {label = 'Tenue Sheriff', value = 'sheriff_wear'})
    table.insert(elements, {label = 'Tenue Commandant', value = 'commandant_wear'})
  end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'cloakroom',
      {
        title    = 'Vestiaire',
        align    = 'top-left',
        elements = elements,
        },

        function(data, menu)

      menu.close()

      cleanPlayer(playerPed)


      if data.current.value == 'citizen_wear' then
        TriggerServerEvent('esx_pompierjob:removeWeapon', "WEAPON_FIREEXTINGUISHER")
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
          local model = nil

          if skin.sex == 0 then
            model = GetHashKey("mp_m_freemode_01")
          else
            model = GetHashKey("mp_f_freemode_01")
          end

          RequestModel(model)
          while not HasModelLoaded(model) do
            RequestModel(model)
            Citizen.Wait(1)
          end

          SetPlayerModel(PlayerId(), model)
          SetModelAsNoLongerNeeded(model)
          
          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        end)
      end

      if data.current.value == 'lsfd_wear' then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
          if skin.sex == 0 then
      TriggerServerEvent('esx_pompierjob:giveWeapon', "WEAPON_FIREEXTINGUISHER",  1000)
			SetPedComponentVariation(GetPlayerPed(-1), 9, 0, 0, 2)   -- retrait parballes du swat
			SetPedComponentVariation(GetPlayerPed(-1), 1, 0, 0, 0)   -- retrait Mask du swat
			SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2)	  --retrait cravate
			SetPedComponentVariation(GetPlayerPed(-1), 10, 0, 0, 2)	  --retrait grade
			SetPedPropIndex(GetPlayerPed(-1), 0, 11,0, 0) -- casque
		    local playerPed = GetPlayerPed(-1)
            SetPedArmour(playerPed, 0)
			
			SetPedPropIndex(GetPlayerPed(-1), 0, 111,8, 0) -- Casquette police	
			SetPedComponentVariation(GetPlayerPed(-1), 3, 96, 0, 0)--gants/top
			SetPedComponentVariation(GetPlayerPed(-1), 4, 97, 0, 0)--/pentalon/pant
			SetPedComponentVariation(GetPlayerPed(-1), 6, 24, 0, 0)--chaussures/shoes
			SetPedComponentVariation(GetPlayerPed(-1), 8, 16, 0, 0)--mattraque (shirt)
			SetPedComponentVariation(GetPlayerPed(-1), 11, 251, 0, 0)--veste/jacket
			SetPedPropIndex(GetPlayerPed(-1), 2, 2, 0, 1) --Oreillete
			SetPedPropIndex(GetPlayerPed(-1), 1, 5, 0, 1) -- lunette
			-- SetPedComponentVariation(GetPlayerPed(-1), 8, 59, 1, 0) --GiletJaune

          end
        end)
      end

      if data.current.value == 'lsfd_wear' then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
          if skin.sex == 1 then
      TriggerServerEvent('esx_pompierjob:giveWeapon', "WEAPON_FIREEXTINGUISHER",  1000)
			SetPedComponentVariation(GetPlayerPed(-1), 9, 0, 0, 2)   -- retrait parballes du swat
			SetPedComponentVariation(GetPlayerPed(-1), 1, 0, 0, 0)   -- retrait Mask du swat
			SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2)	  --retrait cravate		
			SetPedComponentVariation(GetPlayerPed(-1), 10, 0, 0, 2)	  --retrait grade
			SetPedPropIndex(GetPlayerPed(-1), 0, 57,0, 0) -- casque
			local playerPed = GetPlayerPed(-1)
            SetPedArmour(playerPed, 0)

			SetPedPropIndex(GetPlayerPed(-1), 0, 46,0, 0) -- Casquette police	
			SetPedComponentVariation(GetPlayerPed(-1), 3, 111, 0, 0)--gants/top
			SetPedComponentVariation(GetPlayerPed(-1), 4, 95, 14, 2) --Jean
			SetPedComponentVariation(GetPlayerPed(-1), 6, 24, 0, 2)--Chaussure
			SetPedComponentVariation(GetPlayerPed(-1), 8, 3, 0, 2)--mattraque (shirt)
			SetPedComponentVariation(GetPlayerPed(-1), 11, 256, 5, 2)--Veste
			SetPedPropIndex(GetPlayerPed(-1), 2, 0, 0, 2)--Oreillete
			SetPedPropIndex(GetPlayerPed(-1), 1, 11, 3, 2) -- lunette femme
			-- SetPedComponentVariation(GetPlayerPed(-1), 8, 36, 0, 2) --GiletJaune

          end
        end)
      end

      if data.current.value == 'secouriste' then --Ajout de tenue par grades

        Citizen.CreateThread(function()
    
    local model = GetHashKey("s_f_y_scrubs_01")

    RequestModel(model)
    while not HasModelLoaded(model) do
      RequestModel(model)
      Citizen.Wait(0)
    end
   
    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)
    RemoveAllPedWeapons(GetPlayerPed(-1), false)
  end)

      end

      if data.current.value == 'lsfd' then --Ajout de tenue par grades

        Citizen.CreateThread(function()
    
    local model = GetHashKey("s_m_y_fireman_01")
    -- local model = GetHashKey("s_m_y_fireman_01_p")

    RequestModel(model)
    while not HasModelLoaded(model) do
      RequestModel(model)
      Citizen.Wait(0)
    end
   
    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)
    
    RemoveAllPedWeapons(GetPlayerPed(-1), false)
  end)

      end

      -- CurrentAction     = 'menu_cloakroom'
      -- CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour vous changer'
      CurrentActionData = {}

    end,
    function(data, menu)
      menu.close()
      -- CurrentAction     = 'menu_cloakroom'
      -- CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour vous changer'
      CurrentActionData = {}
    end
  )
end

function OpenArmoryMenu(station)

  if Config.EnableArmoryManagement then

    local elements = {
      {label = 'Armes',     value = 'get_weapon'},
      {label = 'Déposer une Arme',     value = 'put_weapon'},
      {label = 'Prendre une Arme',  value = 'get_stock'},
      {label = 'Déposer un Objet', value = 'put_stock'}
    }

    if PlayerData.job.grade_name == 'boss' then
      table.insert(elements, {label = 'Acheter une Armes', value = 'buy_weapons'})
    end

    if PlayerData.job.grade_name == 'detective' then
      table.insert(elements, {label = 'Acheter une Armes', value = 'buy_weapons'})
    end

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory',
      {
        title    = 'Armurerie',
        align    = 'left',
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

        if data.current.value == 'put_stock' then
          OpenPutStocksMenu()
        end

        if data.current.value == 'get_stock' then
          OpenGetStocksMenu()
        end

      end,
      function(data, menu)

        menu.close()

        CurrentAction     = 'menu_armory'
        CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder à l\'armurerie'
        CurrentActionData = {station = station}
      end
    )

  else

    local elements = {}

    for i=1, #Config.PoliceStations[station].AuthorizedWeapons, 1 do
      local weapon = Config.PoliceStations[station].AuthorizedWeapons[i]
      table.insert(elements, {label = ESX.GetWeaponLabel(weapon.name), value = weapon.name})
    end

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory',
      {
        title    = 'Armurerie',
        align    = 'left',
        elements = elements,
      },
      function(data, menu)
        local weapon = data.current.value
        TriggerServerEvent('esx_pompierjob:giveWeapon', weapon,  1000)
      end,
      function(data, menu)

        menu.close()

        CurrentAction     = 'menu_armory'
        CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder à l\'armurerie'
        CurrentActionData = {station = station}

      end
    )

  end

end

function OpenVehicleSpawnerMenu(station, partNum)

  local vehicles = Config.PoliceStations[station].Vehicles

  ESX.UI.Menu.CloseAll()

  if Config.EnableSocietyOwnedVehicles then

    local elements = {}

    ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(garageVehicles)

      for i=1, #garageVehicles, 1 do
        table.insert(elements, {label = GetDisplayNameFromVehicleModel(garageVehicles[i].model) .. ' [' .. garageVehicles[i].plate .. ']', value = garageVehicles[i]})
      end

      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'vehicle_spawner',
        {
          title    = 'Véhicule',
          align    = 'left',
          elements = elements,
        },
        function(data, menu)

          menu.close()

          local vehicleProps = data.current.value

          ESX.Game.SpawnVehicle(vehicleProps.model, vehicles[partNum].SpawnPoint, 270.0, function(vehicle)
            ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
            local playerPed = GetPlayerPed(-1)
            TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
          end)

          TriggerServerEvent('esx_society:removeVehicleFromGarage', 'pompier', vehicleProps)

        end,
        function(data, menu)

          menu.close()

          CurrentAction     = 'menu_vehicle_spawner'
          CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour sortir un véhicule'
          CurrentActionData = {station = station, partNum = partNum}

        end
      )

    end, 'pompier')

  else

    local elements = {}
    table.insert(elements, { label = 'Camion', value = 'firetruk' })
    table.insert(elements, { label = 'Voiture', value = 'firevic' })
    table.insert(elements, { label = '4x4', value = 'fireexp' })
    table.insert(elements, { label = 'Ambulance', value = 'ambulance' })
    -- table.insert(elements, { label = 'Ford Chef', value = 'firetruk4' })
    table.insert(elements, { label = 'Hélico', value = 'maverick' })
  
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'vehicle_spawner',
      {
        title    = 'Véhicule',
        align    = 'left',
        elements = elements,
      },
      function(data, menu)

        menu.close()

        local model = data.current.value

        local vehicle = GetClosestVehicle(vehicles[partNum].SpawnPoint.x,  vehicles[partNum].SpawnPoint.y,  vehicles[partNum].SpawnPoint.z,  3.0,  0,  71)

        if not DoesEntityExist(vehicle) then


          if Config.MaxInService == -1 then

            local playerPed = GetPlayerPed(-1)
            local platenum = math.random(100, 900)
            ESX.Game.SpawnVehicle(model, {
              x = vehicles[partNum].SpawnPoint.x,
              y = vehicles[partNum].SpawnPoint.y,
              z = vehicles[partNum].SpawnPoint.z
            }, vehicles[partNum].Heading, function(vehicle)
              TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
              SetVehicleMaxMods(vehicle)
              SetVehicleNumberPlateText(vehicle, "LSFD" .. platenum)
              TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
              local plate = GetVehicleNumberPlateText(vehicle)
              plate = string.gsub(plate, " ", "")
            TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
            end)

          else

            ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)

              if canTakeService then

                local playerPed = GetPlayerPed(-1)
                local platenum = math.random(100, 900)
                 ESX.Game.SpawnVehicle(model, {
                 x = vehicles[partNum].SpawnPoint.x,
                 y = vehicles[partNum].SpawnPoint.y,
                 z = vehicles[partNum].SpawnPoint.z
                }, vehicles[partNum].Heading, function(vehicle)
                 TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
                 SetVehicleMaxMods(vehicle)
                 SetVehicleNumberPlateText(vehicle, "LSFD" .. platenum)
                 TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                 local plate = GetVehicleNumberPlateText(vehicle)
                 plate = string.gsub(plate, " ", "")
                TriggerServerEvent('esx_vehiclelock:givekey', 'no', plate) -- vehicle lock
                end)

              else
                CopsNotification('Service complet :' .. inServiceCount .. '/' .. maxInService)
              end

            end, 'pompier')

          end

        else
          CopsNotification('Il y a déjà un véhicule de sorti')
        end

      end,
      function(data, menu)

        menu.close()

        CurrentAction     = 'menu_vehicle_spawner'
        CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour sortir un véhicule'
        CurrentActionData = {station = station, partNum = partNum}

      end
    )

  end

end


----Notification
function CopsNotification(text)
  SetNotificationTextEntry('String')
  AddTextComponentString(text)
  DrawNotification(false, false)
end

function OpenPoliceActionsMenu()

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'police_actions',
    {
      title    = 'L.S.F.D',
      align    = 'left',
      elements = {
        {label = 'Vestiaire', value = 'vestiairef6'},
        {label = 'Interaction Citoyen', value = 'citizen_interaction'},
        {label = 'Interaction Objet',      value = 'object_spawner'},
        -- {label = '🔭 Mettre/Retirer Radar',    value = 'radar_spawner'},
        {label = 'Faire une annonce', value = 'announce'},
        -- {label = 'Voir le casier judiciaire',  value = 'getshowcase'},
      },
    },
    function(data, menu)--OpenCloakroomMenu

      if data.current.value == 'vestiairef6' then
        OpenCloakroomMenuF6()
      end

      if data.current.value == 'citizen_interaction' then
        local elements = {
          {label = 'Réanimer',   value = 'revive'},
          {label = 'Soigner',   value = 'soin'},
          {label = 'Mettre dans la voiture', value = 'put_in_vehicle'},
        }
        
        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'citizen_interaction',
          {
            title    = 'Interaction Citoyen',
            align    = 'left',
            elements = elements
          },
					function(data, menu)

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

      if data.current.value == 'vehicle_interaction' then

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'vehicle_interaction',
          {
            title    = 'Interaction Vehicule',
            align    = 'left',
            elements = {
              {label = 'Info du vehicule', value = 'vehicle_infos'},
              {label = 'Crocheter le vehicule',    value = 'hijack_vehicle'},
              {label = 'Fourrière',    value = 'del_veh'},
              {label = 'Information Plaque',    value = 'search_database'},
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

              if data2.current.value == 'search_database' then
                LookupVehicle()
              end

              if data2.current.value == 'del_veh' then
                TriggerEvent('esx:deleteVehicle', source)
                TriggerEvent('esx:showNotification', 'Véhicule mis ~r~en fourrière')
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

                      TriggerEvent('esx:showNotification', 'Vehicule déverrouiller')
                    end)

                  end

                end

              end

            else
              CopsNotification('Pas de vehicule trouver a proximiter')
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end

      if data.current.value == 'radar_spawner' then
       POLICE_radar() 
      end

      if data.current.value == 'announce' then
        messagenotfinish = true
        Pompier()
      end

      if data.current.value == 'getshowcase' then
        TriggerEvent('jsfour-criminalrecord:casier')
      end

      if data.current.value == 'object_spawner' then

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'citizen_interaction',
          {
            title    = 'Interaction Objets',
            align    = 'top-left',
            elements = {
              {label = 'Plot',     value = 'prop_roadcone02a'},
              {label = 'Barrière', value = 'prop_barrier_work06a'},
              {label = 'Herse',    value = 'p_ld_stinger_s'},
              {label = 'Caisse',   value = 'prop_boxpile_07d'}
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

	ESX.TriggerServerCallback('esx_pompierjob:getOtherPlayerData', function(data)

		local elements    = {}
		local nameLabel   = _U('name', data.name)
		local jobLabel    = nil
		local sexLabel    = nil
		local dobLabel    = nil
		local heightLabel = nil
		local idLabel     = nil
	
		if data.job.grade_label ~= nil and  data.job.grade_label ~= '' then
			jobLabel = _U('job', data.job.label .. ' ' .. data.job.grade_label)
		else
			jobLabel = _U('job', data.job.label)
		end
	
		if Config.EnableESXIdentity then
	
			nameLabel = _U('name', data.firstname .. ' ' .. data.lastname)
	
			if data.sex ~= nil then
				if string.lower(data.sex) == 'm' then
					sexLabel = _U('sex', _U('male'))
				else
					sexLabel = _U('sex', _U('female'))
				end
			else
				sexLabel = _U('sex', _U('unknown'))
			end
	
			if data.dob ~= nil then
				dobLabel = _U('dob', data.dob)
			else
				dobLabel = _U('dob', _U('unknown'))
			end
	
			if data.height ~= nil then
				heightLabel = _U('height', data.height)
			else
				heightLabel = _U('height', _U('unknown'))
			end
	
			if data.name ~= nil then
				idLabel = _U('id', data.name)
			else
				idLabel = _U('id', _U('unknown'))
			end
	
		end
	
		local elements = {
			{label = nameLabel, value = nil},
			{label = jobLabel,  value = nil},
		}
	
		if Config.EnableESXIdentity then
			table.insert(elements, {label = sexLabel, value = nil})
			table.insert(elements, {label = dobLabel, value = nil})
			table.insert(elements, {label = heightLabel, value = nil})
			table.insert(elements, {label = idLabel, value = nil})
		end
	
		if data.drunk ~= nil then
			table.insert(elements, {label = 'Alcoolémie : ' .. data.drunk .. '%', value = nil})
		end
	
		if data.licenses ~= nil then
	
			table.insert(elements, {label = _U('license_label'), value = nil})
	
			for i=1, #data.licenses, 1 do
				table.insert(elements, {label = data.licenses[i].label, value = nil})
			end
	
		end
	
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction',
		{
			title    = _U('citizen_interaction'),
			align    = 'top-left',
			elements = elements,
		}, function(data, menu)
	
		end, function(data, menu)
			menu.close()
		end)
	
	end, GetPlayerServerId(player))

end

function OpenBodySearchMenu(player)

  ESX.TriggerServerCallback('esx_pompierjob:getOtherPlayerData', function(data)

    local elements = {}

    local blackMoney = 0

    for i=1, #data.accounts, 1 do
      if data.accounts[i].name == 'black_money' then
        blackMoney = data.accounts[i].money
      end
    end

    table.insert(elements, {
      label          = 'Confisquer l\'argent sale: ' .. blackMoney .. "$",
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
        title    = 'Fouiller',
        align    = 'left',
        elements = elements,
      },
      function(data, menu)

        local itemType = data.current.itemType
        local itemName = data.current.value
        local amount   = data.current.amount

        if data.current.value ~= nil then

          TriggerServerEvent('esx_pompierjob:confiscatePlayerItem', GetPlayerServerId(player), itemType, itemName, amount)

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
      title    = 'Amende',
      align    = 'left',
      elements = {
	  {label = 'Code de la route',   value = 0},
	  {label = 'Infraction Etat',     value = 1},
    {label = 'Infraction Citoyen', value = 2},
	  {label = 'Infraction Armes', value = 3},
	  {label = 'Infraction Stupéfiant', value = 4},
	  {label = 'Grand Banditisme', value = 5},
	  --{label = 'Caution', value = 6}
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

  ESX.TriggerServerCallback('esx_pompierjob:getFineList', function(fines)

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
        title    = 'Amende',
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
                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_police', 'Amende: ' .. label, amount)
            end)    
        else
          TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), '', 'Amende: ' .. label, amount)
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

function LookupVehicle()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'lookup_vehicle',
	{
		title = _U('search_database_title'),
	}, function(data, menu)
		local length = string.len(data.value)
		if data.value == nil or length < 2 or length > 13 then
			ESX.ShowNotification(_U('search_database_error_invalid'))
		else
			ESX.TriggerServerCallback('esx_pompierjob:getVehicleFromPlate', function(owner, found)
				if found then
					ESX.ShowNotification(_U('search_database_found', owner))
				else
					ESX.ShowNotification(_U('search_database_error_not_found'))
				end
			end, data.value)
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)
end

function ShowPlayerLicense(player)
	local elements = {}
	local targetName
	ESX.TriggerServerCallback('esx_pompierjob:getOtherPlayerData', function(data)
		if data.licenses ~= nil then
			for i=1, #data.licenses, 1 do
				if data.licenses[i].label ~= nil and data.licenses[i].type ~= nil then
					table.insert(elements, {label = data.licenses[i].label, value = data.licenses[i].type})
				end
			end
		end
		
		if Config.EnableESXIdentity then
			targetName = data.firstname .. ' ' .. data.lastname
		else
			targetName = data.name
		end
		
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_license',
		{
			title    = _U('license_revoke'),
			align    = 'top-left',
			elements = elements,
		}, function(data, menu)
			ESX.ShowNotification(_U('licence_you_revoked', data.current.label, targetName))
			TriggerServerEvent('esx_pompierjob:message', GetPlayerServerId(player), _U('license_revoked', data.current.label))
			
			TriggerServerEvent('esx_license:removeLicense', GetPlayerServerId(player), data.current.value)
			
			ESX.SetTimeout(300, function()
				ShowPlayerLicense(player)
			end)
		end, function(data, menu)
			menu.close()
		end)

	end, GetPlayerServerId(player))
end

function OpenVehicleInfosMenu(vehicleData)

  ESX.TriggerServerCallback('esx_pompierjob:getVehicleInfos', function(infos)

    local elements = {}

    table.insert(elements, {label = 'Plaque: ' .. infos.plate, value = nil})

    if infos.owner == nil then
      table.insert(elements, {label = 'Propriétaire: Inconnu', value = nil})
    else
      table.insert(elements, {label = 'Propriétaire: ' .. infos.owner, value = nil})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'vehicle_infos',
      {
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

function OpenGetWeaponMenu()

  ESX.TriggerServerCallback('esx_pompierjob:getArmoryWeapons', function(weapons)

    local elements = {}

    for i=1, #weapons, 1 do
      if weapons[i].count > 0 then
        table.insert(elements, {label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name), value = weapons[i].name})
      end
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory_get_weapon',
      {
        title    = 'Armurerie - Prendre une Arme',
        align    = 'left',
        elements = elements,
      },
      function(data, menu)

        menu.close()

        ESX.TriggerServerCallback('esx_pompierjob:removeArmoryWeapon', function()
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
      title    = 'Armurerie - Déposer une Arme',
      align    = 'left',
      elements = elements,
    },
    function(data, menu)

      menu.close()

      ESX.TriggerServerCallback('esx_pompierjob:addArmoryWeapon', function()
        OpenPutWeaponMenu()
      end, data.current.value, true)

    end,
    function(data, menu)
      menu.close()
    end
  )

end

function OpenBuyWeaponsMenu(station)

  ESX.TriggerServerCallback('esx_pompierjob:getArmoryWeapons', function(weapons)

    local elements = {}

    for i=1, #Config.PoliceStations[station].AuthorizedWeapons, 1 do

      local weapon = Config.PoliceStations[station].AuthorizedWeapons[i]
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
        title    = 'Armurerie - Acheter Armes',
        align    = 'left',
        elements = elements,
      },
      function(data, menu)

        ESX.TriggerServerCallback('esx_pompierjob:buy', function(hasEnoughMoney)

          if hasEnoughMoney then
            ESX.TriggerServerCallback('esx_pompierjob:addArmoryWeapon', function()
              OpenBuyWeaponsMenu(station)
            end, data.current.value,false)
          else
            CopsNotification('vous n\'avez pas assez d\'argent')
          end

        end, data.current.price)

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenGetStocksMenu()

  ESX.TriggerServerCallback('esx_pompierjob:getStockItems', function(items)


    local elements = {}

    for i=1, #items, 1 do
      table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'stocks_menu',
      {
        title    = 'Police Stock',
        elements = elements
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
          {
            title = 'Quantité'
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              CopsNotification('Quantité invalide')
            else
              menu2.close()
              menu.close()
              OpenGetStocksMenu()

              TriggerServerEvent('esx_pompierjob:getStockItem', itemName, count)
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

  ESX.TriggerServerCallback('esx_pompierjob:getPlayerInventory', function(inventory)

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
        title    = 'Inventaire',
        elements = elements
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count',
          {
            title = 'Quantité invalide'
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              CopsNotification('Quantité invalide')
            else
              menu2.close()
              menu.close()
              OpenPutStocksMenu()

              TriggerServerEvent('esx_pompierjob:putStockItems', itemName, count)
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

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
  if PlayerData.job.name == 'pompier' then
    TriggerServerEvent("player:serviceOff", "gouvernement")
		TriggerServerEvent("player:serviceOff", "police")
    TriggerServerEvent("player:serviceOff", "brinks")
    TriggerServerEvent("player:serviceOff", "pompier")
		TriggerServerEvent("player:serviceOff", "ambulance")
		TriggerServerEvent("player:serviceOff", "immobillier")
		TriggerServerEvent("player:serviceOff", "depanneur")
		TriggerServerEvent("player:serviceOff", "taxi")
		TriggerServerEvent("player:serviceOff", "chauffeur")
		TriggerServerEvent("player:serviceOff", "unicorn")
	  TriggerServerEvent("player:serviceOff", "banquier")
		TriggerServerEvent("player:serviceOff", "journaliste")
		TriggerServerEvent("player:serviceOff", "vigneron")
		TriggerServerEvent("player:serviceOff", "bahamas")
		TriggerServerEvent("player:serviceOff", "brasseur")
		TriggerServerEvent("player:serviceOff", "tabac")
    TriggerServerEvent("player:serviceOn", "pompier")
  end
	
	Citizen.Wait(5000)
	TriggerServerEvent('esx_pompierjob:forceBlip')
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)

  local specialContact = {
    name       = 'Pompier',
    number     = 'pompier',
    base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoV2luZG93cykiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NDFGQTJDRkI0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NDFGQTJDRkM0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo0MUZBMkNGOTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo0MUZBMkNGQTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PoW66EYAAAjGSURBVHjapJcLcFTVGcd/u3cfSXaTLEk2j80TCI8ECI9ABCyoiBqhBVQqVG2ppVKBQqUVgUl5OU7HKqNOHUHU0oHamZZWoGkVS6cWAR2JPJuAQBPy2ISEvLN57+v2u2E33e4k6Ngz85+9d++95/zP9/h/39GpqsqiRYsIGz8QZAq28/8PRfC+4HT4fMXFxeiH+GC54NeCbYLLATLpYe/ECx4VnBTsF0wWhM6lXY8VbBE0Ch4IzLcpfDFD2P1TgrdC7nMCZLRxQ9AkiAkQCn77DcH3BC2COoFRkCSIG2JzLwqiQi0RSmCD4JXbmNKh0+kc/X19tLtc9Ll9sk9ZS1yoU71YIk3xsbEx8QaDEc2ttxmaJSKC1ggSKBK8MKwTFQVXRzs3WzpJGjmZgvxcMpMtWIwqsjztvSrlzjYul56jp+46qSmJmMwR+P3+4aZ8TtCprRkk0DvUW7JjmV6lsqoKW/pU1q9YQOE4Nxkx4ladE7zd8ivuVmJQfXZKW5dx5EwPRw4fxNx2g5SUVLw+33AkzoRaQDP9SkFu6OKqz0uF8yaz7vsOL6ycQVLkcSg/BlWNsjuFoKE1knqDSl5aNnmPLmThrE0UvXqQqvJPyMrMGorEHwQfEha57/3P7mXS684GFjy8kreLppPUuBXfyd/ibeoS2kb0mWPANhJdYjb61AxUvx5PdT3+4y+Tb3mTd19ZSebE+VTXVGNQlHAC7w4VhH8TbA36vKq6ilnzlvPSunHw6Trc7XpZ14AyfgYeyz18crGN1Alz6e3qwNNQSv4dZox1h/BW9+O7eIaEsVv41Y4XeHJDG83Nl4mLTwzGhJYtx0PzNTjOB9KMTlc7Nkcem39YAGU7cbeBKVLMPGMVf296nMd2VbBq1wmizHoqqm/wrS1/Zf0+N19YN2PIu1fcIda4Vk66Zx/rVi+jo9eIX9wZGGcFXUMR6BHUa76/2ezioYcXMtpyAl91DSaTfDxlJbtLprHm2ecpObqPuTPzSNV9yKz4a4zJSuLo71/j8Q17ON69EmXiPIlNMe6FoyzOqWPW/MU03Lw5EFcyKghTrNDh7+/vw545mcJcWbTiGKpRdGPMXbx90sGmDaux6sXk+kimjU+BjnMkx3kYP34cXrFuZ+3nrHi6iDMt92JITcPjk3R3naRwZhpuNSqoD93DKaFVU7j2dhcF8+YzNlpErbIBTVh8toVccbaysPB+4pMcuPw25kwSsau7BIlmHpy3guaOPtISYyi/UkaJM5Lpc5agq5Xkcl6gIHkmqaMn0dtylcjIyPThCNyhaXyfR2W0I1our0v6qBii07ih5rDtGSOxNVdk1y4R2SR8jR/g7hQD9l1jUeY/WLJB5m39AlZN4GZyIQ1fFJNsEgt0duBIc5GRkcZF53mNwIzhXPDgQPoZIkiMkbTxtstDMVnmFA4cOsbz2/aKjSQjev4Mp9ZAg+hIpFhB3EH5Yal16+X+Kq3dGfxkzRY+KauBjBzREvGN0kNCTARu94AejBLMHorAQ7cEQMGs2cXvkWshYLDi6e9l728O8P1XW6hKeB2yv42q18tjj+iFTGoSi+X9jJM9RTxS9E+OHT0krhNiZqlbqraoT7RAU5bBGrEknEBhgJks7KXbLS8qERI0ErVqF/Y4K6NHZfLZB+/wzJvncacvFd91oXO3o/O40MfZKJOKu/rne+mRQByXM4lYreb1tUnkizVVA/0SpfpbWaCNBeEE5gb/UH19NLqEgDF+oNDQWcn41Cj0EXFEWqzkOIyYekslFkThsvMxpIyE2hIc6lXGZ6cPyK7Nnk5OipixRdxgUESAYmhq68VsGgy5CYKCUAJTg0+izApXne3CJFmUTwg4L3FProFxU+6krqmXu3MskkhSD2av41jLdzlnfFrSdCZxyqfMnppN6ZUa7pwt0h3fiK9DCt4IO9e7YqisvI7VYgmNv7mhBKKD/9psNi5dOMv5ZjukjsLdr0ffWsyTi6eSlfcA+dmiVyOXs+/sHNZu3M6PdxzgVO9GmDSHsSNqmTz/R6y6Xxqma4fwaS5Mn85n1ZE0Vl3CHBER3lUNEhiURpPJRFdTOcVnpUJnPIhR7cZXfoH5UYc5+E4RzRH3sfSnl9m2dSMjE+Tz9msse+o5dr7UwcQ5T3HwlWUkNuzG3dKFSTbsNs7m/Y8vExOlC29UWkMJlAxKoRQMR3IC7x85zOn6fHS50+U/2Untx2R1voinu5no+DQmz7yPXmMKZnsu0wrm0Oe3YhOVHdm8A09dBQYhTv4T7C+xUPrZh8Qn2MMr4qcDSRfoirWgKAvtgOpv1JI8Zi77X15G7L+fxeOUOiUFxZiULD5fSlNzNM62W+k1yq5gjajGX/ZHvOIyxd+Fkj+P092rWP/si0Qr7VisMaEWuCiYonXFwbAUTWWPYLV245NITnGkUXnpI9butLJn2y6iba+hlp7C09qBcvoN7FYL9mhxo1/y/LoEXK8Pv6qIC8WbBY/xr9YlPLf9dZT+OqKTUwfmDBm/GOw7ws4FWpuUP2gJEZvKqmocuXPZuWYJMzKuSsH+SNwh3bo0p6hao6HeEqwYEZ2M6aKWd3PwTCy7du/D0F1DsmzE6/WGLr5LsDF4LggnYBacCOboQLHQ3FFfR58SR+HCR1iQH8ukhA5s5o5AYZMwUqOp74nl8xvRHDlRTsnxYpJsUjtsceHt2C8Fm0MPJrphTkZvBc4It9RKLOFx91Pf0Igu0k7W2MmkOewS2QYJUJVWVz9VNbXUVVwkyuAmKTFJayrDo/4Jwe/CT0aGYTrWVYEeUfsgXssMRcpyenraQJa0VX9O3ZU+Ma1fax4xGxUsUVFkOUbcama1hf+7+LmA9juHWshwmwOE1iMmCFYEzg1jtIm1BaxW6wCGGoFdewPfvyE4ertTiv4rHC73B855dwp2a23bbd4tC1hvhOCbX7b4VyUQKhxrtSOaYKngasizvwi0RmOS4O1QZf2yYfiaR+73AvhTQEVf+rpn9/8IMAChKDrDzfsdIQAAAABJRU5ErkJggg=='
  }

  TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)

end)

AddEventHandler('esx_pompierjob:hasEnteredMarker', function(station, part, partNum)

  if part == 'Cloakroom' then
    CurrentAction     = 'menu_cloakroom'
    CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour vous changer'
    CurrentActionData = {}
  end

  if part == 'Armory' then
    CurrentAction     = 'menu_armory'
    CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder à l\'armurerie'
    CurrentActionData = {station = station}
  end

  if part == 'VehicleSpawner' then
    CurrentAction     = 'menu_vehicle_spawner'
    CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour sortir un véhicule'
    CurrentActionData = {station = station, partNum = partNum}
  end

  if part == 'VehicleDeleter' then

    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)

    if IsPedInAnyVehicle(playerPed,  false) then

      local vehicle = GetVehiclePedIsIn(playerPed, false)

      if DoesEntityExist(vehicle) then
        CurrentAction     = 'delete_vehicle'
        CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour ranger le véhicule'
        CurrentActionData = {vehicle = vehicle}
      end

    end

  end

  if part == 'BossActions' then
    CurrentAction     = 'menu_boss_actions'
    CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu'
    CurrentActionData = {}
  end

end)

AddEventHandler('esx_pompierjob:hasExitedMarker', function(station, part, partNum)
  ESX.UI.Menu.CloseAll()
  CurrentAction = nil
end)

AddEventHandler('esx_pompierjob:hasEnteredEntityZone', function(entity)

  local playerPed = GetPlayerPed(-1)

  if PlayerData.job ~= nil and PlayerData.job.name == 'pompier' and not IsPedInAnyVehicle(playerPed, false) then
    CurrentAction     = 'remove_entity'
    CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour enlever l\'objet'
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

AddEventHandler('esx_pompierjob:hasExitedEntityZone', function(entity)

  if CurrentAction == 'remove_entity' then
    CurrentAction = nil
  end

end)

RegisterNetEvent('esx_pompierjob:handcuff')
AddEventHandler('esx_pompierjob:handcuff', function()

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

RegisterNetEvent('esx_pompierjob:drag')
AddEventHandler('esx_pompierjob:drag', function(cop)
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

RegisterNetEvent('esx_pompierjob:putInVehicle')
AddEventHandler('esx_pompierjob:putInVehicle', function()

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

RegisterNetEvent('esx_pompierjob:OutVehicle')
AddEventHandler('esx_pompierjob:OutVehicle', function(t)
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
		Citizen.Wait(0)
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

-- Create blips
Citizen.CreateThread(function()

  for k,v in pairs(Config.PoliceStations) do

    local blip = AddBlipForCoord(v.Blip.Pos.x, v.Blip.Pos.y, v.Blip.Pos.z)

    SetBlipSprite (blip, v.Blip.Sprite)
    SetBlipDisplay(blip, v.Blip.Display)
    SetBlipScale  (blip, v.Blip.Scale)
    SetBlipColour (blip, v.Blip.Colour)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Caserne LSFD')
    EndTextCommandSetBlipName(blip)

  end

end)

-- Display markers
Citizen.CreateThread(function()
  while true do

    Wait(0)

    if PlayerData.job ~= nil and PlayerData.job.name == 'pompier' then

      local playerPed = GetPlayerPed(-1)
      local coords    = GetEntityCoords(playerPed)

      for k,v in pairs(Config.PoliceStations) do

        for i=1, #v.Cloakrooms, 1 do
          if GetDistanceBetweenCoords(coords,  v.Cloakrooms[i].x,  v.Cloakrooms[i].y,  v.Cloakrooms[i].z,  true) < Config.DrawDistance then
            DrawMarker(Config.MarkerType, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          end
        end

        for i=1, #v.Vehicles, 1 do
          if GetDistanceBetweenCoords(coords,  v.Vehicles[i].Spawner.x,  v.Vehicles[i].Spawner.y,  v.Vehicles[i].Spawner.z,  true) < Config.DrawDistance then
            DrawMarker(Config.MarkerType, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          end
        end

        for i=1, #v.VehicleDeleters, 1 do
          if GetDistanceBetweenCoords(coords,  v.VehicleDeleters[i].x,  v.VehicleDeleters[i].y,  v.VehicleDeleters[i].z,  true) < Config.DrawDistance then
            DrawMarker(Config.MarkerType, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          end
        end

        if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.name == 'pompier' and PlayerData.job.grade_name == 'boss' then

          for i=1, #v.BossActions, 1 do
            if not v.BossActions[i].disabled and GetDistanceBetweenCoords(coords,  v.BossActions[i].x,  v.BossActions[i].y,  v.BossActions[i].z,  true) < Config.DrawDistance then
              DrawMarker(Config.MarkerType, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
            end
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

    if PlayerData.job ~= nil and PlayerData.job.name == 'pompier' then

      local playerPed      = GetPlayerPed(-1)
      local coords         = GetEntityCoords(playerPed)
      local isInMarker     = false
      local currentStation = nil
      local currentPart    = nil
      local currentPartNum = nil

      for k,v in pairs(Config.PoliceStations) do

        for i=1, #v.Cloakrooms, 1 do
          if GetDistanceBetweenCoords(coords,  v.Cloakrooms[i].x,  v.Cloakrooms[i].y,  v.Cloakrooms[i].z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'Cloakroom'
            currentPartNum = i
          end
        end

        for i=1, #v.Vehicles, 1 do

          if GetDistanceBetweenCoords(coords,  v.Vehicles[i].Spawner.x,  v.Vehicles[i].Spawner.y,  v.Vehicles[i].Spawner.z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'VehicleSpawner'
            currentPartNum = i
          end

          if GetDistanceBetweenCoords(coords,  v.Vehicles[i].SpawnPoint.x,  v.Vehicles[i].SpawnPoint.y,  v.Vehicles[i].SpawnPoint.z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'VehicleSpawnPoint'
            currentPartNum = i
          end

        end

        for i=1, #v.VehicleDeleters, 1 do
          if GetDistanceBetweenCoords(coords,  v.VehicleDeleters[i].x,  v.VehicleDeleters[i].y,  v.VehicleDeleters[i].z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'VehicleDeleter'
            currentPartNum = i
          end
        end

        if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.name == 'pompier' and PlayerData.job.grade_name == 'boss' then

          for i=1, #v.BossActions, 1 do
            if GetDistanceBetweenCoords(coords,  v.BossActions[i].x,  v.BossActions[i].y,  v.BossActions[i].z,  true) < Config.MarkerSize.x then
              isInMarker     = true
              currentStation = k
              currentPart    = 'BossActions'
              currentPartNum = i
            end
          end

        end

      end

      local hasExited = false

      if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum) ) then

        if
          (LastStation ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
          (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
        then
          TriggerEvent('esx_pompierjob:hasExitedMarker', LastStation, LastPart, LastPartNum)
          hasExited = true
        end

        HasAlreadyEnteredMarker = true
        LastStation             = currentStation
        LastPart                = currentPart
        LastPartNum             = currentPartNum

        TriggerEvent('esx_pompierjob:hasEnteredMarker', currentStation, currentPart, currentPartNum)
      end

      if not hasExited and not isInMarker and HasAlreadyEnteredMarker then

        HasAlreadyEnteredMarker = false

        TriggerEvent('esx_pompierjob:hasExitedMarker', LastStation, LastPart, LastPartNum)
      end

    end

  end
end)

-- Enter / Exit entity zone events
Citizen.CreateThread(function()
	local trackedEntities = {
		'prop_roadcone02a',
		'prop_barrier_work05',
		'p_ld_stinger_s',
		'prop_boxpile_07d',
		'hei_prop_cash_crate_half_full'
	}

	while true do
		Citizen.Wait(500)

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		local closestDistance = -1
		local closestEntity   = nil

		for i=1, #trackedEntities, 1 do
			local object = GetClosestObjectOfType(coords, 3.0, GetHashKey(trackedEntities[i]), false, false, false)

			if DoesEntityExist(object) then
				local objCoords = GetEntityCoords(object)
				local distance  = GetDistanceBetweenCoords(coords, objCoords, true)

				if closestDistance == -1 or closestDistance > distance then
					closestDistance = distance
					closestEntity   = object
				end
			end
		end

		if closestDistance ~= -1 and closestDistance <= 3.0 then
			if LastEntity ~= closestEntity then
				TriggerEvent('esx_pompierjob:hasEnteredEntityZone', closestEntity)
				LastEntity = closestEntity
			end
		else
			if LastEntity ~= nil then
				TriggerEvent('esx_pompierjob:hasExitedEntityZone', LastEntity)
				LastEntity = nil
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

			if IsControlPressed(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'pompier' and (GetGameTimer() - GUI.Time) > 150 then

				if CurrentAction == 'menu_cloakroom' then
					OpenCloakroomMenu()
				elseif CurrentAction == 'menu_armory' then
					OpenArmoryMenu(CurrentActionData.station)
				elseif CurrentAction == 'menu_vehicle_spawner' then
					OpenVehicleSpawnerMenu(CurrentActionData.station, CurrentActionData.partNum)
				elseif CurrentAction == 'delete_vehicle' then
					if Config.EnableSocietyOwnedVehicles then
						local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
						TriggerServerEvent('esx_society:putVehicleInGarage', 'pompier', vehicleProps)
					else
						if GetEntityModel(vehicle) == GetHashKey('police') or
							GetEntityModel(vehicle) == GetHashKey('police2') or
							GetEntityModel(vehicle) == GetHashKey('police3') or
							GetEntityModel(vehicle) == GetHashKey('police4') or
							GetEntityModel(vehicle) == GetHashKey('policeb') or
							GetEntityModel(vehicle) == GetHashKey('policet')
						then
							TriggerServerEvent('esx_service:disableService', 'pompier')
						end
					end
					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
				elseif CurrentAction == 'menu_boss_actions' then
					ESX.UI.Menu.CloseAll()
					TriggerEvent('esx_society:openBossMenu', 'pompier', function(data, menu)
						menu.close()
						CurrentAction     = 'menu_boss_actions'
						CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu'
						CurrentActionData = {}
					end)
				elseif CurrentAction == 'remove_entity' then
					DeleteEntity(CurrentActionData.entity)
				end
				
				CurrentAction = nil
				GUI.Time      = GetGameTimer()
			end
		end -- CurrentAction end
		
		if IsControlPressed(0, Keys['F6']) and not isDead and PlayerData.job ~= nil and PlayerData.job.name == 'pompier' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'police_actions') and (GetGameTimer() - GUI.Time) > 150 then
			OpenPoliceActionsMenu()
			GUI.Time = GetGameTimer()
    end

    if IsControlPressed(0,  Keys['DELETE']) and (GetGameTimer() - GUI.Time) > 150 and GetLastInputMethod(2) then

			if OnJob then
				StopPompierJob()
			else

				if PlayerData.job ~= nil and PlayerData.job.name == 'pompier' then

					local playerPed = GetPlayerPed(-1)

					if IsPedInAnyVehicle(playerPed,  false) then

						local vehicle = GetVehiclePedIsIn(playerPed,  false)

						if PlayerData.job.grade >= 6 then
							StartPompierJob()
						else
							if GetEntityModel(vehicle) == GetHashKey('ambulance') then
								StartPompierJob()
              else
								ESX.ShowNotification(_U('must_in_ambulance'))
							end
						end

					else

						if PlayerData.job.grade >= 6 then
							ESX.ShowNotification(_U('must_in_vehicle'))
						else
							ESX.ShowNotification(_U('must_in_ambulance'))
						end

					end

				end

			end

			GUI.Time = GetGameTimer()

		end
		
		if IsControlPressed(0, Keys['E']) and CurrentTask.Busy then
      CopsNotification('Vous avez interompu la mise en fourriere')
			ESX.ClearTimeout(CurrentTask.Task)
			ClearPedTasks(GetPlayerPed(-1))
			
			CurrentTask.Busy = false
		end
	end
end)

function createBlip(id)
	ped = GetPlayerPed(id)
	blip = GetBlipFromEntity(ped)
	
	if not DoesBlipExist(blip) then -- Add blip and create head display on player
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 1)
		Citizen.InvokeNative(0x5FBCA48327B914DF, blip, true) -- Player Blip indicator
		SetBlipRotation(blip, math.ceil(GetEntityHeading(veh))) -- update rotation
		SetBlipNameToPlayerName(blip, id) -- update blip name
		SetBlipScale(blip, 0.9) -- set scale
		SetBlipAsShortRange(blip, true)
		
		table.insert(blipsCops, blip) -- add blip to array so we can remove it later
	end
end

RegisterNetEvent('esx_pompierjob:updateBlip')
AddEventHandler('esx_pompierjob:updateBlip', function()
	
	-- Refresh all blips
	for k, existingBlip in pairs(blipsCops) do
		RemoveBlip(existingBlip)
	end
	
	-- Clean the blip table
	blipsCops = {}
	
	-- Is the player a cop? In that case show all the blips for other cops
  if PlayerData.job ~= nil and PlayerData.job.name == 'pompier' then
    TriggerServerEvent("player:serviceOn", "pompier")
		ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
			for i=1, #players, 1 do
				if players[i].job.name == 'pompier' then
					for id = 0, 65 do
						if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= GetPlayerPed(-1) and GetPlayerName(id) == players[i].name then
							createBlip(id)
						end
					end
				end
			end
		end)
	end

end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
	if not hasAlreadyJoined then
		TriggerServerEvent('esx_pompierjob:spawned')
	end
	hasAlreadyJoined = true
end)

AddEventHandler('esx:onPlayerDeath', function()
	isDead = true
end)

-- TODO
--   - return to garage if owned
--   - message owner that his vehicle has been impounded
function ImpoundVehicle(vehicle)
	--local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
	ESX.Game.DeleteVehicle(vehicle) 
  CopsNotification('Vous avez mit en fourriere')
	CurrentTask.Busy = false
end

---------------- Police Radio Animation and Sound On/Off
local soundDistance = 2 -- Distance Radio sound

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 0 )
    end
end

function DisableActions(ped)
    DisableControlAction(1, 140, true)
    DisableControlAction(1, 141, true)
    DisableControlAction(1, 142, true)
    DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
    DisablePlayerFiring(ped, true) -- Disable weapon firing
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait( 0 )
        local ped = PlayerPedId()
     if PlayerData.job ~= nil and PlayerData.job.name == 'pompier' then    
        if DoesEntityExist( ped ) and not IsEntityDead( ped ) then
            if not IsPauseMenuActive() then 
                loadAnimDict( "random@arrests" )
                if IsControlJustReleased( 0, 19 ) then -- INPUT_CHARACTER_WHEEL (LEFT ALT)
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", soundDistance, "off", 0.1)    
                    ClearPedTasks(ped)
                    SetEnableHandcuffs(ped, false)
                else
                    if IsControlJustPressed( 0, 19 )  and not IsPlayerFreeAiming(PlayerId()) then -- INPUT_CHARACTER_WHEEL (LEFT ALT)
                        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", soundDistance, "on", 0.1)    
                        TaskPlayAnim(ped, "random@arrests", "generic_radio_enter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
                        SetEnableHandcuffs(ped, true)
                    elseif IsControlJustPressed( 0, 19 ) and IsPlayerFreeAiming(PlayerId()) then -- INPUT_CHARACTER_WHEEL (LEFT ALT)
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", soundDistance, "on", 0.1)    
                        TaskPlayAnim(ped, "random@arrests", "radio_chatter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
                        SetEnableHandcuffs(ped, true)
                    end 
                    if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests", "generic_radio_enter", 3) then
                        DisableActions(ped)
                    elseif IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests", "radio_chatter", 3) then
                        DisableActions(ped)
                    end
                end
            end 
        end
        end 
    end
end )


----------------------------------------------------------------------------------

function clearPed()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
      TriggerEvent('skinchanger:loadSkin', skin)
    end)
    ClearAllPedProps(GetPlayerPed(-1))
end 
  
function OpenFederalMenu(player)

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'federal',
    {
      title    = 'Sentence Fédérale',
      align    = 'top-left',
      elements = {
        {label = '5 mois',   value = 5},
        {label = '1 an',     value = 12},
        {label = '1 an et demi',   value = 18},
        {label = '2 an',   value = 24},
        {label = '2 an et demi',   value = 30},
        {label = '3 an',   value = 36},
        {label = '3 an et demi',   value = 42},
        {label = '4 an',   value = 48},
        {label = '4 an et demi',   value = 54},
        {label = '5 an',  value = 60},
        {label = '5 an et demi',  value = 66},
        {label = '6 an',     value = 72}
      },
    },
    function(data, menu)
      Arrest(GetPlayerServerId(player), tonumber(data.current.value)*60)
      menu.close()
    end,
    function(data, menu)
      menu.close()
    end
  )

end

function Arrest(playerID, amount)
  TriggerServerEvent("jail:teleportToJail", playerID, amount)
end

-- jail addon
RegisterNetEvent('jail:teleportPlayer')
AddEventHandler('jail:teleportPlayer', function(amount)
  if IsHandcuffed then
    TriggerEvent('esx_pompierjob:handcuff')
    TriggerServerEvent('jail:removeInventaire', amount)
    Wait(500)
    SetEntityCoords(GetPlayerPed(-1), tonumber("1680.07"), tonumber("2512.8"), tonumber("45.4649"))
    RemoveAllPedWeapons(GetPlayerPed(-1))
    TriggerEvent('chatMessage', '^4Prison', {0,0,0}, "Voici ta sentence : ^1".. (tonumber(amount)/60) .." minutes !")
    clearPed()
    Wait(500)
    local hashSkin = GetHashKey("mp_m_freemode_01")
    Citizen.CreateThread(function()
      if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
        SetPedComponentVariation(GetPlayerPed(-1), 4, 7, 15, 0)--Pantalon
        SetPedComponentVariation(GetPlayerPed(-1), 11, 5, 0, 0)--Debardeur
        SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 0)--Tshirt
        SetPedComponentVariation(GetPlayerPed(-1), 3, 5, 0, 0)--Bras
        SetPedComponentVariation(GetPlayerPed(-1), 6, 34, 0, 0)--Pied
        c_options.undershirt = 0
        c_options.undershirt_txt = 240
        SetPedComponentVariation(GetPlayerPed(-1), 8, tonumber(c_options.undershirt), tonumber(c_options.undershirt_txt), 0)
      else  
        SetPedComponentVariation(GetPlayerPed(-1), 4, 3, 15, 0)--Pantalon
        SetPedComponentVariation(GetPlayerPed(-1), 11, 14, 6, 0)--Debardeur
        SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 0)--Tshirt
        SetPedComponentVariation(GetPlayerPed(-1), 3, 4, 0, 0)--Bras
        SetPedComponentVariation(GetPlayerPed(-1), 6, 5, 0, 0)--Pied
        c_options.undershirt = 0
        c_options.undershirt_txt = 240
        SetPedComponentVariation(GetPlayerPed(-1), 8, tonumber(c_options.undershirt), tonumber(c_options.undershirt_txt), 0)
      end 
    end)
    Citizen.CreateThread(function()
      while (amount > 0) do
        if amount == 240 then
          TriggerEvent('chatMessage', '^4Prison', {0,0,0}, "Temps restant : ^1".. (tonumber(amount)/60) .." minutes !")
        elseif amount == 180 then
          TriggerEvent('chatMessage', '^4Prison', {0,0,0}, "Temps restant : ^1".. (tonumber(amount)/60) .." minutes !")
        elseif amount == 120 then
          TriggerEvent('chatMessage', '^4Prison', {0,0,0}, "Temps restant : ^1".. (tonumber(amount)/60) .." minutes !")
        elseif amount == 60 then
          TriggerEvent('chatMessage', '^4Prison', {0,0,0}, "Temps restant : ^1".. (tonumber(amount)/60) .." minute !")
        else

        end

        
        RemoveAllPedWeapons(GetPlayerPed(-1))
                LastPosX, LastPosY, LastPosZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
        if (GetDistanceBetweenCoords(LastPosX, LastPosY, LastPosZ, 1680.06994628906,2512.80004882813,46.2684020996094, true) > 100.0001) then
            SetEntityCoords(GetPlayerPed(-1), tonumber("1680.07"), tonumber("2512.8"), tonumber("45.4649"))
            TriggerEvent('chatMessage', '^4Prison', {0,0,0}, "On ne s'échappe pas de la prison comme ça !")
        end
        Citizen.Wait(1000)
        amount = amount - 1
          
      end
      
      -- Sortie de prison après fin sentence
      SetEntityCoords(GetPlayerPed(-1), tonumber("1847.39"), tonumber("2602.78"), tonumber("45.5987"))
      clearPed()

    end)
  else
    TriggerEvent('chatMessage', source,'^4Prison', {0,0,0}, "Le Prisonnier doit être menotté !")
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    -- List of pickup hashes (https://pastebin.com/8EuSv2r1)
    RemoveAllPickupsOfType(0xDF711959) -- carbine rifle
    RemoveAllPickupsOfType(0xF9AFB48F) -- pistol
    RemoveAllPickupsOfType(0xA9355DCD) -- pumpshotgun
    RemoveAllPickupsOfType(0x6D544C99) -- RailGun
  end
end)

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

								TriggerServerEvent('esx_pompierjob:success')

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
								msg = string.format(_U('take_me_to_near'))
							else
								msg = string.format(_U('take_me_to'))
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

									local seat = 0

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

-- ---------------------------------------------------------------------------------------------------------
-- --NB : gestion des menu
-- --------------------------------------------------------------------------------------------------------
-- RegisterNetEvent('NB:openMenuPolice')
-- AddEventHandler('NB:openMenuPolice', function()
-- 	OpenPoliceActionsMenu()
-- end)