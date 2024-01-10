local wasProximityDisabledFromOverride = false
local stopTime = 0 
local currentVOIPRange = 1.5 -- Arcadia
disableProximityCycle = false
RegisterCommand('setvoiceintent', function(source, args)
	if GetConvarInt('voice_allowSetIntent', 1) == 1 then
		local intent = args[1]
		if intent == 'speech' then
			MumbleSetAudioInputIntent(`speech`)
		elseif intent == 'music' then
			MumbleSetAudioInputIntent(`music`)
		end
		LocalPlayer.state:set('voiceIntent', intent, true)
	end
end)

-- TODO: Better implementation of this?
RegisterCommand('vol', function(_, args)
	if not args[1] then return end
	setVolume(tonumber(args[1]))
end)

exports('setAllowProximityCycleState', function(state)
	type_check({state, "boolean"})
	disableProximityCycle = state
end)

function setProximityState(proximityRange, isCustom)
	local voiceModeData = Cfg.voiceModes[mode]
	MumbleSetTalkerProximity(proximityRange + 0.0)
	LocalPlayer.state:set('proximity', {
		index = mode,
		distance = proximityRange,
		mode = isCustom and "Custom" or voiceModeData[2],
	}, true)
	sendUIMessage({
		-- JS expects this value to be - 1, "custom" voice is on the last index
		voiceMode = isCustom and #Cfg.voiceModes or mode - 1
	})
end

exports("overrideProximityRange", function(range, disableCycle)
	type_check({range, "number"})
	setProximityState(range, true)
	if disableCycle then
		disableProximityCycle = true
		wasProximityDisabledFromOverride = true
	end
end)

exports("clearProximityOverride", function()
	local voiceModeData = Cfg.voiceModes[mode]
	setProximityState(voiceModeData[1], false)
	if wasProximityDisabledFromOverride then
		disableProximityCycle = false
	end
end)

RegisterCommand('cycleproximity', function()
	-- Proximity is either disabled, or manually overwritten.
	if GetConvarInt('voice_enableProximityCycle', 1) ~= 1 or disableProximityCycle then return end
	local newMode = mode + 1

	-- If we're within the range of our voice modes, allow the increase, otherwise reset to the first state
	if newMode <= #Cfg.voiceModes then
		mode = newMode
	else
		mode = 1
	end

	stopTime = GetGameTimer() + 1000
	currentVOIPRange = mode

	setProximityState(Cfg.voiceModes[mode][1], false)
	TriggerEvent('pma-voice:setTalkingMode', mode)
end, false)

RegisterKeyMapping('cycleproximity', 'Portée de la voix', 'keyboard', GetConvar('voice_defaultCycle', 'F11'))

local voipMarkerRanges = {
	-- 1.0 native MAX : 6.0  units
	-- 2.3 native MAX : 14.0 units
	-- 5.0 native MAX : 27.0 units
	[1] = {normal = 1.5,   max = 5.5},
	[2] = {normal = 3.0,   max = 13.0},
	[3] = {normal = 6.0,  max = 20.0},
	[4] = {normal = 12.0,  max = 20.0},
}

-- Proximity circle loop
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if stopTime >= GetGameTimer() then
			local coords = GetEntityCoords(GetPlayerPed(-1), 0)
            DrawMarker(28, coords.x, coords.y, coords.z, nil, nil, nil, nil, nil, nil, voipMarkerRanges[currentVOIPRange].normal, voipMarkerRanges[currentVOIPRange].normal, voipMarkerRanges[currentVOIPRange].normal, 111, 58, 255, 100, false, false)
		end
	end
end)
