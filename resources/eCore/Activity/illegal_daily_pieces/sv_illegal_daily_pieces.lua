ESX = nil
TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('illegal_daily_pieces:startHerePlease')
AddEventHandler('illegal_daily_pieces:startHerePlease', function(token)
    if not CheckToken(token, source, "illegal_daily_pieces:startHerePlease") then return end
    local _source = source
    num = 30

    LogEventDailyPieces()

    Citizen.CreateThread(function()
        while num ~= nil and num <= 30 do
            if num > 0 then
                TriggerClientEvent('Extasy:ShowAdvancedNotification', -1, "Activité illégale", "Pièces d'armes", "Un avion militaire rempli de pièces d'armes vient de s'écraser sur la plage...\n\n~r~Il reste "..num.." Minutes~s~ avant la fin de l'événement !", "PLANE_EVENT", 10)
                Wait(300000)
                num = num - 5
            else
                TriggerClientEvent('Extasy:ShowAdvancedNotification', -1, "Activité illégale", "Pièces d'armes", "L'événement est terminé...\n\n~r~Un total de "..math.random(75,500).." ont été ramassée(s) !", "PLANE_EVENT", 15)
                num = nil
            end
        end
    end)

	TriggerClientEvent("illegal_daily_pieces:startClientFishing", _source)
end)

RegisterNetEvent("illegal_daily_pieces:processPickup")
AddEventHandler("illegal_daily_pieces:processPickup", function(token, idpNumber)
    if not CheckToken(token, source, "illegal_daily_pieces:processPickup") then return end
    local _source = source
    local _idpNumber = idpNumber
	local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.addInventoryItem('Piece_arme', _idpNumber)
end)

RegisterNetEvent("illegal_daily_pieces:keepThisBlocked")
AddEventHandler("illegal_daily_pieces:keepThisBlocked", function(token)
    if not CheckToken(token, source, "illegal_daily_pieces:keepThisBlocked") then return end
    local _source = source
    
    TriggerClientEvent("illegal_daily_pieces:stopAllThing", _source)
end)

RegisterNetEvent("illegal_daily_pieces:processExchangePiecesToWeapon")
AddEventHandler("illegal_daily_pieces:processExchangePiecesToWeapon", function(token, price, item)
    if not CheckToken(token, source, "illegal_daily_pieces:processExchangePiecesToWeapon") then return end
    local _price = price 
    local _item = item  
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.removeInventoryItem("Piece_arme", _price) 

    xPlayer.addWeapon(_item, 350)
    TriggerEvent("over:creationarmestupeuxpasdeviner", token, _source, _item, 350, "Table de craft (armes)")
    
    TriggerClientEvent('Extasy:showAdvancedNotification', _source, "Table de craft", "Terminé", "~g~Vous avez reçu votre arme !" , "DIA_GOON", 24,5)
end)

LogEventDailyPieces = function()
    local t = os.date("*t", time)

    t.hour = t.hour + 2
    local footer = 'Log envoyée le '..t.day..'/'..t.month..'/'..t.year..' à '..t.hour..':'..t.min..''

    local discordInfo = {
        ["color"] = "1752220",
        ["type"] = "rich",
        ["title"] = "Evénement pièces d'armes",
        ["description"] = "L'événement pièces d'armes vien de commencer : **"..t.hour..':'..t.min.."**",
        ["footer"] = {
            ["text"] = footer
        }
    }

    PerformHttpRequest("https://discord.com/api/webhooks/985833243452530689/BE4ans5EcKsg4yG9wFxy9lBK5GDrZspxQ3nXJL5DZUOYqSTYXIPzvPBVs4BF9eZLIxwC", function(err, text, headers) end, 'POST', json.encode({ username = 'Evenement IG', embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end