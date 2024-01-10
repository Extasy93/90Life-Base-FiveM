RegisterCommand("acofflineban", function(source, args, rawCommand)
    if source == 0 then
        if args[1] ~= nil then
            acofflineban(args[1])
        else
            print("Aucun id spécifié.")
        end
    else
        print("Console only command.")
    end
end, true)

RegisterCommand("maintenance", function(source, args, rawCommand)
    if source == 0 then
        if args[1] ~= nil then
            AddToMaintenance(args[1])
        end
    end 
end, true)


RegisterCommand("kickall", function(source, args, rawCommand)
    if source == 0 then
        local players = GetPlayers()
        local count = 0
        print("^2Ready ^7to kick "..#players.." players !")
        for k,v in pairs(players) do
            Wait(150)
            count = count + 1
            print("^2Kicked ^7#"..count)
            DropPlayer(v, "Restart du serveur en cours, merci d'attendre une annonce pour te reconnecter pour éviter toute corruption de personnage.")
        end
    end
end, true)


RegisterNetEvent("eCore:BanPlayer")
AddEventHandler("eCore:BanPlayer", function(token, target, duree, reason)
    if CheckToken(token, source, "eCore:BanPlayer") then
        local target = tonumber(target)
        local duree = tonumber(duree)

        if duree == 0 then
            BanPlayer(target, reason, source)
        else
            TempBanPlayer(target, reason, duree, source)
        end
    end
end)


RegisterNetEvent("eCore:KickPlayer")
AddEventHandler("eCore:KickPlayer", function(token, target, reason)
    local source = source
    print(PlayersData[source].group)
    if CheckToken(token, source, "eCore:BanPlayer") then
        if PlayersData[source].group ~= "user" then
            DropPlayer(target, reason)
        end
    end
end)