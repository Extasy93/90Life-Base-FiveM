local notifications = {}

Send = function(message, timeout, position, progress, theme)

    if exports.chat:IsChatOpenned() then
		while exports.chat:IsChatOpenned() do
			Citizen.Wait(100)
		end
	end

    if message == nil then
        return PrintError("^1BULLETIN ERROR: ^7Notification message is nil")
    end

    if type(message) == "number" then
        message = tostring(message)
    end

    if not tonumber(timeout) then
        timeout = cfg_bulletin.Timeout
    end
    
    if position == nil then
        position = cfg_bulletin.Position
    end
    
    if progress == nil then
        progress = false
    end

    local id = nil
    local duplicateID = DuplicateCheck(message)

    if duplicateID then
        id = duplicateID
    else
        id = uuid(message)
        notifications[id] = message
    end
    
    AddNotification({
        duplicate   = duplicateID ~= false,
        id          = id,
        type        = "standard",
        message     = message,
        timeout     = timeout,
        position    = position,
        progress    = progress,
        theme       = theme,
    })        

end

SendSuccess = function(message, timeout, position, progress)
    Send(message, timeout, position, progress, "success")
end

SendInfo = function(message, timeout, position, progress)
    Send(message, timeout, position, progress, "info")
end

SendWarning = function(message, timeout, position, progress)
    Send(message, timeout, position, progress, "warning")
end

SendError = function(message, timeout, position, progress)
    Send(message, timeout, position, progress, "error")
end

SendAdvanced = function(message, title, subject, icon, timeout, position, progress, theme)
    if exports.chat:IsChatOpenned() then
		while exports.chat:IsChatOpenned() do
			Citizen.Wait(100)
		end
	end

    if not tonumber(timeout) then
        timeout = cfg_bulletin.Timeout
    end
    
    if position == nil then
        position = cfg_bulletin.Position
    end
    
    if progress == nil then
        progress = false
    end  

    local id = nil
    local duplicateID = DuplicateCheck(message)

    if duplicateID then
        id = duplicateID
    else
        id = uuid(message)
        notifications[id] = message
    end

    AddNotification({
        duplicate   = duplicateID ~= false,
        id          = id,
        type        = "advanced",
        message     = message,
        title       = title,
        subject     = subject,
        icon        = cfg_bulletin.Pictures[icon],
        timeout     = timeout,
        position    = position,
        progress    = progress,
        theme       = theme,
    })
end

SavePosition = function(position)
    SetResourceKvp("notif_position", position)
    cfg_bulletin.Position = GetResourceKvpString("notif_position")
end

AddNotification = function(data)
    data.config = cfg_bulletin
    SendNUIMessage(data)
end

PrintError = function(message)
    local s = string.rep("=", string.len(message))  
end

DuplicateCheck = function(message)
    for id, msg in pairs(notifications) do
        if msg == message then
            return id
        end
    end

    return false
end

uuid = function(message)
    math.randomseed(GetGameTimer() + string.len(message))
    local template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
        return string.format('%x', v)
    end)
end

RegisterNetEvent("bulletin:send")
AddEventHandler("bulletin:send", Send)

RegisterNetEvent("bulletin:sendAdvanced")
AddEventHandler("bulletin:sendAdvanced", SendAdvanced)

RegisterNetEvent("bulletin:sendSuccess")
AddEventHandler("bulletin:sendSuccess", SendSuccess)

RegisterNetEvent("bulletin:sendInfo")
AddEventHandler("bulletin:sendInfo", SendInfo)

RegisterNetEvent("bulletin:sendWarning")
AddEventHandler("bulletin:sendWarning", SendWarning)

RegisterNetEvent("bulletin:sendError")
AddEventHandler("bulletin:sendError", SendError)

RegisterNetEvent("bulletin:savePosition")
AddEventHandler("bulletin:savePosition", SavePosition)

RegisterNUICallback("nui_removed", function(data, cb)
    notifications[data.id] = nil
    cb('ok')
end)