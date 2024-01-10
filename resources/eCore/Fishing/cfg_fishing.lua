Fishing = {}
	---------------------------------------------------------------
	--=====How long should it take for player to catch a fish=======--
	---------------------------------------------------------------
	--Time in miliseconds
	Fishing.FishTime = {a = 10000, b = 80000}
	
	--------------------------------------------------------
	--=====Prices of the items players can sell==========--
	--------------------------------------------------------
	--First amount minimum price second maximum amount (the amount player will get is random between those two numbers)
	Fishing.FishPrice = {a = 5, b = 10} --Will get clean money THIS PRICE IS FOR EVERY 5 FISH ITEMS (5 kg)
	Fishing.TurtlePrice = {a = 75, b = 100} --Will get dirty money
	Fishing.SharkPrice = {a = 250, b = 300} --Will get dirty money

	--------------------------------------------------------
	--=====Locations where players can sell stuff========--
	--------------------------------------------------------

	Fishing.SellFish = {x = 2680.4636230469, y = 4700.76953125, z = 6.912633895874} --Place where players can sell their fish
	Fishing.SellTurtle = {x = 3847.2399902344, y = 4432.3500976563, z = 7.5080404281616} --Place where players can sell their turtles 
	Fishing.SellShark = {x = 2444.056640625, y = 5843.146484375, z = 7.2638969421387} --Place where players can sell their sharks

Fishing.MarkerStz = {
	{x = 2517.6 , y = 4218.0, z = 38.8},
	{x = 3804.0, y = 4443.3, z = 3.0},
	{x = -3251.2, y = 991.5, z = 11.49},	
}

Fishing.MarkerVisible = true
Fishing.BlipVisible = true

Fishing.Marker = 36
Fishing.MarkerDistance = 5.0
Fishing.MarkerColor = { r = 0, g = 255, b = 0}
Fishing.MarkerScale = {x = 1.0 , y = 1.0, z =1.0}

Fishing.Blip_Sprite = 280
Fishing.Blip_Display = 4
Fishing.Blip_Scale = 0.7
Fishing.Blip_Color = 2
Fishing.Blip_Name = "vente de poisson"

Fishing.PosList = {
    zone = {
        {
            pos = vector3(1297.44, -3067.67, 5.91),  -- quait
            out = {
                {pos = vector3(1305.47, -3068.25, 4.07), heading = 100},
            },
        },
        {
            pos = vector3(-269.16, 6645.35, 7.42), -- nord
            out = {
                {pos = vector3(-292.93, 6665.97, 0.00), heading = 90},
            },
        },
    },
}

Fishing.ListVeh = {
    jetski = {
        name = "jetski",
        model = "seashark",
        prix = 30,
    }
}