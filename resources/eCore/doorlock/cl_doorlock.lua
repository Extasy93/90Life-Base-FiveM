registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~monter dans l'ascenceur",
    pos              = vector3(2888.24, 7384.32, 9.51),
    action          = function()
        TriggerServerEvent('gouvernement:teleportMain', token)
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 15,


    blip_enable      = false,

    marker           = true,
    size             = 0.6,

    drawmarkerType   = 6,
    drawmarkerRotation = 270.0,

    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~monter dans l'ascenceur",
    pos              = vector3(2865.09, 7390.19, 172.46),
    action          = function()
        TriggerServerEvent('gouvernement:teleportLobby', token)
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 15,


    blip_enable      = false,

    marker           = true,
    size             = 0.6,

    drawmarkerType   = 6,
    drawmarkerRotation = 270.0,

    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})