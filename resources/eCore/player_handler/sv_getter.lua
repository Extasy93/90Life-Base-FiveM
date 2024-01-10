pCache = {}
local PlayersData = {}
local PlayersDataInventory = {}
local foundItems = {}
ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('Extasy:spawn') 
AddEventHandler('Extasy:spawn', function()
    TriggerClientEvent("Extasy:SendToken", source, token) -- Client side

	local source = source
	local pCache = GetPlayerInfoToCache(source)

	while pCache == {} do Wait(1) end

    TriggerClientEvent('Extasy:initializeinfo', source, pCache.job, pCache.job_grade, pCache.skin, pCache.lastname, pCache.firstname, pCache.group, pCache.uniqueId, pCache.cloths, pCache.grade)
end) 

RegisterServerEvent('Extasy:sendGroupFromPlayer')
AddEventHandler('Extasy:sendGroupFromPlayer', function(token)
	if not CheckToken(token, source, "Extasy:sendGroupFromPlayer") then return end

	local _source = source
    local player
	
	for k,v in ipairs(GetPlayerIdentifiers(_source)) do
		if string.match(v, 'license:') then
			player = v
		end
	end

    while player == nil do Wait(1) end

	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier',
      {
        ['@identifier'] = player
      },
      function(result)
		for _,v in pairs(result) do
			TriggerClientEvent("Extasy:sendGroupData", _source, result[1].group)
        end
    end)
end)

RegisterServerEvent('Extasy:sendAllMasksFromPlayer')
AddEventHandler('Extasy:sendAllMasksFromPlayer', function(token)
	if not CheckToken(token, source, "Extasy:sendAllMasksFromPlayer") then return end

	local _source = source
    local FinalResult = {}
    local player
	
	for k,v in ipairs(GetPlayerIdentifiers(_source)) do
		if string.match(v, 'license:') then
			player = v
		end
	end

    while player == nil do Wait(1) end

	MySQL.Async.fetchAll('SELECT * FROM player_masks WHERE identifier = @identifier',
      {
        ['@identifier'] = player
      },
      function(result)
		for _,v in pairs(result) do
			d = json.decode(v.data)
            table.insert(FinalResult, {
				id   	 	= v.id,
				identifier  = v.identifier,
				data      	= d,
				label   	= v.label
            })
			TriggerClientEvent("Extasy:sendMasksData", _source, FinalResult)
        end
    end)
end)

RegisterServerEvent('Extasy:sendAllClothesFromPlayer')
AddEventHandler('Extasy:sendAllClothesFromPlayer', function(token)
	if not CheckToken(token, source, "Extasy:sendAllClothesFromPlayer") then return end

	local _source = source
    local FinalResult = {}
    local player
	
	for k,v in ipairs(GetPlayerIdentifiers(_source)) do
		if string.match(v, 'license:') then
			player = v
		end
	end

    while player == nil do Wait(1) end

	MySQL.Async.fetchAll('SELECT * FROM player_clothes WHERE identifier = @identifier',
      {
        ['@identifier'] = player
      },
      function(result)
		for _,v in pairs(result) do
			d = json.decode(v.data)
            table.insert(FinalResult, {
				id   	 	= v.id,
				identifier  = v.identifier,
				data      	= d,
				label   	= v.label
            })
			TriggerClientEvent("Extasy:sendClothesData", _source, FinalResult)
        end
    end)
end)

RegisterServerEvent('Extasy:getPlayerIdentity')
AddEventHandler('Extasy:getPlayerIdentity', function(token)
	if not CheckToken(token, source, "Extasy:getPlayerIdentity") then return end

	local _source = source
    local MyIdentityData = {}
    local player
	
	for k,v in ipairs(GetPlayerIdentifiers(_source)) do
		if string.match(v, 'license:') then
			player = v
		end
	end

    while player == nil do Wait(1) end

    MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = player}, function(result)
        for _, v in pairs(result) do
            MyIdentityData = {
				prenom   = v.firstname,
				nom      = v.lastname,
				age      = v.age,
				sexe     = v.sex,
				taille   = v.height,
			}
        end
		TriggerClientEvent("Extasy:sendIdentityData", _source, MyIdentityData)
    end)
end)

RegisterNetEvent("Extasy:deleteEntity")
AddEventHandler("Extasy:deleteEntity", function(token, list)
    if not CheckToken(token, source, "Extasy:deleteEntity") then return end
    local entity = NetworkGetEntityFromNetworkId(list)
    Citizen.InvokeNative(`DELETE_ENTITY` & 0xFFFFFFFF, entity)
end) 

RegisterServerEvent('Extasy:GetPlayerInventory')
AddEventHandler('Extasy:GetPlayerInventory', function(token)
	if not CheckToken(token, source, "Extasy:GetPlayerInventory") then return end
    local weight = 0

    TriggerClientEvent('Extasy:SendPlayerInventory', source, PlayersData[source].inventory, weight)
end)

