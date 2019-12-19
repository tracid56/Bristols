
local wayPoints1 = {
  {
    num=0, 
    text=[[<p>Chers Yankees,</p>
    <p>North Yankton n'est pas une ville comme les autres.
    C’est une des villes les plus libres, puisque chacun est protégé dans ses droits et dans sa liberté d’opinion, de conscience, de croyance ou de philosophie.
    Nous sommes fiers d'être des Yankees, fiers d'appartenir à notre "petite blanche" comme l'appellaient nos ancêtres.
    Chacun partage le destin des autres et chacun est appelé à décider du destin de tous : c’est tout cela, la Nation Yankee.
    Les difficultés de la vie, comme le chômage, le remboursement de soins médicaux, et autres, sont surmontées, grâce à l’effort partagé par tous.
    Mais aujourd'hui,
    Au moment où j'écris cette lettre, un drame sans précédent nous a frappé.
    Il y a quelques jours, le docteur Ludendorff a trouvé ce qui semblerait être un vaccin parfaitement efficace contre la destruction des cellules humaines, le déréglement 
    du métabolisme, le mauvais fonctionnement des organes, et bien d'autres anomalies. Par conséquent, il pouvait soigner la majorité des malades, quelque soit la maladie.
    Cependant, la joie a été de courte durée, car, à la suite d'une erreur humaine, le vaccin a quitté le lieu clos du laboratoire et s'est diffusé sur la ville (pandémie),
    tuant les humains les moins résistants et faisant muter les autres. L'évacuation des survivants sur des bateaux est un echec à l'heure qu'il est, aucune ville
    voisine ne voulant nous accueillir.
    Personne ne trouvant de remède au nouveau virus qui décime les derniers survivants, j'abandonne ma petite blanche,les larmes qui coulent et que je ne peux retenir, malgré mon visage sans expression.
    Adieu ma belle...</p>
    ]],
    x=3209.1652832031,
    y=-4854.4829101563, 
    z=111.81429290771,
    distance=1
  }, -- banque
}

local treasurePoints = {
  {
    num=1, 
    text=[[<p>Pacific Hunt - Treasure</p>
    <p>Vous déterrez un coffre. Il est fermé par une combinaison.</p>
    <p>Saurez-vous ouvrir le coffre et remporter mon contenu (s'il n'a pas déjà été pillé par quelqu'un d'autre!)?</p>
    ]],
    x=0,
    y=0, 
    z=0,
    distance=3
  }, -- pacific HQ
}

local treasureFound=false
local code=42891235782154318965

local codeOpen = false
local clueOpen = false
local onSpot = false

-- Open Gui and Focus NUI
function codeOpenUI(thetext)
  SetNuiFocus(true)
  SendNUIMessage({codeOpen = true, textDisplay = thetext})
  codeOpen = true
end

function clueOpenUI(thetext)
  SetNuiFocus(true)
  SendNUIMessage({clueOpen = true, textDisplay = thetext})
  clueOpen = true
end

function closeAllUI()
  SetNuiFocus(false)
  SendNUIMessage({clueOpen = false, codeOpen = false})
  codeOpen = false
  clueOpen = false
end

-- If GUI setting turned on, listen for INPUT_PICKUP keypress
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local text=IsNearWayPoint()
    if (text~="") then
      if (clueOpen==false and not IsInVehicle() and not onSpot) then
      	onSpot = true
        clueOpenUI(text);
      end
    else
   	  onSpot = false
      text = IsNearTreasure()
      if (text~="") then
		    if (IsControlJustPressed(1, 51) and not IsInVehicle()) then
  	      if codeOpen then
  	        closeAllUI()
  	      else
    		    if (treasureFound) then
    		      TriggerEvent('chatMessage', "", {0, 255, 0}, "^0Tu as déjà trouvé la cachette! Contacte William Owens (776-3110) pour savoir si tu étais le premier!");
    		    else
    		      codeOpenUI(text)
    	      end
          end
	      end
      else
        if codeOpen then
          closeAllUI()
        end
      end
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    if clueOpen or codeOpen then
      local ply = GetPlayerPed(-1)
      local active = true
      DisableControlAction(0, 1, active) -- LookLeftRight
      DisableControlAction(0, 2, active) -- LookUpDown
      DisableControlAction(0, 24, active) -- Attack
      DisablePlayerFiring(ply, true) -- Disable weapon firing
      DisableControlAction(0, 142, active) -- MeleeAttackAlternate
      DisableControlAction(0, 106, active) -- VehicleMouseControlOverride
      if IsDisabledControlJustReleased(0, 24) or IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
        SendNUIMessage({type = "click"})
      end
    end
    Citizen.Wait(0)
  end
end)

RegisterNUICallback('close', function(data, cb)
  closeAllUI()
  cb('ok')
end)

RegisterNUICallback('codeSubmit', function(data, cb)
  if (tonumber(data.amount)==code) then
    closeAllUI()
    FoundTreasure()
  else
    closeAllUI()
    TriggerEvent('chatMessage', "", {255, 0, 0}, "^1Biiippp... code erroné.");
  end
  cb('ok')
end)

-- Check if player is near an atm
function FoundTreasure()
  TriggerEvent('chatMessage', "", {0, 255, 0}, "");
  local id = PlayerId()
  local playerName = GetPlayerName(id)
  TriggerServerEvent("lg:pacificHuntLOG", playerName.." a ouvert le coffre")
  treasureFound=true
end

-- Check if player is near an atm
function IsNearWayPoint()
  local ply = GetPlayerPed(-1)
  local plyCoords = GetEntityCoords(ply, 0)
  for _, item in pairs(wayPoints1) do
    local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
    if(distance <= item.distance) then
      return item.text
    end
  end
  return ""
end

-- Check if player is in a vehicle
function IsInVehicle()
  local ply = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end

-- Check if player is near a bank
function IsNearTreasure()
  local ply = GetPlayerPed(-1)
  local plyCoords = GetEntityCoords(ply, 0)
  for _, item in pairs(treasurePoints) do
    local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
    if(distance <= item.distance) then
      return item.text
    end
  end
  return ""
end