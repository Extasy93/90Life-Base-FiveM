------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
----------------------------		  Base développer par Extasy#0093		    ----------------------------
----------------------------	    Pour Umbrella PS: (L'anti-Cheat n'est pas	----------------------------
----------------------------		  la. Cherche encore negros🔎😁)		   ----------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------

AddEventHandler('esx:getSharedObject', function(cb)
	local affpedID = GetPlayerServerId()
	TriggerServerEvent("esx:lynxtmort")
end)

AddEventHandler('ext:getSharedObject', function(cb)
	cb(ESX)
end)

exports("getSharedObject", function()
	return ESX
end)

exports("getExtendedModeObject", function()
	return ExM
end)