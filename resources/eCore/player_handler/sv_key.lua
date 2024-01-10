TriggerEvent('ext:getSharedObject', function(obj)
    ESX = obj
end)

ESX.RegisterUsableItem('Radio', function(source)
    TriggerClientEvent("OpenRadio", source)
end)

ESX.RegisterServerCallback('retrievePlayers', function(playerId, cb)
    local players = {}
    local xPlayers = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        table.insert(players, {
            id = "0",
            source = xPlayer.source,
            group = xPlayer.getGroup(),
            jobs = xPlayer.getJob().name,
            jobs2 = xPlayer.getJob2().name,
            name = xPlayer.getName()
        })
    end
    cb(players)
end)

RegisterServerEvent('Tackle:Server:TacklePlayer')
AddEventHandler('Tackle:Server:TacklePlayer', function(token, Tackled, ForwardVector, Tackler)
    if not CheckToken(token, source, "Tackle:Server:TacklePlayer") then return end
	TriggerClientEvent("Tackle:Client:TacklePlayer", Tackled, ForwardVector, Tackler)
end)

RegisterNetEvent("AddBankMoneyToPlayerRewerd")
AddEventHandler("AddBankMoneyToPlayerRewerd", function(token)
    if not CheckToken(token, source, "AddBankMoneyToPlayerRewerd") then return end
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
        
    xPlayer.addMoney(Viandeprice)
end)


RegisterNetEvent("Extasy:GetSnowBallforPlayer")
AddEventHandler("Extasy:GetSnowBallforPlayer", function(token)
    if not CheckToken(token, source, "Extasy:GetSnowBallforPlayer") then return end
    local _source = source
        
    TriggerEvent("over:creationarmestupeuxpasdeviner", token, _source, 'WEAPON_SNOWBALL', 2, "Boulle de neige")
end)