RegisterServerEvent('Extasy:GetOtherPlayerInventory')
AddEventHandler('Extasy:GetOtherPlayerInventory', function(token, target)
	if not CheckToken(token, source, "Extasy:GetOtherPlayerInventory") then return end

    local weight = 0
    TriggerClientEvent('Extasy:SendOtherPlayerInventory', source, PlayersData[target].inventory, weight)
    TriggerClientEvent("Extasy:ShowNotification", target, "Quelqu'un te fouille ...")
end)

RegisterServerEvent('identity:showToPlayer')
AddEventHandler('identity:showToPlayer', function(token, player, playerShowIdentity)
	if not CheckToken(token, source, "identity:showToPlayer") then return end

    TriggerClientEvent('Extasy:ShowAdvancedNotification', player, "Carte d'identité", "Préfecture", "~p~Prénom: ~s~"..playerShowIdentity.prenom.."\n~p~Nom: ~s~"..playerShowIdentity.nom.."\n~p~Âge: ~s~"..playerShowIdentity.age.."\n~p~Taille: ~s~"..playerShowIdentity.taille.."\n~p~Sexe: ~s~"..playerShowIdentity.sexe, "CHAR_PREF")
end)

RegisterServerEvent('car_licence:showToPlayer')
AddEventHandler('car_licence:showToPlayer', function(token, player, playerShowIdentity)
	if not CheckToken(token, source, "car_licence:showToPlayer") then return end

    TriggerClientEvent('Extasy:ShowAdvancedNotification', player, "Permis de conduire (voiture)", "Préfecture", "~p~Prénom: ~s~"..playerShowIdentity.prenom.."\n~p~Nom: ~s~"..playerShowIdentity.nom.."\n~p~Âge: ~s~"..playerShowIdentity.age, "CHAR_PREF")
end)

RegisterServerEvent('bike_licence:showToPlayer')
AddEventHandler('bike_licence:showToPlayer', function(token, player, playerShowIdentity)
	if not CheckToken(token, source, "bike_licence:showToPlayer") then return end

    TriggerClientEvent('Extasy:ShowAdvancedNotification', player, "Permis de conduire (moto)", "Préfecture", "~p~Prénom: ~s~"..playerShowIdentity.prenom.."\n~p~Nom: ~s~"..playerShowIdentity.nom.."\n~p~Âge: ~s~"..playerShowIdentity.age, "CHAR_PREF")
end)

RegisterServerEvent('truck_licence:showToPlayer')
AddEventHandler('truck_licence:showToPlayer', function(token, player, playerShowIdentity)
	if not CheckToken(token, source, "truck_licence:showToPlayer") then return end

    TriggerClientEvent('Extasy:ShowAdvancedNotification', player, "Permis de conduire (camion)", "Préfecture", "~p~Prénom: ~s~"..playerShowIdentity.prenom.."\n~p~Nom: ~s~"..playerShowIdentity.nom.."\n~p~Âge: ~s~"..playerShowIdentity.age, "CHAR_PREF")
end)

RegisterServerEvent('boat_licence:showToPlayer')
AddEventHandler('boat_licence:showToPlayer', function(token, player, playerShowIdentity)
	if not CheckToken(token, source, "boat_licence:showToPlayer") then return end

    TriggerClientEvent('Extasy:ShowAdvancedNotification', player, "Permis de conduire (bateau)", "Préfecture", "~p~Prénom: ~s~"..playerShowIdentity.prenom.."\n~p~Nom: ~s~"..playerShowIdentity.nom.."\n~p~Âge: ~s~"..playerShowIdentity.age, "CHAR_PREF")
end)

RegisterServerEvent('license_ppa:showToPlayer')
AddEventHandler('license_ppa:showToPlayer', function(token, player, playerShowIdentity)
	if not CheckToken(token, source, "license_ppa:showToPlayer") then return end

    TriggerClientEvent('Extasy:ShowAdvancedNotification', player, "Permis port d'arme", "Préfecture", "~p~Prénom: ~s~"..playerShowIdentity.prenom.."\n~p~Nom: ~s~"..playerShowIdentity.nom.."\n~p~Âge: ~s~"..playerShowIdentity.age, "CHAR_PREF")
end)

RegisterNetEvent("Extasy:RemoveItem")
AddEventHandler("Extasy:RemoveItem", function(token, item, count)
    if not CheckToken(token, source, "license_ppa:showToPlayer") then return end
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(item, count)
end)

local second = 1000
local minute = 60*second
Citizen.CreateThread(function()
    while true do
        SaveDynamicCache()
        Wait(1.5*minute)
    end
end)

SaveDynamicCache = function()
    local loop = 0
    for k,v in pairs(PlayersData) do
        loop = loop + 1
        if GetPlayerPing(v.ServerID) == 0 then -- Si 0, cela signifie que le joueur n'est plus connecté
            if extasy_sv_core_cfg["display_debug"] then
                print("^1Removing ^7"..v.ServerID.." - "..loop.." from dynamic cache.")
            end
            PlayersData[v.ServerID] = nil
        else
            --SavePlayerCache(v.identifier, v)
            Wait(500)
        end
    end
end

