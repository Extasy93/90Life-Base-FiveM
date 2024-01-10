locksound = false
local pillused = true

RegisterNetEvent('OblivionPill:piluleoubli')
AddEventHandler('OblivionPill:piluleoubli', function()
	Citizen.CreateThread(function()
		while true do
			Wait(1)    

			if pillused == true then
				StartScreenEffect("DeathFailOut", 0, 0)

				if not locksound then
					PlaySoundFrontend(-1, "Bed", "WastedSounds", 1)
					locksound = true
					pillused = true
				end

				ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)
				local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")

				if HasScaleformMovieLoaded(scaleform) then
					Wait(1)

					PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
					BeginTextComponent("STRING")
					AddTextComponentString('~b~Vous tombez dans l\'oubli...')
					EndTextComponent()
					PopScaleformMovieFunctionVoid()

					Wait(1)
					PlaySoundFrontend(-1, "TextHit", "WastedSounds", 1)

					while pillused == true do
						DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
						SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
						DisablePlayerFiring(PlayerId(), true)
						Wait(1)
					end

					StopScreenEffect("DeathFailOut")
					locksound = false
				end
			end
		end
	end)
end)

RegisterNetEvent('OblivionPill:stoppill')
AddEventHandler('OblivionPill:stoppill', function()
    stopPill()
end)

stopPill = function()
    pillused = false
end