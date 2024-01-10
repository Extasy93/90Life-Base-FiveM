

GetRandomHeartLogin = function()
	local hearts = {"❤", "🧡", "💛", "💚", "💙", "💜", "🤎", "🤍", "❣", "💕", "💞", "💓", "💗", "💖", "💘", "💝", "💟"}

	return hearts[math.random(1, #hearts)]
end

RegisterCommand("maintenance", function(source, args, rawCommand)
    if extasy_sv_core_cfg["maintenance_mode"] then
        print("~g~Vous avez désactivé le mod maintenance")
        extasy_sv_core_cfg["maintenance_mode"] = false
    else
        print("~g~Vous avez activé le mod maintenance")
        extasy_sv_core_cfg["maintenance_mode"] = true
    end
end, true)

AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
    local _source = source
    local playerIp = GetPlayerEndpoint(_source) or "n/a"
    local identifiers = GetPlayerIdentifiers(_source)
    local license = nil

    for _, v in pairs(identifiers) do
        if string.find(v, "license:") then
            license = v:sub(1)
            break
        end
    end

    --os.execute("ipset add wlip " .. ip)
    --print("[WhiteList IP] ^7- ".. GetPlayerName(source) .." Connecté^0 - WITHELIST IP : " .. ip)
	print("[^2Connexion^7] ^7- ".. GetPlayerName(source))

    if extasy_sv_core_cfg["maintenance_mode"] then
        if not isWhiteListedOnMaintenance(license) then
            deferrals.done("🔒 Soit patient ! Le serveur est en maintenance.\n🔊 Rdv sur Discord : http://discord.gg/90Life")
            print(GetPlayerName(source).." - ("..license..") - ^1éjecter pendant la maintenance.^7")
            CancelEvent()
        end
    end

    -- Non whitelist ? ciao
	if not isWhiteListed(license) then
		deferrals.done("\n🔒 Vous n'êtes pas sur la WHITE-LIST de 90's Life\n🔊 Rejoindre le Discord : http://discord.gg/90Life\n🔰 Votre Identifiant : " ..license.. " (Ctrl + C l'identifiant)")
		print(license.." - ^1Kick car non whitelist.^7")
		CancelEvent()
	end

    --if playerIp ~= "n/a" then
		--local url = "http://Extasy.fr/wl.php?ip=" .. playerIp -- l'api

		--os.exectute('iptables -A INPUT -s '..playerIp..' -j ACCEPT')
    		--print("^2[INFO] ^0Cette ip est Whitelist " .. playerIp)
		--end)
	--else
		--reject("Error on detection IP , Contact an Administrator on Discord : discord.gg/serveurdeextasy")
		--CancelEvent()
		--return
	--end
end)


AddEventHandler('playerDropped', function (reason)
    --os.execute("ipset del wlip " .. ip)
    --print("[WhiteList IP] ^7- ".. GetPlayerName(source) .." Déconnecté^0 - UN WITHELIST IP : " .. ip)
	print("[^1Déconnexion^7] ^7- ".. GetPlayerName(_source))
    SendLog("```diff\n- ["..source.."] "..GetPlayerName(source).." raison: "..reason.."```", "connexion")
end)

isWhiteListed = function(identifier)
	local result = MySQL.Sync.fetchScalar("SELECT whitelisted FROM user_whitelist WHERE identifier = @username AND whitelisted = 1", {['@username'] = identifier})
	if result then
		return true
	end
	return false
end

isWhiteListedOnMaintenance = function(license)
	if license == "license:9e7cc954c007aca1def453f39bbed1b82f63c7b5" then -- Extasy
		return true
    elseif license == "" then -- Trisoxx
        return true
    elseif license == "" then -- WiLLisMath
        return true
    elseif license == "license:6fdda5a8e378e2c85c5b5d9daa13a8ebf2df9ecd" then -- Sam85
        return true
    elseif license == "" then -- Kannoo
        return true
    end
	return false
end