-- Call this on player connexion
GetPlayerInfoToCache = function(id)

    local player
	
	for k,v in ipairs(GetPlayerIdentifiers(id)) do
		if string.match(v, 'license:') then
			player = v
		end
	end
  
    PlayersData[id] = {ServerID = id}
    PlayersDataInventory[id] = {ServerID = id}

    while player == nil do Wait(1) end

    local info = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
        ['@identifier'] = player
    })

	local info2 = MySQL.Sync.fetchAll("SELECT * FROM user_tenue WHERE identifier = @identifier", {
        ['@identifier'] = player
    })

    while info == nil do Wait(1) end
    while info2 == nil do Wait(1) end
    while info[1].boutique_id == nil do Wait(1) end

    Wait(10)

    PlayersData[id].uniqueId 	    = info[1].boutique_id
    PlayersData[id].ServerID 		= id
    PlayersData[id].identifier  	= player

    PlayersData[id].deadOrNot 		= info[1].is_dead
    PlayersData[id].job 			= info[1].job
    PlayersData[id].job_grade 		= info[1].job_grade
    PlayersData[id].group 			= info[1].group
    PlayersData[id].skin 			= info[1].skin
    PlayersData[id].grade  	        = info[1].grade

    if info[1].firstname ~= nil then
        PlayersData[id].firstname = info[1].firstname
    else
        PlayersData[id].firstname = "n/a"
    end

    if info[1].lastname ~= nil then
        PlayersData[id].lastname = info[1].lastname
    else
        PlayersData[id].lastname = "n/a"
    end

    --PlayersData[id].money = info[1].player_money
    --PlayersData[id].bankBalance = info[1].player_bank_balance
    --PlayersData[id].dirtyMoney = info[1].player_dirty_money

    --[[if info[1].vip ~= 0 then
        local status = CheckVipStatus(info[1].vip_time, player)
        if status then
            PlayersData[id].vip = info[1].vip 
        else
            PlayersData[id].vip = 0
        end
    else
        PlayersData[id].vip = 0
    end--]]

    -- INV BUG !!!!

    --[[MySQL.Async.fetchAll('SELECT * FROM items', {}, function(result)
        for k,v in ipairs(result) do
            Items[v.name] = {
                label = v.label,
                weight = v.weight,
                rare = v.rare,
                limit = v.limit,
                canRemove = v.can_remove
            }
        end
    end)

    while Items == nil do Wait(10) end

    if info[1].inventory ~= nil then
        for name, count in pairs(json.decode(info[1].inventory)) do
            local item = Items[name]
    
            if item then
                foundItems[name] = count
            else
                print(('[eCore / InitializeInfo] [^3WARNING^7] Ignorer un item non valable "%s" pour "%s"'):format(name, player))
            end
        end
    else
        PlayersData[id].inventory = {}
    end

    for name, v in pairs(Items) do
        local count = foundItems[name] or 0

        if count > 0 then
            table.insert(PlayersDataInventory[id], {
                name = name,
                count = count,
                label = v.label,
                weight = v.weight,
                limit = v.limit,
                rare = v.rare,
                canRemove = v.canRemove
            })
            PlayersData[id].inventory = PlayersDataInventory[id]
            print("1: "..PlayersDataInventory[id].label)
            print("2: "..PlayersData[id].inventory.label)
        end
    end

    table.sort(PlayersData[id].inventory, function(a, b)
        return a.label < b.label
    end)

    print("player ID: "..id)
    print("Player inventory label: "..PlayersData[id].inventory.label)
    print("Player inventory name: "..PlayersData[id].inventory.name)
    print("Player inventory count: "..PlayersData[id].inventory.count)--]]

    if info[1].tenue ~= nil then
        PlayersData[id].cloths = json.decode(info2[1].tenue)
    else
        PlayersData[id].cloths = {}
    end

    if info[1].firstname ~= nil then
        PlayersData[id].firstname = info[1].firstname
    else
        PlayersData[id].firstname = {}
    end

    if extasy_sv_core_cfg["display_debug"] then
        print("^2Adding ^7["..id.."] "..GetPlayerName(id).." to dynamic cache.")
    end

    local ids = GetPlayerIdentifiers(id)
    local msg = ""
    for k,v in pairs(ids) do
        msg = msg..v.."\n"
    end

    Citizen.CreateThread(function()
        if PlayersData[id].lastname ~= nil and PlayersData[id].firstname ~= nil then
            SendLog("**Connexion au serveur**```\nPseudo: "..GetPlayerName(id).."\nID UNIQUE: ["..PlayersData[id].uniqueId.."]\nRP NAME: "..PlayersData[id].lastname.." "..PlayersData[id].firstname.."\nJob: "..PlayersData[id].job.."\nIds:\n"..msg.."```", "connexion-extra")
        end
    end)
    return PlayersData[id]
end

CheckVipStatus = function(time, id)
    if tonumber(time) < os.time() then
        MySQL.Async.execute("UPDATE users SET vip = @vip, vip_time = @vip WHERE identifier = @identifier", {
            ['@identifier'] = id,
            ['@vip'] = 0,
        })
        return false
    end

    return true
end

GetPlayerCache = function(id)
    return PlayersData[id]
end