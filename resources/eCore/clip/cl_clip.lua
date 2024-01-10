RegisterNetEvent('Clip:clipcli')
AddEventHandler('Clip:clipcli', function()
	local playerPed = GetPlayerPed(-1)

	if IsPedArmed(playerPed, 4) then
		local hash = GetSelectedPedWeapon(playerPed)

		if hash then
			TriggerServerEvent('Clip:remove', token)
			AddAmmoToPed(playerPed, hash, 25)
			Extasy.ShowNotification("Vous avez ~g~utilisé~s~ 1x chargeur")
		else
			Extasy.ShowNotification("~r~Action Impossible~s~ : Vous n'avez pas d'arme en main !")
		end
	else
		Extasy.ShowNotification("~r~Action Impossible~s~ : Ce type de munition ne convient pas !")
	end
end)