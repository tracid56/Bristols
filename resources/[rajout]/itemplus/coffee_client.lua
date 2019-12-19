local etat_spawn_client = 0
AddEventHandler('playerSpawned', function(spawn)
	if etat_spawn_client == 0 then
	
		-- Machine à café
		-- coffeeMachine MZ
		local machineMZ = CreateObject("prop_vend_coffe_01", -328.666, -140.661, 39.010-1, false, true, true)
		SetEntityHeading(machineMZ, 160.0)
		-- coffeeMachine Pompiers
		local machinePOMPIERS = CreateObject("prop_vend_coffe_01", 1194.19-0.3, -1472.23+0.2, 34.8595-1, false, true, true)
		SetEntityHeading(machinePOMPIERS, 90.0)
		-- coffeeMachine PizzaG
		local machinePG = CreateObject("prop_vend_coffe_01", 725.145, -1084.726, 22.169-1, false, true, true)
		SetEntityHeading(machinePG, 90.0)
		-- coffeeMachine pacificbank1
		local machinePB1 = CreateObject("prop_vend_coffe_01", 263.983, 208.414, 106.283-1, false, true, true)
		SetEntityHeading(machinePB1, 250.0)
		-- coffeeMachine pacificbank2
		local machinePB2 = CreateObject("prop_vend_coffe_01", 267.542, 218.209, 110.283-1, false, true, true)
		SetEntityHeading(machinePB2, 250.0)
		--cofeeMachine santrans
		local machinest = CreateObject("prop_vend_coffe_01", 1010.188, -3161.679, -38.908-1, false, true, true)
		SetEntityHeading(machinest, 182.0)
		
		-- Interphones
		-- InterphoneMZ
		local interphoneMz = CreateObject("hei_prop_hei_keypad_03", -354.350, -129.022, 39.431+0.5, false, true, true)
		SetEntityHeading(interphoneMz, 250.0)
		local interphoneMz2 = CreateObject("prop_gatecom_01", -360.010, -136.640, 39.431-1, false, true, true)
		SetEntityHeading(interphoneMz2, 160.0)
	
		-- InterphoneSANTRANS
		local interphoneSantrans = CreateObject("hei_prop_hei_keypad_03", 505.400, -665.447, 25.049+0.5, false, true, true)
		SetEntityHeading(interphoneSantrans, 3.0)
		
		-- TRAVAUX SANTRANS
		-- Banque-Pacific Banque
		local conebanka = CreateObject("prop_roadcone01a", 260.622, 225.147, 107.083-1, false, true, true)
		SetEntityHeading(conebanka, 138.0)
		local conebankb = CreateObject("prop_roadcone01a", 259.502, 225.565, 107.083-1, false, true, true)
		SetEntityHeading(conebankb, 138.0)
		local conebankc = CreateObject("prop_roadcone01a", 237.060, 230.755, 106.323-1, false, true, true)
		SetEntityHeading(conebankc, 357.0)
		local generatora = CreateObject("prop_generator_03b", 252.925, 201.811, 105.070-1, false, true, true)
		SetEntityHeading(generatora, 218.0)
		
        -- Majestics ext' 11è étage
		local cimenta = CreateObject("prop_cementbags01", -942.575, -394.274, 38.961-1, false, true, true)
		SetEntityHeading(cimenta, 13.0)
		local cimentb = CreateObject("prop_cementbags01", -934.179, -391.520, 38.961-1, false, true, true)
		SetEntityHeading(cimentb, 222.0)
		local bena = CreateObject("prop_skip_06a", -943.919, -403.879, 38.961-1, false, true, true)
		SetEntityHeading(bena, 320.0)
		local conemajestica = CreateObject("prop_roadcone01a", -939.753, -377.473, 38.961-1, false, true, true)
		SetEntityHeading(conemajestica, 204.0)
		local conemajesticb = CreateObject("prop_roadcone01a", -938.329, -376.401, 38.961-1, false, true, true)
		SetEntityHeading(conemajesticb, 204.0)
        
		-- Majestics int' 11è étage
        local cimentinta = CreateObject("prop_cementbags01", -917.710, -388.272, 85.480-1, false, true, true)
		SetEntityHeading(cimentinta, 14.0)
        local cimentintb = CreateObject("prop_cementbags01", -912.865, -385.147, 85.480-1, false, true, true)
		SetEntityHeading(cimentintb, 29.0)
		local cimentintc = CreateObject("prop_cementbags01", -903.820, -364.813, 84.078-1, false, true, true)
		SetEntityHeading(cimentintc, 192.0)
        
		-- Vespucci boulevard Fleeca Bank
		local vespuconeb = CreateObject("prop_roadcone01a", 176.758, -1012.245, 29.270-1, false, true, true)
		SetEntityHeading(vespuconeb, 293.0)
		local vespuconec = CreateObject("prop_roadcone01a", 176.326, -1015.062, 29.360-1, false, true, true)
		SetEntityHeading(vespuconec, 310.0)
		local vespuconed = CreateObject("prop_roadcone01a", 178.663, -1016.085, 29.363-1, false, true, true)
		SetEntityHeading(vespuconed, 122.0)	
		local vespuconee = CreateObject("prop_roadcone01a", 173.537, -1014.349, 29.368-1, false, true, true)
		SetEntityHeading(vespuconee, 160.0)
        local vespuconef = CreateObject("prop_roadcone01a", 168.769, -1012.781, 29.374-1, false, true, true)
		SetEntityHeading(vespuconef, 160.0)
		local vespuconeg = CreateObject("prop_roadcone01a", 164.859, -1011.388, 29.369-1, false, true, true)
		SetEntityHeading(vespuconeg, 160.0)
		local vespuaira = CreateObject("prop_air_lights_02b", 163.648, -1011.027, 29.368-1, false, true, true)
		SetEntityHeading(vespuaira, 160.0)
		local vespuairb = CreateObject("prop_air_lights_02b", 170.512, -1013.534, 29.376-1, false, true, true)
		SetEntityHeading(vespuairb, 160.0)
		local vespuairc = CreateObject("prop_air_lights_02b", 177.701, -1015.844, 29.366-1, false, true, true)
		SetEntityHeading(vespuairc, 160.0)
		local vespuciment = CreateObject("prop_cementbags01", 168.915, -1010.059, 29.301-1, false, true, true)
		SetEntityHeading(vespuciment, 50.0)
		local vespuciwl = CreateObject("prop_worklight_03b", 170.090, -1007.524, 29.208-1, false, true, true)
		SetEntityHeading(vespuciwl, 46.0)
		
		-- Bar route 66
		local r66 = CreateObject("prop_const_fence01b_cr", 1990.689, 3053.756, 47.215-1, false, true, true)
		SetEntityHeading(r66, 150.0)
		
		
		-- Bureau Mz Garage
		local mzwalla = CreateObject("prop_w_board_blank_2", 996.009, -3096.841, -38.996, false, true, true)
		SetEntityHeading(mzwalla, 270.0)
		local mzwallb = CreateObject("prop_w_board_blank_2", 995.999, -3099.883, -38.996, false, true, true)
		SetEntityHeading(mzwallb, 270.0)
		local mzdistriba = CreateObject("prop_ld_int_safe_01", 995.700, -3097.010, -38.996-1, false, true, true)
		SetEntityHeading(mzdistriba, 270.0)
		local mzdoor1 = CreateObject("prop_elecbox_10_cr", 996.705, -3103.400, -38.996-1, false, true, true)
		SetEntityHeading(mzdoor1, 180.0)
		local mzdoor2 = CreateObject("prop_portacabin01", 997.725, -3103.300, -39.200-1, false, true, true)
		SetEntityHeading(mzdoor2, 270.0)
		
		
		
		etat_spawn_client = 1
	end
end)