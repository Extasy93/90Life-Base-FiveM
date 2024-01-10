RegisterNetEvent("hud:getPlayersList")
AddEventHandler("hud:getPlayersList", function()
    local players = GetPlayers()
    local Callback = {}
    for k,v in pairs(players) do
            Callback[v] = {id = v, name = GetPlayerName(v)}
        table.insert(Callback, {id = v, name = GetPlayerName(v)})
    end
	
    TriggerClientEvent("hud:getPlayersList", source, Callback)
end)