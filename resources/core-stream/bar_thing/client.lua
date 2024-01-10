function drawBar(time, text, cb)
	SendNUIMessage({
		time = time,
		text = text,
	})
	if cb then
		Citizen.SetTimeout(time + 100, cb)
	end
end

RegisterNetEvent('eCore:PlusLaBar')
AddEventHandler('eCore:PlusLaBar', function()
	SendNUIMessage({
		type = "ui",
		display = false
	})
end)

RegisterNetEvent('eCore:AfficherBar')
AddEventHandler('eCore:AfficherBar', function(time, text, cb)
	drawBar(time, text, cb)
end)