--[[local int_arcade1 = GetInteriorAtCoordsWithType(124.49740000,-219.317600000,53.73647000,"v_clothesmid") -- ville
local int_arcade2 = GetInteriorAtCoordsWithType(617.22600000,2759.21600000,41.26674000,"v_clothesmid") -- desert
local int_arcade3 = GetInteriorAtCoordsWithType(-3171.554000,1048.27800000,20.04184000,"v_clothesmid") -- cote
local int_arcade4 = GetInteriorAtCoordsWithType(-1194.538000,-772.43110000,16.50206000,"v_clothesmid") -- ville 2

RefreshInterior(int_arcade1)
RefreshInterior(int_arcade2)
RefreshInterior(int_arcade3)
RefreshInterior(int_arcade4)

-- Ville
EnableInteriorProp(int_arcade1, "censored")
DisableInteriorProp(int_arcade1, "wood")

-- Desert
DisableInteriorProp(int_arcade2, "censored")
EnableInteriorProp(int_arcade2, "wood")

-- Cote
DisableInteriorProp(int_arcade3, "censored")
EnableInteriorProp(int_arcade3, "wood")

-- Ville 2
EnableInteriorProp(int_arcade4, "censored")
DisableInteriorProp(int_arcade4, "wood")--]]
 
-- retirée pour test vicecity