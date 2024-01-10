ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("Identity:updateFirstname")
AddEventHandler("Identity:updateFirstname", function(token, nameInput)
    if not CheckToken(token, source, "Identity:updateFirstname") then return end

    local player

    for k,v in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(v, 'license:') then
			player = v
		end
	end

    while player == nil do Wait(1) end

	MySQL.Async.execute("UPDATE users SET firstname=@nameInput WHERE identifier=@identifier", {
        ['@identifier'] = player,
        ['@nameInput'] = tostring(nameInput)
    })
end)

RegisterServerEvent("Identity:updateLastname")
AddEventHandler("Identity:updateLastname", function(token, prenomInput)
    if not CheckToken(token, source, "Identity:updateLastname") then return end

    local player

    for k,v in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(v, 'license:') then
			player = v
		end
	end

    while player == nil do Wait(1) end

	MySQL.Async.execute("UPDATE users SET lastname=@prenomInput WHERE identifier=@identifier", {
        ['@identifier'] = player,
        ['@prenomInput'] = tostring(prenomInput)
    })
end)

RegisterServerEvent("Identity:updateHeight")
AddEventHandler("Identity:updateHeight", function(token, tailleInput)
    if not CheckToken(token, source, "Identity:updateHeight") then return end

    local player

    for k,v in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(v, 'license:') then
			player = v
		end
	end

    while player == nil do Wait(1) end

	MySQL.Async.execute("UPDATE users SET height=@tailleInput WHERE identifier=@identifier", {
        ['@identifier'] = player,
        ['@tailleInput'] = tostring(tailleInput)
    })
end)

RegisterServerEvent("Identity:updateSex")
AddEventHandler("Identity:updateSex", function(token, sexInput)
    if not CheckToken(token, source, "Identity:updateSex") then return end

    local player

    for k,v in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(v, 'license:') then
			player = v
		end
	end

    while player == nil do Wait(1) end

    MySQL.Async.execute("UPDATE users SET sex=@sexInput WHERE identifier=@identifier", {
        ['@identifier'] = player,
        ['@sexInput'] = tostring(sexInput)
    })
end)

RegisterServerEvent("Identity:updateAge")
AddEventHandler("Identity:updateAge", function(token, ageInput)
    if not CheckToken(token, source, "Identity:updateAge") then return end

    local player

    for k,v in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(v, 'license:') then
			player = v
		end
	end

    while player == nil do Wait(1) end

	MySQL.Async.execute("UPDATE users SET age=@ageInput WHERE identifier=@identifier", {
        ['@identifier'] = player,
        ['@ageInput'] = tostring(ageInput)
    })
end)

RegisterServerEvent("Extasy:setPlayerToBucket")
AddEventHandler("Extasy:setPlayerToBucket", function(token, id)
    if not CheckToken(token, source, "Extasy:setPlayerToBucket") then return end
    SetPlayerRoutingBucket(source, id)
end)

RegisterServerEvent("Extasy:setPlayerToNormalBucket")
AddEventHandler("Extasy:setPlayerToNormalBucket", function(token)
    if not CheckToken(token, source, "Extasy:setPlayerToNormalBucket") then return end
    SetPlayerRoutingBucket(source, 0)
end)

