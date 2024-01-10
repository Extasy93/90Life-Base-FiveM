RegisterNetEvent('BanSql:Respond')
AddEventHandler('BanSql:Respond', function()
	TriggerServerEvent("BanSql:CheckMe")
end)

RegisterNetEvent('GetName:Bansql')
AddEventHandler('GetName:Bansql', function(joueur)
	GetPlayerName()
end)

