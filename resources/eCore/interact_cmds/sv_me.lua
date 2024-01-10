local function TableToString(tab)
	local str = ""
	for i = 1, #tab do
		str = str .. " " .. tab[i]
	end
	return str
end

RegisterCommand('me', function(source, args)
    local text = "La personne" .. TableToString(args) .. " "
    TriggerClientEvent('3dme:shareDisplay', -1, text, source)
end)