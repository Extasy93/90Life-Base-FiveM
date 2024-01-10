
local ESX = nil
local AppelsEnCours = {}
local PhoneFixeInfo = {}
local lastIndexCall = 10

TriggerEvent('ext:getSharedObject', function(obj) 
    ESX = obj 
end)

RegisterServerEvent('PhoneBooths:internal_startCall')
AddEventHandler('PhoneBooths:internal_startCall', function(source, phone_number, rtcOffer, extraData)
    if cfg_phoneBooths.FixePhone[phone_number] ~= nil then
        onCallFixePhone(source, phone_number, rtcOffer, extraData)
        return
    end
    
    local rtcOffer = rtcOffer
    if phone_number == nil or phone_number == '' then 
        print('BAD CALL NUMBER IS NIL')
        return
    end

    local hidden = string.sub(phone_number, 1, 1) == '#'
    if hidden == true then
        phone_number = string.sub(phone_number, 2)
    end

    local indexCall = lastIndexCall
    lastIndexCall = lastIndexCall + 1

    local sourcePlayer = tonumber(source)
    local xplayer = ESX.GetPlayerFromId(source)
    local identifier = xplayer.identifier

    local srcPhone = ''
    if extraData ~= nil and extraData.useNumber ~= nil then
        srcPhone = extraData.useNumber
    else
        srcPhone = getNumberPhone(identifier)
    end
    --local destPlayer = getIdentifierByPhoneNumber(phone_number)
    local destPlayer = 0
    local is_valid = destPlayer ~= nil and destPlayer ~= identifier
    AppelsEnCours[indexCall] = {
        id = indexCall,
        transmitter_src = sourcePlayer,
        transmitter_num = srcPhone,
        receiver_src = nil,
        receiver_num = phone_number,
        --is_valid = destPlayer ~= nil,
        is_accepts = false,
        hidden = hidden,
        rtcOffer = rtcOffer,
        extraData = extraData
    }
    

    if is_valid == true then
        getSourceFromIdentifier(destPlayer, function (srcTo)
            if srcTo ~= nill then
                AppelsEnCours[indexCall].receiver_src = srcTo
                TriggerEvent('PhoneBooths:addCall', AppelsEnCours[indexCall])
                TriggerClientEvent('PhoneBooths:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
                TriggerClientEvent('PhoneBooths:waitingCall', srcTo, AppelsEnCours[indexCall], false)
            else
                TriggerEvent('PhoneBooths:addCall', AppelsEnCours[indexCall])
                TriggerClientEvent('PhoneBooths:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
            end
        end)
    else
        TriggerEvent('PhoneBooths:addCall', AppelsEnCours[indexCall])
        TriggerClientEvent('PhoneBooths:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
    end

end)

RegisterServerEvent('PhoneBooths:startCall')
AddEventHandler('PhoneBooths:startCall', function(phone_number, rtcOffer, extraData)
    TriggerEvent('PhoneBooths:internal_startCall',source, phone_number, rtcOffer, extraData)
end)

RegisterServerEvent('PhoneBooths:candidates')
AddEventHandler('PhoneBooths:candidates', function (callId, candidates)
    -- print('send cadidate', callId, candidates)
    if AppelsEnCours[callId] ~= nil then
        local source = source
        local to = AppelsEnCours[callId].transmitter_src
        if source == to then 
            to = AppelsEnCours[callId].receiver_src
        end
        -- print('TO', to)
        TriggerClientEvent('PhoneBooths:candidates', to, candidates)
    end
end)

RegisterServerEvent('PhoneBooths:acceptCall')
AddEventHandler('PhoneBooths:acceptCall', function(infoCall, rtcAnswer)
    local id = infoCall.id
    if AppelsEnCours[id] ~= nil then
        if PhoneFixeInfo[id] ~= nil then
            onAcceptFixePhone(source, infoCall, rtcAnswer)
            return
        end
        AppelsEnCours[id].receiver_src = infoCall.receiver_src or AppelsEnCours[id].receiver_src
        if AppelsEnCours[id].transmitter_src ~= nil and AppelsEnCours[id].receiver_src~= nil then
            AppelsEnCours[id].is_accepts = true
            AppelsEnCours[id].rtcAnswer = rtcAnswer
            TriggerClientEvent('PhoneBooths:acceptCall', AppelsEnCours[id].transmitter_src, AppelsEnCours[id], true)
            SetTimeout(1000, function() -- change to +1000, if necessary.
                TriggerClientEvent('PhoneBooths:acceptCall', AppelsEnCours[id].receiver_src, AppelsEnCours[id], false)
            end)
        end
    end
end)

RegisterServerEvent('PhoneBooths:rejectCall')
AddEventHandler('PhoneBooths:rejectCall', function(infoCall)
    if infoCall == nil then infoCall = {} end
    onRejectFixePhone(source, infoCall)
end)

getNumberPhone = function(identifier)
    local result = MySQL.Sync.fetchAll("SELECT users.phone_number FROM users WHERE users.identifier = @identifier", {
        ['@identifier'] = identifier
    })
    if result[1] ~= nil then
        return result[1].phone_number
    end
    return nil
end

getSourceFromIdentifier = function(identifier, cb)
    local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

		if(xPlayer.identifier ~= nil and xPlayer.identifier == identifier) or (xPlayer.identifier == identifier) then
			cb(xPlayer.source)
			return
		end
	end
	cb(nil)
end

onCallFixePhone = function(source, phone_number, rtcOffer, extraData)
    local indexCall = lastIndexCall
    lastIndexCall = lastIndexCall + 1

    local hidden = string.sub(phone_number, 1, 1) == '#'
    if hidden == true then
        phone_number = string.sub(phone_number, 2)
    end
    local sourcePlayer = tonumber(source)
    local xplayer = ESX.GetPlayerFromId(source)
    local identifier = xplayer.identifier

    local srcPhone = ''
    if extraData ~= nil and extraData.useNumber ~= nil then
        srcPhone = extraData.useNumber
    else
        srcPhone = getNumberPhone(identifier)
    end

    AppelsEnCours[indexCall] = {
        id = indexCall,
        transmitter_src = sourcePlayer,
        transmitter_num = srcPhone,
        receiver_src = nil,
        receiver_num = phone_number,
        is_valid = false,
        is_accepts = false,
        hidden = hidden,
        rtcOffer = rtcOffer,
        extraData = extraData,
        coords = cfg_phoneBooths.FixePhone[phone_number].coords
    }
    
    PhoneFixeInfo[indexCall] = AppelsEnCours[indexCall]

    TriggerClientEvent('PhoneBooths:notifyFixePhoneChange', -1, PhoneFixeInfo)
    TriggerClientEvent('PhoneBooths:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
end

onAcceptFixePhone = function(source, infoCall, rtcAnswer)
    local id = infoCall.id
    
    AppelsEnCours[id].receiver_src = source
    if AppelsEnCours[id].transmitter_src ~= nil and AppelsEnCours[id].receiver_src~= nil then
        AppelsEnCours[id].is_accepts = true
        AppelsEnCours[id].forceSaveAfter = true
        AppelsEnCours[id].rtcAnswer = rtcAnswer
        PhoneFixeInfo[id] = nil
        TriggerClientEvent('PhoneBooths:notifyFixePhoneChange', -1, PhoneFixeInfo)
        TriggerClientEvent('PhoneBooths:acceptCall', AppelsEnCours[id].transmitter_src, AppelsEnCours[id], true)
        SetTimeout(1000, function() -- change to +1000, if necessary.
            TriggerClientEvent('PhoneBooths:acceptCall', AppelsEnCours[id].receiver_src, AppelsEnCours[id], false)
        end)
    end
end

onRejectFixePhone = function(source, infoCall, rtcAnswer)
    local id = infoCall.id

    if id == nil then
        PhoneFixeInfo = {}
        TriggerClientEvent('PhoneBooths:notifyFixePhoneChange', -1, PhoneFixeInfo)
    else
        PhoneFixeInfo[id] = nil
        TriggerClientEvent('PhoneBooths:notifyFixePhoneChange', -1, PhoneFixeInfo)
        AppelsEnCours[id] = nil
    end
end

RegisterNetEvent('PhoneBooths:pay')
AddEventHandler('PhoneBooths:pay', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeMoney(2)
	TriggerClientEvent('Extasy:ShowAdvancedNotification', _source, "Paiement", "Succès", "Vous venez de payer ~g~2$", "CHAR_COINS")
end)

RegisterNetEvent('staff:phoneBoothsTeleportPlayer')
AddEventHandler('staff:phoneBoothsTeleportPlayer', function(coords_x, coords_y, coords_z)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local playergroup = xPlayer.getGroup()
    
    if playergroup == "superadmin" then
        SetEntityCoords(_source, coords_x, coords_y, coords_z)
    end
end)