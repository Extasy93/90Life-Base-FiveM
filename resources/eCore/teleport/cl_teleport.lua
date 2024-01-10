registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~monter dans l'ascenceur",
    pos              = vector3(2267.7, 7062.962, 80.81171),
    action          = function()
        TriggerServerEvent('liberto:teleportMain', token)
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
    pos              = vector3(2314.14, 7098.22, 9.07336),
    action          = function()
        TriggerServerEvent('liberto:teleportLobby', token)
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