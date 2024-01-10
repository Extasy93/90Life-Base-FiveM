RegisterServerEvent('liberto:teleportMain')
AddEventHandler('liberto:teleportMain', function(token, player)
    if not CheckToken(token, source, "liberto:teleportMain") then return end

    SetEntityCoords(source, 2314.14, 7098.22, 10.07336)
end)

RegisterServerEvent('liberto:teleportLobby')
AddEventHandler('liberto:teleportLobby', function(token, player)
    if not CheckToken(token, source, "liberto:teleportLobby") then return end

    SetEntityCoords(source, 2267.7, 7062.962, 81.81171)
end)
