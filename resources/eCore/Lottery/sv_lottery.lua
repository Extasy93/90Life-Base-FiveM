ESX = nil
lotteryTable = {}
lotteryTable.expireDate = 1
resultTable = {}
lotteryPlayersTable = {}
resultTirage = {}
allID = {}
local totalCount = 0
local AllIdTable = {}
local check = false

TriggerEvent("ext:getSharedObject", function(obj)
    ESX = obj
    Wait(10000)
    MySQL.Async.fetchAll("SELECT * FROM lottery", {}, function(result)
        for k,v in pairs(result) do
            lotteryTable = {expireDate = v.expireDate, totalMoney = v.totalMoney, participationCount = v.participationCount}
        end
    end)
end)

local function formatExpiration(time)
    local t = os.date("*t", time)
    return t.day.."/"..t.month.."/"..t.year.." ~s~à~o~ "..t.hour..":"..t.min.."h"
end

local function formatExpirationDiscord(time)
    local t = os.date("*t", time)
    return t.day.."/"..t.month.."/"..t.year.." à "..t.hour..":"..t.min.."h"
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(15000)

        local time = os.time()
        local expireDate =  lotteryTable.expireDate

        MySQL.Async.fetchAll("SELECT * FROM lottery", {}, function(result)
            for k,v in pairs(result) do
                lotteryTable = {expireDate = v.expireDate, totalMoney = v.totalMoney, participationCount = v.participationCount}
            end
        end)

        if time > expireDate then
            MySQL.Async.fetchAll("SELECT * FROM lottery", {}, function(result)
                for k,v in pairs(result) do
                    resultTable = {next = v.expireDate, totalMoney = v.totalMoney, participationCount = v.participationCount}
            
                    MySQL.Async.fetchAll("SELECT * FROM user_lottery", {}, function(result2)
                        allID = {}
                        for _, b in pairs(result2) do
                            local AllIdTable = b.id
                            allID[#allID + 1] = b.identifier
                        end
            
                        totalCount = #allID
                        print("^3Total participations for lottery: " .. totalCount .. "^0")
                        local WinerLicense = allID[math.random(totalCount)]
                        print("Winer license: "..WinerLicense)

                        local xPlayers = ESX.GetPlayers()
                        for i=1, #xPlayers, 1 do
                            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                            if xPlayer.identifier == WinerLicense then -- Si il est co (give l'argent)
                                TriggerClientEvent("Extasy:showNotification", xPlayers[i], "~g~Félicitations ! ~s~Vous remportez un total de ~g~"..ESX.Math.GroupDigits(resultTable.totalMoney).."$ ~s~grace à votre participation dans la Lottery !")
                                xPlayer.addAccountMoney("bank", resultTable.totalMoney)
                            else -- Si il est déco (give l'argent par le SQL)
                                MySQL.Async.fetchAll('SELECT accounts FROM users WHERE identifier = @identifier', {
                                    ['@identifier'] = WinerLicense
                                }, function(oldUserAccounts)
                                    if oldUserAccounts ~= nil then
                                        local accountsTable = json.decode(oldUserAccounts[1].accounts)
                                        accountsTable.bank = accountsTable.bank + resultTable.totalMoney
                    
                                        MySQL.Async.execute('UPDATE users SET accounts = @accounts WHERE identifier = @identifier', {
                                            ['@accounts'] = json.encode(accountsTable),
                                            ['@identifier'] = WinerLicense
                                        }, function(rowsChanged)
                                            print("argent give a : "..accountsTable.bank.." - "..WinerLicense)
                                        end)
                                    end
                                end)
                            end
                        end
            
                        MySQL.Async.fetchAll('SELECT * FROM user_lottery WHERE identifier = @identifier', {
                            ['@identifier'] = WinerLicense
                        }, function(result3)
                            for a, c in pairs(result3) do
                                local t = os.date("*t", time)
                                local discordInfo = {
                                    ["color"] = "10181046",
                                    ["type"] = "rich",
                                    ["title"] = "**La loterie de la semaine est terminée !**",
                                    ["description"] = "Pseudo du gagnant: **"..c.nickname.."**\nLot gagné: **"..resultTable.totalMoney.."$ **\n Nombre de participations: **"..resultTable.participationCount.."**\n\n**✅ Le lot a été attribué avec succès**\n 📆 **Prochain tirage de la loterie le *"..formatExpirationDiscord(resultTable.next).."*** (dans 7 jours)",
                                    ["footer"] = {
                                    ["text"] = 'Log envoyée à '..t.hour..':'..t.min..''
                                    }
                                }
                            
                                if not check then
                                    PerformHttpRequest(extasy_sv_core_cfg["webhook_lottery"], function(err, text, headers) end, 'POST', json.encode({ username = 'LOTERIE', embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
                                    check = true
                                end
                            end
                        end)
                    end)
                end
            end)
            
            Wait(1000)
            
            local time = os.time()
            local nextTime = (time+(60*60*24*7))
            
            MySQL.Async.execute("UPDATE `lottery` SET `expireDate`= '"..nextTime.."'", {}, function() end)
            MySQL.Async.execute("UPDATE `lottery` SET `totalMoney`= '5000'", {}, function() end)
            MySQL.Async.execute("UPDATE `lottery` SET `participationCount`= '1'", {}, function() end)
            
            MySQL.Async.fetchAll("SELECT * FROM user_lottery", {}, function(result2)
                for _, b in pairs(result2) do
                    MySQL.Async.execute("DELETE FROM user_lottery WHERE identifier = @a", {
                        ["a"] = b.identifier
                    })
                end
            end)
            
            print("La table SQL user_lottery a été vidé")
        end 
    end
end)

RegisterNetEvent("lottery:getLotteryData")
AddEventHandler("lottery:getLotteryData", function(token)
    if not CheckToken(token, source, "lottery:getLotteryData") then return end
    local _src = source
    local time = os.time()
    local expireDate = lotteryTable.expireDate

    MySQL.Async.fetchAll("SELECT * FROM lottery", {}, function(result)
        for k,v in pairs(result) do
            lotteryTable = {expireDate = v.expireDate, totalMoney = v.totalMoney, participationCount = v.participationCount}
        end
    end)

    --if time > expireDate then
        --lotteryTable = nil
        --return
    --end

    TriggerClientEvent("lottery:sendLotteryData", _src, formatExpiration(lotteryTable.expireDate), lotteryTable.totalMoney, lotteryTable.participationCount)
end)

RegisterNetEvent("lottery:registerNewPlayer")
AddEventHandler("lottery:registerNewPlayer", function(token, nickname, amount)
    if not CheckToken(token, source, "lottery:registerNewPlayer") then return end
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local identifier = xPlayer.identifier
    local reelamount = amount

    MySQL.Async.fetchAll("SELECT * FROM lottery", {}, function(result)
        for k,v in pairs(result) do
            lotteryTable = {expireDate = v.expireDate, totalMoney = v.totalMoney, participationCount = v.participationCount}
        end
    end)

    MySQL.Async.insert("INSERT INTO user_lottery (identifier,nickname,amount) VALUES(@a,@b,@c)", {
        ["a"] = identifier,
        ["b"] = nickname,
        ["c"] = amount
    }, function()
        -- OK
    end)

    MySQL.Async.fetchAll("SELECT * FROM `lottery`", {}, function(result)
        for k,v in pairs(result) do
            lotteryTable2 = {expireDate = v.expireDate, totalMoney = v.totalMoney, participationCount = v.participationCount}

            local NewTotalMoney = lotteryTable2.totalMoney + tonumber(reelamount)
            local NewParticipationCount = lotteryTable2.participationCount + tonumber(1)

            MySQL.Async.execute("UPDATE `lottery` SET `totalMoney`= '"..NewTotalMoney.."'", {}, function() end)
            MySQL.Async.execute("UPDATE `lottery` SET `participationCount`= '"..NewParticipationCount.."'", {}, function() end)

            TriggerClientEvent("lottery:sendLotteryData", _src, formatExpiration(lotteryTable2.expireDate), NewTotalMoney, NewParticipationCount)
        end
    end)
end)

ESX.RegisterServerCallback('Extasy_lottery:CheckAccount', function (source, cb, price)
	TriggerEvent("ext:AST", source, "Extasy_lottery:CheckAccount")

	local xPlayer     = ESX.GetPlayerFromId(source)
		
	if xPlayer.getMoney() >= price then
		cb(true)
	elseif xPlayer.getAccount('bank').money >= price then
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('Extasy_lottery:DebitAccount', function (source, cb, price, totalPrice)
	TriggerEvent("ext:AST", source, "Extasy_lottery:DebitAccount")

	local xPlayer     = ESX.GetPlayerFromId(source)
	local vehicleData = nil
	local monnaie = 0

    TriggerClientEvent("Extasy:ShowAdvancedNotification", -1, "~g~Nouvelle Participation", "Un(e) citoyen vien de mettre ~g~+"..price.."$~s~ dans la cagnotte de la Loterie !\n\nLa cagnotte de la lottery est d'actuellement de ~y~"..Extasy.Math.GroupDigits(totalPrice, 2).."$~s~", "DIA_CUSTOMER", 9)
		
	if xPlayer.getMoney() >= price then
        xPlayer.removeMoney(price)
		cb(true)
	elseif xPlayer.getAccount('bank').money >= price then
        xPlayer.removeAccountMoney('bank', price)
		cb(true)
	else
		cb(false)
	end
end)