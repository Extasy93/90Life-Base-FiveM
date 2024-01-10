-- Exemple
registerNewMarker({
    npcType          = 'drawmarker',
    pos              = vector3(1.0,1.0,71.0),
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~ le catalogue",
    action           = function()
        exports['eWebsite']:OpenWebsite("https://github.com/")
    end,
    spawned          = false,
    entity           = nil,
    load_dst         = 50,

    blip_enable      = false,

    marker           = true,
    size             = 0.45,

    drawmarkerType   = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})


registerNewMarker({
    npcType          = 'drawmarker',
    pos              = vector3(0,0,0),
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~ ouvir un site ",
    action           = function()
        exports['eWebsite']:OpenWebsite("")
    end,
    spawned          = false,
    entity           = nil,
    load_dst         = 50,

    blip_enable      = false,

    marker           = true,
    size             = 0.45,

    drawmarkerType   = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})



-------- Solomon Spawn ----------

registerNewMarker({
    npcType          = 'drawmarker',
    pos              = vector3(-260.064, -1902.09, 26.8),
    action           = function()
        --
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 40,


    blip_enable      = false,

    marker           = true,
    size             = 0.80,

    drawmarkerType   = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

------------- DROGUES --------------
-- Labo de Weed

registerNewMarker({
    npcType         = 'drawmarker',
    pos             = vector3(499.17, -550.93, 23.75),
    interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~entrer dans le labo de ~g~Weed",
    action          = function()
        DoScreenFadeOut(1000)
		Citizen.Wait(2500)
		SetEntityCoords(GetPlayerPed(-1), vector3(1063.42, -3183.92, -38.50) - 1)
		DoScreenFadeIn(1000)
    end,
    spawned         = false,
    entity          = nil,
    load_dst        = 8,

    blip_enable     = false,

    marker          = true,
    size            = 0.45,

    drawmarkerType  = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType         = 'drawmarker',
    pos             = vector3(1065.08, -3183.76, -40.1),
    interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~sortir du labo de ~g~Weed",
    action          = function()
        DoScreenFadeOut(1000)
		Citizen.Wait(2500)
		SetEntityCoords(GetPlayerPed(-1), vector3(499.17, -550.93, 24.75) - 1)
		DoScreenFadeIn(1000)
    end,
    spawned         = false,
    entity          = nil,
    load_dst        = 25,

    blip_enable     = false,

    marker          = true,
    size            = 0.45,

    drawmarkerType  = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

-- Labo de Coke

registerNewMarker({
    npcType         = 'drawmarker',
    pos             = vector3(1185.5, -1384.38, 34.19),
    interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~entrer dans le labo de ~w~Coke",
    action          = function()
        DoScreenFadeOut(1000)
		Citizen.Wait(2500)
		SetEntityCoords(GetPlayerPed(-1), vector3(1088.59, -3188.56, -38.99) - 1)
		DoScreenFadeIn(1000)
    end,
    spawned         = false,
    entity          = nil,
    load_dst        = 8,

    blip_enable     = false,

    marker          = true,
    size            = 0.45,

    drawmarkerType  = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType         = 'drawmarker',
    pos             = vector3(1088.59, -3188.56, -39.9),
    interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~sortir du labo de ~w~Coke",
    action          = function()
        DoScreenFadeOut(1000)
		Citizen.Wait(2500)
		SetEntityCoords(GetPlayerPed(-1), vector3(1187.62, -1384.2, 35.19) - 1)
		DoScreenFadeIn(1000)
    end,
    spawned         = false,
    entity          = nil,
    load_dst        = 25,

    blip_enable     = false,

    marker          = true,
    size            = 0.45,

    drawmarkerType  = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

-- Labo de Crack

registerNewMarker({
    npcType         = 'drawmarker',
    pos             = vector3(-1147.73, -1451.96, 3.60),
    interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~entrer dans le labo de ~o~Crack",
    action          = function()
        DoScreenFadeOut(1000)
		Citizen.Wait(2500)
		SetEntityCoords(GetPlayerPed(-1), vector3(1004.95, -3150.67, -37.91) - 1)
		DoScreenFadeIn(1000)
    end,
    spawned         = false,
    entity          = nil,
    load_dst        = 8,

    blip_enable     = false,

    marker          = true,
    size            = 0.45,

    drawmarkerType  = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType         = 'drawmarker',
    pos             = vector3(996.99, -3157.96, -39.90),
    interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~sortir du labo de ~o~Crack",
    action          = function()
        DoScreenFadeOut(1000)
		Citizen.Wait(2500)
		SetEntityCoords(GetPlayerPed(-1), vector3(-1152.94, -1448.66, 4.58) - 1)
		DoScreenFadeIn(1000)
    end,
    spawned         = false,
    entity          = nil,
    load_dst        = 25,

    blip_enable     = false,

    marker          = true,
    size            = 0.45,

    drawmarkerType  = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

-- Labo de Heroine

registerNewMarker({
    npcType         = 'drawmarker',
    pos             = vector3(-1308.75, -165.85, 43.55),
    interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~entrer dans le labo de ~r~Héroine",
    action          = function()
        DoScreenFadeOut(1000)
		Citizen.Wait(2500)
		SetEntityCoords(GetPlayerPed(-1), vector3(1173.69,-3196.69, -39.01) - 1)
		DoScreenFadeIn(1000)
    end,
    spawned         = false,
    entity          = nil,
    load_dst        = 8,

    blip_enable     = false,

    marker          = true,
    size            = 0.45,

    drawmarkerType  = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType         = 'drawmarker',
    pos             = vector3(1173.69,-3196.69, -39.95),
    interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~sortir du labo de ~r~Héroine",
    action          = function()
        DoScreenFadeOut(1000)
		Citizen.Wait(2500)
		SetEntityCoords(GetPlayerPed(-1), vector3(-1306.54, -166.39, 45.22) - 1)
		DoScreenFadeIn(1000)
    end,
    spawned         = false,
    entity          = nil,
    load_dst        = 25,

    blip_enable     = false,

    marker          = true,
    size            = 0.45,

    drawmarkerType  = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

-- Labo de Opium

registerNewMarker({
    npcType         = 'drawmarker',
    pos             = vector3(-1305.22, -615.77, 26.35),
    interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~entrer dans le labo d'~p~Opium",
    action          = function()
        DoScreenFadeOut(1000)
		Citizen.Wait(2500)
		SetEntityCoords(GetPlayerPed(-1), vector3(1105.11, -3099.26, -39.22) - 1)
		DoScreenFadeIn(1000)
    end,
    spawned         = false,
    entity          = nil,
    load_dst        = 25,

    blip_enable     = false,

    marker          = true,
    size            = 0.45,

    drawmarkerType  = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType         = 'drawmarker',
    pos             = vector3(1105.11, -3099.26, -39.99),
    interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~sortir du labo de d'~p~Opium",
    action          = function()
        DoScreenFadeOut(1000)
		Citizen.Wait(2500)
		SetEntityCoords(GetPlayerPed(-1), vector3(-1301.5, -614.05, 28.32) - 1)
		DoScreenFadeIn(1000)
    end,
    spawned         = false,
    entity          = nil,
    load_dst        = 25,

    blip_enable     = false,

    marker          = true,
    size            = 0.45,

    drawmarkerType  = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

-- Avocat

registerNewMarker({
    npcType         = 'drawmarker',
    pos             = vector3(-1898.043, -572.607, 10.90),
    interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~vous téléporter dans le cabinet d'avocat",
    action          = function()
        DoScreenFadeOut(1000)
		Citizen.Wait(2500)
		SetEntityCoords(GetPlayerPed(-1), vector3(-1902.214, -572.643, 19.20) - 1)
		DoScreenFadeIn(1000)
    end,
    spawned         = false,
    entity          = nil,
    load_dst        = 25,

    blip_enable     = false,

    marker          = true,
    size            = 0.45,

    drawmarkerType  = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType         = 'drawmarker',
    pos             = vector3(-1901.99, -572.37, 18.1),
    interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~vous téléporter dehors",
    action          = function()
        DoScreenFadeOut(1000)
		Citizen.Wait(2500)
		SetEntityCoords(GetPlayerPed(-1), vector3(-1898.043, -572.607, 11.80) - 1)
		DoScreenFadeIn(1000)
    end,
    spawned         = false,
    entity          = nil,
    load_dst        = 25,

    blip_enable     = false,

    marker          = true,
    size            = 0.45,

    drawmarkerType  = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

-- Villa Cayo Périco

registerNewMarker({
    npcType         = 'drawmarker',
    pos             = vector3(4982.143, -5710.307, 18.90),
    interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~vous téléporter dans la villa",
    action          = function()
        DoScreenFadeOut(1000)
		Citizen.Wait(2500)
		SetEntityCoords(GetPlayerPed(-1), vector3(4989.5, -5717.243, 19.80) - 1)
		DoScreenFadeIn(1000)
    end,
    spawned         = false,
    entity          = nil,
    load_dst        = 25,

    blip_enable     = false,

    marker          = true,
    size            = 0.45,

    drawmarkerType  = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType         = 'drawmarker',
    pos             = vector3(4989.5, -5717.243, 18.90),
    interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~sortir de la villa",
    action          = function()
        DoScreenFadeOut(1000)
		Citizen.Wait(2500)
		SetEntityCoords(GetPlayerPed(-1), vector3(4982.143, -5710.307, 18.90) - 1)
		DoScreenFadeIn(1000)
    end,
    spawned         = false,
    entity          = nil,
    load_dst        = 25,

    blip_enable     = false,

    marker          = true,
    size            = 0.45,

    drawmarkerType  = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

-- Hopital Garage 

registerNewMarker({
    npcType         = 'drawmarker',
    pos             = vector3(319.705, -560.12, 27.78),
    interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~vous téléporter dans l'hopital",
    action          = function()
        DoScreenFadeOut(1000)
		Citizen.Wait(2500)
		SetEntityCoords(GetPlayerPed(-1), vector3(330.4641, -601.0739, 43.26) - 1)
		DoScreenFadeIn(1000)
    end,
    spawned         = false,
    entity          = nil,
    load_dst        = 25,

    blip_enable     = false,

    marker          = true,
    size            = 0.45,

    drawmarkerType  = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType         = 'drawmarker',
    pos             = vector3(330.4641, -601.0739, 42.32),
    interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~vous téléporter en bas de l'hopital",
    action          = function()
        DoScreenFadeOut(1000)
		Citizen.Wait(2500)
		SetEntityCoords(GetPlayerPed(-1), vector3(319.42, -559.4, 28.74) - 1)
		DoScreenFadeIn(1000)
    end,
    spawned         = false,
    entity          = nil,
    load_dst        = 25,

    blip_enable     = false,

    marker          = true,
    size            = 0.45,

    drawmarkerType  = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

-- Unicorn

registerNewMarker({
    npcType         = 'drawmarker',
    pos             = vector3(133.1785, -1293.6873, 28.3),
    interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~vous téléporter derière le bar",
    action          = function()
        DoScreenFadeOut(1000)
		Citizen.Wait(2500)
		SetEntityCoords(GetPlayerPed(-1), vector3(132.25, -1287.33, 29.28) - 1)
		DoScreenFadeIn(1000)
    end,
    spawned         = false,
    entity          = nil,
    load_dst        = 25,

    blip_enable     = false,

    marker          = true,
    size            = 0.45,

    drawmarkerType  = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType         = 'drawmarker',
    pos             = vector3(131.9941, -1287.3, 28.3),
    interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~sortir du bar",
    action          = function()
        DoScreenFadeOut(1000)
		Citizen.Wait(2500)
		SetEntityCoords(GetPlayerPed(-1), vector3(133.1785, -1293.6873, 29.2) - 1)
		DoScreenFadeIn(1000)
    end,
    spawned         = false,
    entity          = nil,
    load_dst        = 25,

    blip_enable     = false,

    marker          = true,
    size            = 0.45,

    drawmarkerType  = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

-- Bahamas

registerNewMarker({
    npcType         = 'drawmarker',
    pos             = vector3(-1388.6785, -586.7873, 29.25),
    interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~entrer dans le bahamas",
    action          = function()
        DoScreenFadeOut(1000)
		Citizen.Wait(2500)
		SetEntityCoords(GetPlayerPed(-1), vector3(-1387.1785, -588.6873, 30.2) - 1)
		DoScreenFadeIn(1000)
    end,
    spawned         = false,
    entity          = nil,
    load_dst        = 25,

    blip_enable     = false,

    marker          = true,
    size            = 0.45,

    drawmarkerType  = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType         = 'drawmarker',
    pos             = vector3(-1387.1785, -588.6873, 29.33),
    interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~sortir du bahamas",
    action          = function()
        DoScreenFadeOut(1000)
		Citizen.Wait(2500)
		SetEntityCoords(GetPlayerPed(-1), vector3(-1388.6785, -586.7873, 30.2) - 1)
		DoScreenFadeIn(1000)
    end,
    spawned         = false,
    entity          = nil,
    load_dst        = 25,

    blip_enable     = false,

    marker          = true,
    size            = 0.45,

    drawmarkerType  = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

-- Hopitale 5ème étage

registerNewMarker({
    npcType         = 'drawmarker',
    pos             = vector3(332.3785, -595.6873, 42.29),
    interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~monter au 5eme étage",
    action          = function()
        DoScreenFadeOut(1000)
		Citizen.Wait(2500)
		SetEntityCoords(GetPlayerPed(-1), vector3(338.57, -583.83, 75.18) - 1)
		DoScreenFadeIn(1000)
    end,
    spawned         = false,
    entity          = nil,
    load_dst        = 25,

    blip_enable     = false,

    marker          = true,
    size            = 0.45,

    drawmarkerType  = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType         = 'drawmarker',
    pos             = vector3(338.6541, -583.6039, 73.18),
    interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~déscendre au 1eme étage",
    action          = function()
        DoScreenFadeOut(1000)
		Citizen.Wait(2500)
		SetEntityCoords(GetPlayerPed(-1), vector3(332.3785, -595.6873, 42.29) - 1)
		DoScreenFadeIn(1000)
    end,
    spawned         = false,
    entity          = nil,
    load_dst        = 25,

    blip_enable     = false,

    marker          = true,
    size            = 0.45,

    drawmarkerType  = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

-- Bank central

registerNewMarker({
    npcType         = 'drawmarker',
    pos             = vector3(255.3785, 228.6873, 105.29),
    interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~monter sur le toit",
    action          = function()
        DoScreenFadeOut(1000)
		Citizen.Wait(2500)
		SetEntityCoords(GetPlayerPed(-1), vector3(243.6541, 228.6039, 151.16) - 1)
		DoScreenFadeIn(1000)
    end,
    spawned         = false,
    entity          = nil,
    load_dst        = 25,

    blip_enable     = false,

    marker          = true,
    size            = 0.45,

    drawmarkerType  = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType         = 'drawmarker',
    pos             = vector3(243.6541, 228.6039, 150.65),
    interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~déscendre dans la banque",
    action          = function()
        DoScreenFadeOut(1000)
		Citizen.Wait(2500)
		SetEntityCoords(GetPlayerPed(-1), vector3(255.3785, 228.6873, 106.9) - 1)
		DoScreenFadeIn(1000)
    end,
    spawned         = false,
    entity          = nil,
    load_dst        = 25,

    blip_enable     = false,

    marker          = true,
    size            = 0.45,

    drawmarkerType  = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

-- Bahamas Comptoir

registerNewMarker({
    npcType         = 'drawmarker',
    pos             = vector3(-1386.2585, -627.473, 29.82),
    interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~aller derierre le comptoir",
    action          = function()
        DoScreenFadeOut(1000)
		Citizen.Wait(2500)
		SetEntityCoords(GetPlayerPed(-1), vector3(-1379.4, -630.93, 30.82) - 1)
		DoScreenFadeIn(1000)
    end,
    spawned         = false,
    entity          = nil,
    load_dst        = 20,

    blip_enable     = false,

    marker          = true,
    size            = 0.45,

    drawmarkerType  = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType         = 'drawmarker',
    pos             = vector3(-1379.4, -630.93, 29.82),
    interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~sortir du comptoir",
    action          = function()
        DoScreenFadeOut(1000)
		Citizen.Wait(2500)
		SetEntityCoords(GetPlayerPed(-1), vector3(-1385.9, -623.78, 32.82) - 1)
		DoScreenFadeIn(1000)
    end,
    spawned         = false,
    entity          = nil,
    load_dst        = 25,

    blip_enable     = false,

    marker          = true,
    size            = 0.45,

    drawmarkerType  = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})


