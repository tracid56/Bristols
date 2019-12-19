local blips = {
   {name="Station Service", colour=1, scale=0.9, id=361, x=49.4187,   y=2778.793,  z=58.043},
   {name="Station Service", colour=1, scale=0.9, id=361, x=263.894,   y=2606.463,  z=44.983},
   {name="Station Service", colour=1, scale=0.9, id=361, x=1039.958,  y=2671.134,  z=39.550},
   {name="Station Service", colour=1, scale=0.9, id=361, x=1207.260,  y=2660.175,  z=37.899},
   {name="Station Service", colour=1, scale=0.9, id=361, x=2539.685,  y=2594.192,  z=37.944},
   {name="Station Service", colour=1, scale=0.9, id=361, x=2679.858,  y=3263.946,  z=55.240},
   {name="Station Service", colour=1, scale=0.9, id=361, x=2005.055,  y=3773.887,  z=32.403},
   {name="Station Service", colour=1, scale=0.9, id=361, x=1687.156,  y=4929.392,  z=42.078},
   {name="Station Service", colour=1, scale=0.9, id=361, x=1701.314,  y=6416.028,  z=32.763},
   {name="Station Service", colour=1, scale=0.9, id=361, x=179.857,   y=6602.839,  z=31.868},
   {name="Station Service", colour=1, scale=0.9, id=361, x=-94.4619,  y=6419.594,  z=31.489},
   {name="Station Service", colour=1, scale=0.9, id=361, x=-2554.996, y=2334.40,  z=33.078},
   {name="Station Service", colour=1, scale=0.9, id=361, x=-1800.375, y=803.661,  z=138.651},
   {name="Station Service", colour=1, scale=0.9, id=361, x=-1437.622, y=-276.747,  z=46.207},
   {name="Station Service", colour=1, scale=0.9, id=361, x=-2096.243, y=-320.286,  z=13.168},
   {name="Station Service", colour=1, scale=0.9, id=361, x=-724.619, y=-935.1631,  z=19.213},
   {name="Station Service", colour=1, scale=0.9, id=361, x=-526.019, y=-1211.003,  z=18.184},
   {name="Station Service", colour=1, scale=0.9, id=361, x=-70.2148, y=-1761.792,  z=29.534},
   {name="Station Service", colour=1, scale=0.9, id=361, x=265.648,  y=-1261.309,  z=29.292},
   {name="Station Service", colour=1, scale=0.9, id=361, x=819.653,  y=-1028.846,  z=26.403},
   {name="Station Service", colour=1, scale=0.9, id=361, x=1208.951, y= -1402.567, z=35.224},
   {name="Station Service", colour=1, scale=0.9, id=361, x=1181.381, y= -330.847,  z=69.316},
   {name="Station Service", colour=1, scale=0.9, id=361, x=620.843,  y= 269.100,  z=103.089},
   {name="Station Service", colour=1, scale=0.9, id=361, x=2581.321, y=362.039, 108.468},
   --{name="Cargoship", id=410, x=-90.000, y=-2365.800, z=14.300},
  }

Citizen.CreateThread(function()

    for _, item in pairs(blips) do
      --item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipAsShortRange(item.blip, true)
      SetBlipColour(item.blip, item.colour)
      SetBlipScale(item.blip, item.scale)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(item.name)
      EndTextCommandSetBlipName(item.blip)
  end

end)
 
