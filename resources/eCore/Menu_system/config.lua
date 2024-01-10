ConfigGlobalMenu = {}

-- Utilisez-vous ESX? Transformez cela en vrai si vous souhaitez que le carburant et les jerrycans coûtent quelque chose.
ConfigGlobalMenu.UseESX = true

-- What should the price of jerry cans be?
ConfigGlobalMenu.JerryCanCost = 200
ConfigGlobalMenu.RefillCost = 150 -- If it is missing half of it capacity, this amount will be divided in half, and so on.

-- Fuel decor - No need to change this, just leave it.
ConfigGlobalMenu.FuelDecor = "_FUEL_LEVEL"

-- What keys are disabled while you're fueling.
ConfigGlobalMenu.DisableKeys = {0, 22, 23, 24, 29, 30, 31, 37, 44, 56, 82, 140, 166, 167, 168, 170, 288, 289, 311, 323}

-- Want to use the HUD? Turn this to true.
ConfigGlobalMenu.EnableHUD = true

-- ConfigGlobalMenuure blips here. Turn both to false to disable blips all together.
ConfigGlobalMenu.ShowNearestGasStationOnly = false
ConfigGlobalMenu.ShowAllGasStations = true

-- ConfigGlobalMenuure the strings as you wish here.

-- For change languagues of notifications, look source/fuel_client.lua.
ConfigGlobalMenu.Strings = {
	JerryCanEmpty = "Bidon d'essence rempli",
	PurchaseJerryCan = "Appuyez sur ~g~G ~w~pour acheter un bidon d'essence à ~g~$" .. ConfigGlobalMenu.JerryCanCost,
	CancelFuelingPump = "Appuyez sur ~g~G ~w~pour annuler le plein",
	CancelFuelingJerryCan = "Appuvez sur ~g~G ~w~pour annuler le plein",
	NotEnoughCash = "Vous n avez pas assez d'argent",
	RefillJerryCan = "Appuyez sur ~g~G ~w~ pour remplir votre bidon d'essence pour ",
	NotEnoughCashJerryCan = "Vous n avez pas assez d argent pour un bidon d'essence",
	JerryCanFull = "Le bidon d'essence est plein",
	TotalCost = "Prix",
}

if not ConfigGlobalMenu.UseESX then
	ConfigGlobalMenu.Strings.PurchaseJerryCan = "Appuyez sur ~g~E ~w~pour acheter un bidon d'essence"
	ConfigGlobalMenu.Strings.RefillJerryCan = "Appuyez sur ~g~E ~w~ pour remplir le bidon d'essence"
end


ConfigGlobalMenu.Strings.PurchaseJerryCan = "Appuyez sur ~p~[E] ~w~pour acheter un bidon d'essence"
ConfigGlobalMenu.Strings.RefillJerryCan = "Appuyez sur ~p~[E] ~w~ pour remplir le bidon d'essence"


ConfigGlobalMenu.PumpModels = {
	[-2007231801] = true,
	[1339433404] = true,
	[1694452750] = true,
	[1933174915] = true,
	[-462817101] = true,
	[-469694731] = true,
	[-164877493] = true
}

-- Blacklist certain vehicles. Use names or hashes. https://wiki.gtanet.work/index.php?title=Vehicle_Models
ConfigGlobalMenu.Blacklist = {
	--"Adder",
	--276773164
}

-- Do you want the HUD removed from showing in blacklisted vehicles?
ConfigGlobalMenu.RemoveHUDForBlacklistedVehicle = true

-- Class multipliers. If you want SUVs to use less fuel, you can change it to anything under 1.0, and vise versa.
ConfigGlobalMenu.Classes = {
	[0] = 0.7, -- Compacts
	[1] = 0.7, -- Sedans
	[2] = 0.7, -- SUVs
	[3] = 0.7, -- Coupes
	[4] = 0.7, -- Muscle
	[5] = 0.7, -- Sports Classics
	[6] = 0.7, -- Sports
	[7] = 0.7, -- Super
	[8] = 0.5, -- Motorcycles
	[9] = 0.7, -- Off-road
	[10] = 0.3, -- Industrial
	[11] = 0.4, -- Utility
	[12] = 0.6, -- Vans
	[13] = 0.0, -- Cycles
	[14] = 0.5, -- Boats
	[15] = 0.3, -- Helicopters
	[16] = 0.3, -- Planes
	[17] = 0.5, -- Service
	[18] = 0.5, -- Emergency
	[19] = 0.5, -- Military
	[20] = 0.5, -- Commercial
	[21] = 0.0, -- Trains
}

-- The left part is at percentage RPM, and the right is how much fuel (divided by 10) you want to remove from the tank every second
ConfigGlobalMenu.FuelUsage = {
	[1.0] = 1.4,
	[0.9] = 1.2,
	[0.8] = 1.0,
	[0.7] = 0.9,
	[0.6] = 0.8,
	[0.5] = 0.7,
	[0.4] = 0.5,
	[0.3] = 0.4,
	[0.2] = 0.2,
	[0.1] = 0.1,
	[0.0] = 0.0,
}

ConfigGlobalMenu.GasStations = {
	vector3(3289.12, 5146.15, 9.57),
}

ConfigGlobalMenu.DrawDistance = 30.0
ConfigGlobalMenu.MarkerSize = vector3(2.5, 2.5, 2.0)

ConfigGlobalMenu.Price = 92

ConfigGlobalMenu.Shops = {
	vector3(72.254, -1399.102, 28.876),
}

ConfigGlobalMenu.BarberPrice = 24

ConfigGlobalMenu.BarberDrawDistance = 20.0
ConfigGlobalMenu.BarberMarkerSize   = vector3(1.5, 1.5, 1.0)
ConfigGlobalMenu.BarberMarkerColor  = {r = 52, g = 226, b = 235}
ConfigGlobalMenu.BarberMarkerType   = 27

cfg_barber = {}

cfg_barber["available_payments"] = {
    "~b~Banque~s~",
    "~g~Liquide~s~"
}

cfg_barber.shops = {
    {
        pos = vector3(2363.425, 5938.742, 10.01303),
        tpCoords = vector3(2363.885, 5938.182, 9.01303), 
        heading = 177.78, 
        fov = 25.0, 
        camCoords = vector3(2361.385, 5936.662, 10.53661), 
        camRotx = 0.0, camRoty = 0.0, camRotz = -60.0, 
        time = 1250,

        camOptions  = {
            camPos  = vector3(-815.39, -184.31, 37.70),
            camRotx = 0.0, camRoty = 0.0, camRotz = 0.0,
            camFov  = 15.0,
        },
    },
    {
        pos = vector3(3676.376, 7521.132, 18.74892),
        tpCoords = vector3(3676.267, 7520.599, 17.74892), 
        heading = 90.219, 
        fov = 25.0, 
        camCoords = vector3(3675.23, 7522.38, 19.34), 
        camRotx = 0.0, camRoty = 0.0, camRotz = 215.0, 
        time = 1250,

        camOptions  = {
            camPos  = vector3(-815.39, -184.31, 37.70),
            camRotx = 0.0, camRoty = 0.0, camRotz = 0.0,
            camFov  = 15.0,
        },
    },
}

cfg_barber.price = 250