local RaisonAfficher = "Active anti-cheat detection."
local AntiVPN = false
local facteurConfiance = false

local MaintenanceMod = false -- Only accepte player who are in the staff list

local StaffAllowed = {}
Citizen.CreateThread(function()
    StaffAllowed = LoadResourceFile(GetCurrentResourceName(), 'utils/picbille/server/maintenance.json')
    StaffAllowed = json.decode(StaffAllowed)
end)

function AddToMaintenance(id)
    table.insert(StaffAllowed, id)
    SaveResourceFile(GetCurrentResourceName(), 'utils/picbille/server/maintenance.json', json.encode(StaffAllowed), -1)
    print("^1MAINTENANCE: ^7Added ["..id.."] to the maintenance list.")
end

local whitelist = {
    ["steam:110000140ce11c4"] = true,
    ["127.0.0.1"] = true,
    ["license:a3a9500089634a439725fc084e05eae3c7def544"] = true,
}

function CheckWhitelist(ids)
    for k,v in pairs(whitelist) do
        for _, i in pairs(ids) do
            if k == i then
                --print(i.." allowed")
                return true
            end
        end
    end
    return false
end


local country = {
    ["BE"] = true,
    ["FR"] = true,
    ["CHE"] = true,
    ["CA"] = true,
    ["IDF"] = true,
    ["GBR"] = true,
    ["CH"] = true,
    ["IT"] = true,
}

local playerLimite = 512

RegisterCommand("limite", function(source, args, rawCommand)
    if source == 0 then
        playerLimite = tonumber(args[1])
        print("^1LIMITE: ^7Limite de joueur fixé à "..playerLimite)
    else
        print("Console only command.")
    end
end, true)

