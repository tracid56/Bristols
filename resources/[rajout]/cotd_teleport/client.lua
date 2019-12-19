ESX               = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1)
	end
end)

local TeleportFromTo = {
	["Maze Bank Building"] = {
		positionFrom = { ['x'] = -77.723, ['y'] = -822.097, ['z'] = 243.385, nom = "aller sur le toit"},
		positionTo = { ['x'] = -67.6794, ['y'] = -821.6484, ['z'] = 321.2873, nom = "decendre au bureau"},
	},
	
	["Humane Labs"] = {
		positionFrom = { ['x'] = 3541.7028, ['y'] = 3674.2761, ['z'] = 28.1211, nom = "decendre au Humane labs"},
		positionTo = { ['x'] = 3541.7314, ['y'] = 3674.2619, ['z'] = 20.9917, nom = "monter au Humane labs"},
	},

	--["Banque"] = {
		--positionFrom = { ['x'] = 255.218, ['y'] = 228.416, ['z'] = 101.583, nom = "Sortie - Banque"},
		--positionTo = { ['x'] = 370.997, ['y'] = 252.981, ['z'] = 103.009, nom = "entrée - Banque"},
	--},
	
	-- ["Bahama Mamas"] = {
	-- 	positionFrom = { ['x'] = -1388.6527, ['y'] = -586.1796, ['z'] = 30.2184, nom = "rentrer dans le Bahama Mamas"},
	-- 	positionTo = { ['x'] = -1387.61, ['y'] = -588.068, ['z'] = 30.3195, nom = "sortir du Bahama Mamas"},
	-- },

	["Unicorn Bar"] = {
		positionFrom = { ['x'] = 133.107, ['y'] = -1293.725, ['z'] = 28.66, nom = "aller a l'intérieur du Unicorn"},
		positionTo = { ['x'] = 126.486, ['y'] = -1277.909, ['z'] = 29.049, nom = "sortir du Unicorn"},
	},

	--["Circuit"] = {
	--	positionFrom = { ['x'] = 1728.685, ['y'] = 3278.447, ['z'] = 41.09, nom = "sur le circuit"},
	--	positionTo = { ['x'] = 6194.627, ['y'] = -6088.327, ['z'] = 34.503, nom = "sortir du circuit"},
	--},
	
	--["Gouvernement 2ème"] = {
	--	positionFrom = { ['x'] = 147.68125915527, ['y'] = -738.14776611328, ['z'] = 242.1507317627, nom = "Bureau Gouverneur"},
	--	positionTo = { ['x'] = 117.13682556152, ['y'] = -737.26239013672, ['z'] = 258.15209960938, nom = "Bureau FIB"},
	--},

	["Bureau Avocat"] = {
		positionFrom = { ['x'] = -1898.1942138672, ['y'] = -572.74584960938, ['z'] = 11.836930, nom = "entrer dans le cabinet"},
		positionTo = { ['x'] = -1902.887207, ['y'] = -573.23669433594, ['z'] = 19.097221096558, nom = "sortir du cabinet"},
	},
	
	--["Salle de Réunion"] = {
		--positionFrom = { ['x'] = 140.28009033203, ['y'] = -744.6215209, ['z'] = 242.151992797, nom = "entrer - Salle de Réunion"},
		--positionTo = { ['x'] = 140.89990844727, ['y'] = -731.2551, ['z'] = 242.151992797, nom = "sortir - Salle de Réunion"},
	--},
	
	["Arcadius Buisiness"] = {
		positionFrom = { ['x'] = -117.2135, ['y'] = -604.5497, ['z'] = 36.2807, nom = "monter au Arcadius Buisiness"},
		positionTo = { ['x'] = -134.0843, ['y'] = -584.5471, ['z'] = 201.7355, nom = "decendre au Arcadius Buisiness"},
	},	
	
	--["Bureau du FIB"] = {
		--positionFrom = { ['x'] = 136.0994, ['y'] = -761.8452, ['z'] = 45.7520, nom = "Monter - Bureau du FIB"},
		--positionTo = { ['x'] = 136.7892, ['y'] = -761.4996, ['z'] = 242.1518, nom = "Decendre - Bureau du FIB"},
	--},
	
	--["Hôpital - entrer - sortir"] = {
		--positionFrom = { ['x'] = -497.2229, ['y'] = -335.9371, ['z'] = 34.5017, nom = "entrer - Hôpital"},
		--positionTo = { ['x'] = 275.6354, ['y'] = -1361.6866, ['z'] = 24.5167, nom = "sortir - Hôpital"},
	--},
	
	["Piscine - Gouverneur"] = {
		positionFrom = { ['x'] = -168.929, ['y'] = 476.709, ['z'] = 133.896, nom = "entre a a l'interieur"},
		positionTo = { ['x'] = -166.016, ['y'] = 478.774, ['z'] = 133.843, nom = "sortir a l'exterieur"},
	},
	
	["Bureau - Avocat"] = {
		positionFrom = { ['x'] = -1898.1942138672, ['y'] = -572.74584960938, ['z'] = 11.836930, nom = "entrer dans le cabinet"},
		positionTo = { ['x'] = -1902.887207, ['y'] = -573.23669433594, ['z'] = 19.097221096558, nom = "sortir du cabinet"},
	},
	
	["Life invader - Réunion"] = {
		positionFrom = { ['x'] = -1048.93, ['y'] = -238.589, ['z'] = 44.0211, nom = "entrer dans la  salle de réunion"},
		positionTo = { ['x'] = -1046.62, ['y'] = -237.523, ['z'] = 44.0211, nom = "sortir de la salle de réunion"},
	},
	
	["Life invader - Brainstorming"] = {
		positionFrom = { ['x'] = -1056.73, ['y'] = -237.844, ['z'] = 44.0212, nom = "entrer dans la salle de brainstorming"},
		positionTo = { ['x'] = -1057.85, ['y'] = -235.752, ['z'] = 44.0212, nom = "sortir de la salle de brainstorming"},
	},
	
--	["Poste de police - Armurie"] = {
--		positionFrom = { ['x'] = 452.227, ['y'] = -982.609, ['z'] = 30.6896, nom = "entrer - Armurie"},
--		positionTo = { ['x'] = 454.494, ['y'] = -982.571, ['z'] = 30.6896, nom = "sortir - Armurie"},
--	},
	
	["Agence de détective - Bureau"] = {
		positionFrom = { ['x'] = -1011.65, ['y'] = -480.061, ['z'] = 39.9706, nom = "entrer dans l'agence de détective"},
		positionTo = { ['x'] = -1002.81, ['y'] = -477.794, ['z'] = 50.0273, nom = "sortir de l'agence de détective"},
	},	
	
    ["Mont Chiliad - Telecabine"] = {
	    positionFrom = { ['x'] = -741.738, ['y'] = 5595.22, ['z'] = 41.6546, nom = "entrer dans la cabine"},
		positionTo = { ['x'] = 446.051, ['y'] = 5572.32, ['z'] = 781.189, nom = "sortir de la cabine"},
	},	
	
	--["offshore-production"] = {
		--positionFrom = { ['x'] = 1240.741088, ['y'] = -3002.878173, ['z'] = 9.129263, nom = "entrer - Offshore-production"},
		--positionTo = { ['x'] = 13634.813476563, ['y'] = 9965.7080078125, ['z'] = 33.883720397949, nom = "sortir - Offshore-production"},
	--},

	--["Récolte Weed"] = {
	--	positionFrom = { ['x'] = 2806.32592, ['y'] = 5978.6127, ['z'] = 350.604193, nom = ""},
	--	positionTo = { ['x'] = 1063.602905, ['y'] = -3182.498779, ['z'] = -39.062986, nom = ""},
	--},

	--["Transfo Meth"] = {
	--	positionFrom = { ['x'] = 1236.3814,['y'] = -650.8515, ['z']= 38.441, nom = ""},
	--	positionTo = { ['x'] = 998.151428, ['y'] = -3200.103027, ['z'] = -36.393623, nom = ""},
	--},

	--["Transfo Coke"] = {
	--	positionFrom = { ['x'] = 887.289794, ['y'] = -953.441223, ['z'] = 39.113142, nom = ""},
	--	positionTo = { ['x'] = 1088.854980, ['y'] = -3188.458740, ['z'] = -38.99347, nom = ""},
	--},

	--["Bar"] = {
	--	positionFrom = { ['x'] = 110.973937, ['y'] = -1302.780395, ['z'] = 29.029510, nom = "Bar"},
	--	positionTo = { ['x'] = 126.4743576, ['y'] = -1278.53625, ['z'] = 29.0295503, nom = ""},
	--},	

	--["Bunker"] = {
	--	positionFrom = { ['x'] = -480.692, ['y'] = 6266.297, ['z'] = 12.334, nom = ""},
	--	positionTo = { ['x'] = 892.6384, ['y'] = -3245.8664, ['z'] = -98.2645, nom = ""},
	--},

	--["ClubHouse"] = {
	--	positionFrom = { ['x'] = 1020.1312, ['y'] = -3023.0571, ['z'] = 5.708724, nom = ""},
	--	positionTo = { ['x'] = 1107.04, ['y'] = -3157.399, ['z'] = -37.51859, nom = ""},
	--},

	--["FauxBillets"] = {
	--	positionFrom = { ['x'] = 591.845, ['y'] = 2782.87, ['z'] = 43.08, nom = ""},
	--	positionTo = { ['x'] = 1121.897, ['y'] = -3195.338, ['z'] = -40.4025, nom = ""},
	--}, 

	--["FauxPapiers"] = {
	--	positionFrom = { ['x'] = 1020.5697, ['y'] = -2987.1035, ['z'] = 5.9010, nom = ""},
	--	positionTo = { ['x'] = 1165.0021, ['y'] = -3196.601, ['z'] = -39.01306, nom = ""},
	--}, 

	--["WareHouse"] = {
		--positionFrom = { ['x'] = 1020.6148, ['y'] = -2977.0063, ['z'] = 5.9010, nom = ""},
		--positionTo = { ['x'] = 1006.967, ['y'] = -3102.079, ['z'] = -39.0035, nom = ""},
	--},

	--["ClubHouse"] = {
		--positionFrom = { ['x'] = 1020.2537, ['y'] = -2971.1086, ['z'] = 5.9010, nom = ""},
		--positionTo = { ['x'] = 1107.04, ['y'] = -3157.399, ['z'] = -37.51859, nom = ""},
	--},	
	
	["BoiteNuit"] = {
		positionFrom = { ['x'] = 345.789, ['y'] = -977.945, ['z'] = 29.377, nom = "entrer dans la boite de nuit"},
		positionTo = { ['x'] = -1569.258, ['y'] = -3017.480, ['z'] = -74.406, nom = "sortir dans la boite de nuit"},
	},

	["BoiteNuit2"] = {
		positionFrom = { ['x'] = 333.171, ['y'] = -997.095, ['z'] = 29.184, ['h'] = 177.653, nom = "entrer dans la boite de nuit par le garage"},
		positionTo = { ['x'] = -1642.292, ['y'] = -2989.666, ['z'] = -77.383, ['h'] = 271.083, nom = "sortir dans la boite de nuit par le garage"},
	},

	["Banque"] = {
		positionFrom = { ['x'] = 255.780, ['y'] = 224.953, ['z'] = 101.875, nom = "rentre dans le coffre fort"},
		positionTo = { ['x'] = 252.995, ['y'] = 222.539, ['z'] = 101.683, nom = "sortir du coffre fort"},
	},

	["Adoni"] = {
		positionFrom = { ['x'] = -1171.084, ['y'] = -1380.924, ['z'] = 4.968, nom = "rentre dans le QG de la Famille Adoni"},
		positionTo = { ['x'] = 1120.873, ['y'] = -3152.252, ['z'] = -37.062, nom = "sortir du QG de la Famille Adoni"},
	},

	["Adoni2"] = {
		positionFrom = { ['x'] = -1171.088, ['y'] = -1390.285, ['z'] = 4.885, ['h'] = 125.918, nom = "rentre dans le QG de la Famille Adoni"},
		positionTo = { ['x'] = 1109.728, ['y'] = -3164.568, ['z'] = -37.518, ['h'] = 4.885, nom = "sortir du QG de la Famille Adoni"},
	},
}	




