RegisterServerEvent('tackle:tryTackle')
AddEventHandler('tackle:tryTackle', function(token, target)
    if not CheckToken(token, source, "tackle:tryTackle") then return end
    print(target)
    print(source)
	--TriggerClientEvent("tackle:getTackled", target)
end)