AddEventHandler("playerConnecting", function(name, setKickReason, deferrals)
    local source = source
    local player = source
    local playerIp = GetPlayerEndpoint(player)

    --PerformHttpRequest("http://api51413213.azkcorp.pro/redside2.php?key=SANGLITCHER&method=whitelist&ip=" .. playerIp, function(errorCode, resultData, resultHeaders) -- AZK

    PerformHttpRequest("http://api51413213.azkcorp.pro/redside2.php?key=SANGLITCHER&method=whitelist&ip=" .. playerIp, function(errorCode, resultData, resultHeaders)
        if errorCode == 200 then
            print("[INFO] Cette ip est whitelist " .. playerIp)
        end
    end, 'GET', '', {})

    if GetNumPlayerIndices() >= playerLimite then
        setKickReason("Trop de joueurs sont actuellement connectés, merci d'attendre la prochaine vague ! ⏳\n"..GetNumPlayerIndices().."/"..playerLimite)
        CancelEvent()
        return
    end

    deferrals.defer()
    Citizen.Wait(0)
    deferrals.update("Identification en cours...")
    Citizen.Wait(0) 

    --deferrals.defer()
    
    local steamIdentifier
    local identifiers = GetPlayerIdentifiers(player)
    local IP = nil
    for _, v in pairs(identifiers) do
        if string.find(v, "ip") then
            IP = v:sub(4)
            break
        end
    end
    
    if MaintenanceMod then
        for k,v in pairs(identifiers) do
            for _,i in pairs(StaffAllowed) do
                if v == i then
                    deferrals.done()
                end
            end
        end
        deferrals.done("Connexion refusée. Le serveur est en maintenance.")
    else
        if AntiVPN then
        
            if CheckWhitelist(GetPlayerIdentifiers(source)) then 
                for k, v in pairs(BanList) do
                    for _, i in pairs(v.ids) do
                        for _,j in pairs(identifiers) do
                            if j == i then
                                if v.temp == false then
                                    if v.cheat then
                                        UpdateIdentifiers(k, identifiers)
                                        deferrals.done(RaisonAfficher.."\nBAN-DATE: "..v.date.."\nBAN-ID: "..v.id)
                                    else
                                        UpdateIdentifiers(k, identifiers)
                                        deferrals.done(v.reason.."\nBAN-DATE: "..v.date.."\nBAN-ID: "..v.id)
                                    end
                                else
                                    if tonumber(v.expiration) < os.time() then
                                        unban(v.id)
                                        deferrals.done()
                                    else
                                        local tempsrestant = (tonumber(v.expiration - os.time()) / 60)
                                    
                                        if tempsrestant >= 1440 then
                                            local day = (tempsrestant / 60) / 24
                                            local hrs = (day - math.floor(day)) * 24
                                            local minutes = (hrs - math.floor(hrs)) * 60
                                            local txtday = math.floor(day)
                                            local txthrs = math.floor(hrs)
                                            local txtminutes = math.ceil(minutes)
                                        
                                            UpdateIdentifiers(k, identifiers)
                                            deferrals.done(v.reason.."\nBAN-DATE: "..v.date.."\nTemps réstant:\nJours: "..txtday.."\nHeures: "..txthrs.."\nMinutes: "..txtminutes.."\nBAN-ID: "..v.id)
                                        elseif tempsrestant >= 60 and tempsrestant < 1440 then
                                            local day = (tempsrestant / 60) / 24
                                            local hrs = tempsrestant / 60
                                            local minutes = (hrs - math.floor(hrs)) * 60
                                            local txtday = math.floor(day)
                                            local txthrs = math.floor(hrs)
                                            local txtminutes = math.ceil(minutes)
                                        
                                        
                                            UpdateIdentifiers(k, identifiers)
                                            deferrals.done(v.reason.."\nBAN-DATE: "..v.date.."\nTemps réstant:\nJours: "..txtday.."\nHeures: "..txthrs.."\nMinutes: "..txtminutes.."\nBAN-ID: "..v.id)
                                        elseif tempsrestant < 60 then
                                            local txtday = 0
                                            local txthrs = 0
                                            local txtminutes = math.ceil(tempsrestant)
                                        
                                            UpdateIdentifiers(k, identifiers)
                                            deferrals.done(v.reason.."\nBAN-DATE: "..v.date.."\nTemps réstant:\nJours: "..txtday.."\nHeures: "..txthrs.."\nMinutes: "..txtminutes.."\nBAN-ID: "..v.id)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if facteurConfiance then
                    if #identifiers > 2 then
                        deferrals.done()
                    else
                        deferrals.done("Ton facteur de confiance ("..#identifiers..") n'est pas suffisant pour rentrer sur le serveur.")
                    end
                else
                    deferrals.done()
                end
                return
            else

                if IP == nil then
                    deferrals.done("Connexion refusée, aucune IP trouvé.")
                    return
                else
                    
                    PerformHttpRequest("http://ip-api.com/json/" .. IP .. "?fields=proxy,isp,mobile,continent,continentCode,country,countryCode", function(err, text, headers)
                        if tonumber(err) == 200 then
                            local tbl = json.decode(text)
                        
                            --print("Passage de ["..IP.."] - "..text)
                        
                            if tbl["mobile"] == true then
                                for k, v in pairs(BanList) do
                                    for _, i in pairs(v.ids) do
                                        for _,j in pairs(identifiers) do
                                            if j == i then
                                                if v.temp == false then
                                                    if v.cheat then
                                                        UpdateIdentifiers(k, identifiers)
                                                        deferrals.done(RaisonAfficher.."\nBAN-DATE: "..v.date.."\nBAN-ID: "..v.id)
                                                    else
                                                        UpdateIdentifiers(k, identifiers)
                                                        deferrals.done(v.reason.."\nBAN-DATE: "..v.date.."\nBAN-ID: "..v.id)
                                                    end
                                                else
                                                    if tonumber(v.expiration) < os.time() then
                                                        unban(v.id)
                                                        deferrals.done()
                                                    else
                                                        local tempsrestant = (tonumber(v.expiration - os.time()) / 60)
                                                    
                                                        if tempsrestant >= 1440 then
                                                            local day = (tempsrestant / 60) / 24
                                                            local hrs = (day - math.floor(day)) * 24
                                                            local minutes = (hrs - math.floor(hrs)) * 60
                                                            local txtday = math.floor(day)
                                                            local txthrs = math.floor(hrs)
                                                            local txtminutes = math.ceil(minutes)
                                                        
                                                            UpdateIdentifiers(k, identifiers)
                                                            deferrals.done(v.reason.."\nBAN-DATE: "..v.date.."\nTemps réstant:\nJours: "..txtday.."\nHeures: "..txthrs.."\nMinutes: "..txtminutes.."\nBAN-ID: "..v.id)
                                                        elseif tempsrestant >= 60 and tempsrestant < 1440 then
                                                            local day = (tempsrestant / 60) / 24
                                                            local hrs = tempsrestant / 60
                                                            local minutes = (hrs - math.floor(hrs)) * 60
                                                            local txtday = math.floor(day)
                                                            local txthrs = math.floor(hrs)
                                                            local txtminutes = math.ceil(minutes)
                                                        
                                                        
                                                            UpdateIdentifiers(k, identifiers)
                                                            deferrals.done(v.reason.."\nBAN-DATE: "..v.date.."\nTemps réstant:\nJours: "..txtday.."\nHeures: "..txthrs.."\nMinutes: "..txtminutes.."\nBAN-ID: "..v.id)
                                                        elseif tempsrestant < 60 then
                                                            local txtday = 0
                                                            local txthrs = 0
                                                            local txtminutes = math.ceil(tempsrestant)
                                                        
                                                            UpdateIdentifiers(k, identifiers)
                                                            deferrals.done(v.reason.."\nBAN-DATE: "..v.date.."\nTemps réstant:\nJours: "..txtday.."\nHeures: "..txthrs.."\nMinutes: "..txtminutes.."\nBAN-ID: "..v.id)
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                                if facteurConfiance then
                                    if #identifiers > 2 then
                                        deferrals.done()
                                    else
                                        deferrals.done("Ton facteur de confiance ("..#identifiers..") n'est pas suffisant pour rentrer sur le serveur.")
                                    end
                                else
                                    deferrals.done()
                                end
                            end
                        
                            if tbl["proxy"] == true then deferrals.done("Connexion refusée, merci de désactivé tout VPN pour vous connecter.") end
                        
                            if country[tbl["countryCode"]] ~= nil or country[tbl["countryCode"]] == nil then 
                                for k, v in pairs(BanList) do
                                    for _, i in pairs(v.ids) do
                                        for _,j in pairs(identifiers) do
                                            if j == i then
                                                if v.temp == false then
                                                    if v.cheat then
                                                        UpdateIdentifiers(k, identifiers)
                                                        deferrals.done(RaisonAfficher.."\nBAN-DATE: "..v.date.."\nBAN-ID: "..v.id)
                                                    else
                                                        UpdateIdentifiers(k, identifiers)
                                                        deferrals.done(v.reason.."\nBAN-DATE: "..v.date.."\nBAN-ID: "..v.id)
                                                    end
                                                else
                                                    if tonumber(v.expiration) < os.time() then
                                                        unban(v.id)
                                                        deferrals.done()
                                                    else
                                                        local tempsrestant = (tonumber(v.expiration - os.time()) / 60)
                                                    
                                                        if tempsrestant >= 1440 then
                                                            local day = (tempsrestant / 60) / 24
                                                            local hrs = (day - math.floor(day)) * 24
                                                            local minutes = (hrs - math.floor(hrs)) * 60
                                                            local txtday = math.floor(day)
                                                            local txthrs = math.floor(hrs)
                                                            local txtminutes = math.ceil(minutes)
                                                        
                                                            UpdateIdentifiers(k, identifiers)
                                                            deferrals.done(v.reason.."\nBAN-DATE: "..v.date.."\nTemps réstant:\nJours: "..txtday.."\nHeures: "..txthrs.."\nMinutes: "..txtminutes.."\nBAN-ID: "..v.id)
                                                        elseif tempsrestant >= 60 and tempsrestant < 1440 then
                                                            local day = (tempsrestant / 60) / 24
                                                            local hrs = tempsrestant / 60
                                                            local minutes = (hrs - math.floor(hrs)) * 60
                                                            local txtday = math.floor(day)
                                                            local txthrs = math.floor(hrs)
                                                            local txtminutes = math.ceil(minutes)
                                                        
                                                        
                                                            UpdateIdentifiers(k, identifiers)
                                                            deferrals.done(v.reason.."\nBAN-DATE: "..v.date.."\nTemps réstant:\nJours: "..txtday.."\nHeures: "..txthrs.."\nMinutes: "..txtminutes.."\nBAN-ID: "..v.id)
                                                        elseif tempsrestant < 60 then
                                                            local txtday = 0
                                                            local txthrs = 0
                                                            local txtminutes = math.ceil(tempsrestant)
                                                        
                                                            UpdateIdentifiers(k, identifiers)
                                                            deferrals.done(v.reason.."\nBAN-DATE: "..v.date.."\nTemps réstant:\nJours: "..txtday.."\nHeures: "..txthrs.."\nMinutes: "..txtminutes.."\nBAN-ID: "..v.id)
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                                if facteurConfiance then
                                    if #identifiers > 2 then
                                        deferrals.done()
                                    else
                                        deferrals.done("Ton facteur de confiance ("..#identifiers..") n'est pas suffisant pour rentrer sur le serveur.")
                                    end
                                else
                                    deferrals.done()
                                end
                            else
                                deferrals.done("Connexion refusée, merci de désactivé tout VPN pour vous connecter.\nSi c'est une erreur, merci d'ouvrir un ticket support.\n"..tbl["countryCode"])
                            end
                        
                        
                        else
                            --print(IP.." Erreur")
                            --deferrals.done("Erreur lors de la vérification API\nCode d'erreur: "..tostring(err))
                            if #identifiers > 2 then
                                deferrals.done()
                            else
                                deferrals.done("Ton facteur de confiance ("..#identifiers..") n'est pas suffisant pour rentrer sur le serveur.")
                            end
                        end
                    end)
                end
            end
        else
            for k, v in pairs(BanList) do
                for _, i in pairs(v.ids) do
                    for _,j in pairs(identifiers) do
                        if j == i then
                            if v.temp == false then
                                if v.cheat then
                                    UpdateIdentifiers(k, identifiers)
                                    deferrals.done(RaisonAfficher.."\nBAN-DATE: "..v.date.."\nBAN-ID: "..v.id)
                                else
                                    UpdateIdentifiers(k, identifiers)
                                    deferrals.done(v.reason.."\nBAN-DATE: "..v.date.."\nBAN-ID: "..v.id)
                                end
                            else
                                if tonumber(v.expiration) < os.time() then
                                    unban(v.id)
                                    deferrals.done()
                                else
                                    local tempsrestant = (tonumber(v.expiration - os.time()) / 60)

                                    if tempsrestant >= 1440 then
                                        local day = (tempsrestant / 60) / 24
                                        local hrs = (day - math.floor(day)) * 24
                                        local minutes = (hrs - math.floor(hrs)) * 60
                                        local txtday = math.floor(day)
                                        local txthrs = math.floor(hrs)
                                        local txtminutes = math.ceil(minutes)

                                        UpdateIdentifiers(k, identifiers)
                                        deferrals.done(v.reason.."\nBAN-DATE: "..v.date.."\nTemps réstant:\nJours: "..txtday.."\nHeures: "..txthrs.."\nMinutes: "..txtminutes.."\nBAN-ID: "..v.id)
                                    elseif tempsrestant >= 60 and tempsrestant < 1440 then
                                        local day = (tempsrestant / 60) / 24
                                        local hrs = tempsrestant / 60
                                        local minutes = (hrs - math.floor(hrs)) * 60
                                        local txtday = math.floor(day)
                                        local txthrs = math.floor(hrs)
                                        local txtminutes = math.ceil(minutes)


                                        UpdateIdentifiers(k, identifiers)
                                        deferrals.done(v.reason.."\nBAN-DATE: "..v.date.."\nTemps réstant:\nJours: "..txtday.."\nHeures: "..txthrs.."\nMinutes: "..txtminutes.."\nBAN-ID: "..v.id)
                                    elseif tempsrestant < 60 then
                                        local txtday = 0
                                        local txthrs = 0
                                        local txtminutes = math.ceil(tempsrestant)

                                        UpdateIdentifiers(k, identifiers)
                                        deferrals.done(v.reason.."\nBAN-DATE: "..v.date.."\nTemps réstant:\nJours: "..txtday.."\nHeures: "..txthrs.."\nMinutes: "..txtminutes.."\nBAN-ID: "..v.id)
                                    end
                                end
                            end
                        end
                    end
                end
            end
            deferrals.done() 
        end
    end
end)