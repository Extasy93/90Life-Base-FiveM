ESX = nil
local PlayerLoaded = false
local show = false

CreateThread(function()
	while ESX == nil do
		TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end

	while ESX.GetPlayerData().job == nil do Wait(10) end

	PlayerData = ESX.GetPlayerData()
	PlayerLoaded = true
	TriggerServerEvent('hud:getPlayersList')

	while players == nil do Wait(1) end

	StartShowHudThread()

	Wait(2000)

	--show = true

	SendNUIMessage({
		action = 'showAdvanced',
		show = show
	})
end)

RegisterNetEvent("hud:getPlayersList")
AddEventHandler("hud:getPlayersList", function(list)
    players = list
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	Wait(5000)
	exports.eCore:Extasy_ShowNotification("~w~ASTUCE~s~\n\n~p~Appuyez sur [F1] pour afficher vos informations")
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	SendNUIMessage({action = "job", job = job.label})
	Wait(2000)
	exports.eCore:Extasy_ShowNotification("~w~ASTUCE~s~\n\n~p~Appuyez sur [F1] pour afficher vos informations")
end)

StartShowHudThread = function()
	CreateThread(function()
		while true do
			Wait(1000)

			if not show then

				if PlayerData.job ~= nil then
					SendNUIMessage({action = "job", job = PlayerData.job.label, id = GetPlayerServerId(PlayerId())})
				end

				SendNUIMessage({action = "players", players = #players})

				local xPlayer = ESX.GetPlayerData()

				for k, v in ipairs(xPlayer.accounts) do
					if v.name == "money" then
						SendNUIMessage({action = "setMoney", money = v.money})
					end
					if v.name == "bank" then
						SendNUIMessage({action = "setBankMoney", money = v.money})
					end
				end
			end
		end
	end)

	CreateThread(function()
		while true do
			Wait(10000)
			if not show then
				TriggerServerEvent('hud:getPlayersList')

				SendNUIMessage({action = "players", players = #players})
			end
		end
	end)

	CreateThread(function()
		while true do
			Wait(500)

			if not show then
				local pause = false

				if IsPauseMenuActive() then
					pause = true
				end

				SendNUIMessage({
					action = 'pause',
					pause = pause
				})
			end
		end
	end)
end

RegisterNetEvent('Extasy:ShowF1Hud')
AddEventHandler('Extasy:ShowF1Hud', function()
	PlayerData = ESX.GetPlayerData()
	PlayerLoaded = true
	TriggerServerEvent('hud:getPlayersList')

	while players == nil do Wait(1) end

	if show == false then
		show = true
	else
		show = false
	end

	SendNUIMessage({
		action = 'showAdvanced',
		show = show
	})
end)