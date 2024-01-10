ESX = nil
TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('parachutisme:Takemoney', function (source, cb, price)
	TriggerEvent("ext:AST", source, "parachutisme:Takemoney")
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= 500 then
		xPlayer.removeMoney(500)
		cb(true)
	else
		cb(false)
	end
end)