Drawing = setmetatable({}, Drawing)
Drawing.__index = Drawing

function showHelpNotification2(mess)
    SetTextComponentFormat('STRING')
    AddTextComponentString(mess)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		local ped = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(ped)
		local model = GetEntityModel(vehicle)
		
		for k, j in pairs(TeleportFromTo) do
		
			--msginf(k .. " " .. tostring(j.positionFrom.x), 15000)
			if(Vdist(pos.x, pos.y, pos.z, j.positionFrom.x, j.positionFrom.y, j.positionFrom.z) < 100.0)then
				DrawMarker(1, j.positionFrom.x, j.positionFrom.y, j.positionFrom.z - 1, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.0, 50, 50, 204,100, 0, 0, 0,0)
				if(Vdist(pos.x, pos.y, pos.z, j.positionFrom.x, j.positionFrom.y, j.positionFrom.z) < 100.0)then
					--Drawing.draw3DText(j.positionFrom.x, j.positionFrom.y, j.positionFrom.z - 1.100, j.positionFrom.nom, 1, 0.2, 0.1, 255, 255, 255, 215)
					if(Vdist(pos.x, pos.y, pos.z, j.positionFrom.x, j.positionFrom.y, j.positionFrom.z) < 1.0)then
						showHelpNotification2("Appuyez sur ~INPUT_CONTEXT~ pour ".. j.positionFrom.nom)
						if IsControlJustPressed(1, 38) then
							DoScreenFadeOut(1000)
							Citizen.Wait(2500)
							SetEntityCoords(GetPlayerPed(-1), j.positionTo.x, j.positionTo.y, j.positionTo.z - 1)
							local licenseplate = GetVehicleNumberPlateText(vehicle)
							ESX.Game.DeleteVehicle(vehicle)
							ESX.Game.SpawnVehicle(model, {
								x = j.positionTo.x,
								y = j.positionTo.y,
								z = j.positionTo.z - 1
							}, j.positionTo.h, function(vehicle)
							TaskWarpPedIntoVehicle(ped, vehicle, -1)
							SetVehicleNumberPlateText(vehicle, licenseplate)
							end)
							DoScreenFadeIn(1000)
						end
					end
				end
			end
			
			if(Vdist(pos.x, pos.y, pos.z, j.positionTo.x, j.positionTo.y, j.positionTo.z) < 100.0)then
				DrawMarker(1, j.positionTo.x, j.positionTo.y, j.positionTo.z - 1, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.0, 50, 50, 204,100, 0, 0, 0,0)
				if(Vdist(pos.x, pos.y, pos.z, j.positionTo.x, j.positionTo.y, j.positionTo.z) < 100.0)then
					--Drawing.draw3DText(j.positionTo.x, j.positionTo.y, j.positionTo.z - 1.100, j.positionTo.nom, 1, 0.2, 0.1, 255, 255, 255, 215)
					if(Vdist(pos.x, pos.y, pos.z, j.positionTo.x, j.positionTo.y, j.positionTo.z) < 1.0)then
						showHelpNotification2("Appuyez sur ~INPUT_CONTEXT~ pour ".. j.positionTo.nom)
						--DrawSubtitleTimed(1000, 1)
						if IsControlJustPressed(1, 38) then
							DoScreenFadeOut(1000)
							Citizen.Wait(2500)
							SetEntityCoords(GetPlayerPed(-1), j.positionFrom.x, j.positionFrom.y, j.positionFrom.z - 1)
							local licenseplate = GetVehicleNumberPlateText(vehicle)
							ESX.Game.DeleteVehicle(vehicle)
							ESX.Game.SpawnVehicle(model, {
								x = j.positionFrom.x,
								y = j.positionFrom.y,
								z = j.positionFrom.z - 1
							}, j.positionFrom.h, function(vehicle)
							TaskWarpPedIntoVehicle(ped, vehicle, -1)
							SetVehicleNumberPlateText(vehicle, licenseplate)
							end)
							DoScreenFadeIn(1000)
						end
					end
				end
			end

		end
	end
end)

--Citizen.CreateThread(function()
--	while true do
--		Citizen.Wait(2)
--		local pos = GetEntityCoords(GetPlayerPed(-1), true)
--
--	    if IsControlJustPressed(1, 38) then
--			showHelpNotification2("coucou")
--		end
--	end
--end)