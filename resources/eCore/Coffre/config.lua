--Truck
Coffre	=	{}

 -- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg)
Coffre.Limit = 35000

-- Default weight for an item:
	-- weight == 0 : The item do not affect character inventory weight
	-- weight > 0 : The item cost place on inventory
	-- weight < 0 : The item add place on inventory. Smart people will love it.
Coffre.DefaultWeight = 1

-- If true, ignore rest of file
Coffre.WeightSqlBased = false

-- I Prefer to edit weight on the Coffre.lua and I have switched Coffre.WeightSqlBased to false:

Coffre.localWeight = {
    -- basic
    pain = 1,
    eau = 1,

    -- métiers
    acetone = 1,
    alive_chicken = 1,
    beer = 1,
    blowpipe = 1,
    carokit = 1,
    carotool = 1,	
    chips = 1,
    cigarett = 1,
    clothe = 1,
    coffe = 1,
    copper = 1,
    cupcake = 1,
    cutted_wood = 1,	
    diamond = 1,
    essence = 1,
    fish = 1,
    fishandchips = 1,
    fishd = 1,
    fixkit = 1,
    fixtool = 1,
    gazbottle = 1,
    gold = 1,
    hamburger = 1,
    icetea = 1,
    iron = 1,
    medikit = 1,
    lighter = 1,
    milk = 1,
    packaged_chicken = 1,
    packaged_plank = 1,
    petrol = 1,
    petrol_raffin = 1,
    phone = 1,
    sandwich = 1,
    lighter = 1,
    sim = 1,
    slaughtered_chicken = 1,	
    stone = 1,
    tequila = 1,
    tissu = 1,	
    vodka = 1,
    washed_stone = 1,
    whisky = 1,
    wine = 1,
    wood = 1,
    wool = 1,
    raisin = 1,
    jus_raisin = 1,
    grand_cru = 1,
    vine = 1,
    pepite_dor = 1,
    lingot_dor = 1,
 

    -- illégale
    coke = 2,
    coke_pooch = 1,
    meth = 1,
    meth_pooch = 1,
    methlab = 1,
    weed = 2,
    weed_pooch = 1,
    opium = 2,
    opium_pooch = 1,
    champi = 1,
    lsd = 1,
    ecstasy = 1,
    ecstasy_pooch = 1,
    billet = 1,
    billet_pooch = 1,
    coke = 1,
    coke_pooch = 1,
    crack = 1,
    crack_pooch = 1,
    ketamine = 1,
    ketamine_pooch = 1,	
    lithium = 1,
    net_cracker = 1,
    thermite = 1,




    -- armes
    WEAPON_COMBATPISTOL = 1, -- poid poir une munnition
    WEAPON_NIGHTSTICK       = 1,
    WEAPON_STUNGUN          = 1,
    WEAPON_FLASHLIGHT       = 1,
    WEAPON_FLAREGUN         = 1,
    WEAPON_FLARE            = 1,
    WEAPON_HEAVYPISTOL      = 1,
    WEAPON_ASSAULTSMG       = 1,
    WEAPON_COMBATPDW        = 1,
    WEAPON_BULLPUPRIFLE     = 1,
    WEAPON_PUMPSHOTGUN      = 1,
    WEAPON_BULLPUPSHOTGUN   = 1,
    WEAPON_CARBINERIFLE     = 1,
    WEAPON_ADVANCEDRIFLE    = 1,
    WEAPON_MARKSMANRRIFLE   = 1,
    WEAPON_SNIPERRIFLE      = 1,
    WEAPON_FIREEXTINGUISHER = 10, 
    GADGET_PARACHUTE        = 1,
    WEAPON_BAT              = 10,
    WEAPON_PISTOL           = 1,

    -- argent
    black_money = 0.1, -- poids pour un argent sale
    money = 0.1, -- poids pour un argent

}


Coffre.VehicleLimit = {
    [0] = 500, --Compact
    [1] = 500, --Sedan
    [2] = 1100, --SUV
    [3] = 500, --Coupes
    [4] = 500, --Muscle
    [5] = 500, --Sports Classics
    [6] = 500, --Sports
    [7] = 300, --Super
    [8] = 50, --Motorcycles
    [9] = 600, --Off-road
    [10] = 2000, --Industrial
    [11] = 800, --Utility
    [12] = 1900, --Vans
    [13] = 0, --Cycles
    [14] = 500, --Boats
    [15] = 500, --Helicopters
    [16] = 0, --Planes
    [17] = 500, --Service
    [18] = 500, --Emergency
    [19] = 0, --Military
    [20] = 8000, --Commercial
    [21] = 0, --Trains
}

Coffre.VehiclePlate = {
	taxi        = "TAXI",
	cop         = "LSPD",
	ambulance   = "EMS0",
	mecano	    = "MECA",
}
