------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
----------------------------		  Base développer par Extasy#0093		    ----------------------------
----------------------------	    Pour 90Life PS: (L'anti-Cheat n'est pas	----------------------------
----------------------------		  la. Cherche encore negros🔎😁)		   ----------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    ESX.PlayerData = ESX.GetPlayerData()

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    while ESX.GetPlayerData().job2 == nil do
        Citizen.Wait(0)
    end
end)

local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

local Joblisting_in_menu = false

RMenu.Add('Extasy_Pôle_emploi_menu', 'main_menu', RageUI.CreateMenu("Pôle Emplois", "Que souhaitez-vous faire ?"))
RMenu:Get('Extasy_Pôle_emploi_menu', 'main_menu').Closed = function()
    Joblisting_in_menu = false
end

openJoblistingMenu = function()
	if not Joblisting_in_menu then 
		Joblisting_in_menu = true
		RageUI.Visible(RMenu:Get('Extasy_Pôle_emploi_menu', 'main_menu'), true)
	
		Citizen.CreateThread(function()
			while Joblisting_in_menu do
            Citizen.Wait(1)
                RageUI.IsVisible(RMenu:Get('Extasy_Pôle_emploi_menu', 'main_menu'), true, true, true, function()

                    RageUI.Separator("↓ ~p~Métiers disponible en ville~s~ ↓")

                    RageUI.Button("Travaillé en tant que~s~: ~o~Mineur~s~", "Que souhaité vous faire ?",  {RightLabel = "~g~Illimitée"}, true, function(Hovered, Active, Selected)
                        if (Selected) then

                            SetNewWaypoint(2831.689, 2798.311, 56.49803)

                            PlaySoundFrontend( -1, "BASE_JUMP_PASSED", "HUD_AWARDS", 1)
                            Joblisting_in_menu = false

                            Extasy.ShowAdvancedNotification('Pôle Emploi', '~b~Annonce Pôle Emploi', '~p~Boby ~w~vous attends à la ~g~Mine.~w~ Je vous ai mis le GPS !', 'CHAR_ALL_PLAYERS_CONF', 8)

                            --Extasy.ShowAdvancedNotification('Pôle Emploi', '~b~Annonce Pôle Emploi', 'Ce métier est déja au Complet, choisissez en un autre.', 'CHAR_ALL_PLAYERS_CONF', 8)
                        end
                    end)
                    RageUI.Button("Travaillé en tant que~s~: ~o~Bûcheron~s~", "Que souhaité vous faire ?",  {RightLabel = "~g~Illimitée"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            SetNewWaypoint(-570.853, 5367.214, 69.21643)

                            PlaySoundFrontend( -1, "BASE_JUMP_PASSED", "HUD_AWARDS", 1)
                            Joblisting_in_menu = false

                            Extasy.ShowAdvancedNotification('Pôle Emploi', '~b~Annonce Pôle Emploi', '~p~Sam ~w~vous attends à la ~g~Scierie.~w~ Je vous ai mis le GPS !', 'CHAR_ALL_PLAYERS_CONF', 8)
                        end
                    end)
                    RageUI.Button("Travaillé en tant que~s~: ~o~Abateur~s~", "Que souhaité vous faire ?", {RightLabel = "~y~Faire une demande"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            RageUI.Visible(RMenu:Get("Extasy_lspd_plainte",'lspd_plainte'), false)

                            DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 5000)
                            while (UpdateOnscreenKeyboard() == 0) do
                                DisableAllControlActions(0);
                                Wait(0);
                            end
                            if (GetOnscreenKeyboardResult()) then
                                local result = GetOnscreenKeyboardResult()
                                TriggerServerEvent("JobListing:SendWebhookAbateur", token, result)
                                PlaySoundFrontend(-1, "Event_Message_Purple", "GTAO_FM_Events_Soundset", 0)
                                Extasy.ShowAdvancedNotification('~b~Pôle Emplois', '~g~Succès', "Votre demande a été correctement envoyée et sera traitée dans les plus brefs délais.", 'CHAR_CHAT_CALL', 2, true, false, 60)
                                demandeCooldown = true
                                Citizen.SetTimeout((1000*60)*2, function()
                                    demandeCooldown = false
                                end)
                                Joblisting_in_menu = false
                            end
                        end
                    end)
                    RageUI.Button("Travaillé en tant que~s~: ~o~Couturier~s~", "Que souhaité vous faire ?", {RightLabel = "~r~Complet"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            --TriggerServerEvent('JobListing:setJobCouturier', token)

                            --PlaySoundFrontend( -1, "BASE_JUMP_PASSED", "HUD_AWARDS", 1)
                            Joblisting_in_menu = false

                            Extasy.ShowAdvancedNotification('Pôle Emploi', '~b~Annonce Pôle Emploi', 'Ce métier est déja au Complet, choisissez en un autre.', 'CHAR_ALL_PLAYERS_CONF', 8)
                        end
                    end)
                    RageUI.Button("Travaillé en tant que~s~: ~o~Menuisier~s~", "Que souhaité vous faire ?", {RightLabel = "~r~ En construction"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            --TriggerServerEvent('JobListing:setJobMenuisier', token)

                            --PlaySoundFrontend( -1, "BASE_JUMP_PASSED", "HUD_AWARDS", 1)
                            --Joblisting_in_menu = false

                            --Extasy.ShowAdvancedNotification('Pôle Emploi', '~b~Annonce Pôle Emploi', 'Vous êtes désormais ~b~Menuisier.', 'CHAR_ALL_PLAYERS_CONF', 8)
                        end
                    end)
                    RageUI.Button("~p~Redevenir~s~ : Chômeur", "Que souhaité vous faire ?", {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            TriggerServerEvent('JobListing:setJobChômeur', token)

                            PlaySoundFrontend( -1, "BASE_JUMP_PASSED", "HUD_AWARDS", 1)
                            Joblisting_in_menu = false

                            Extasy.ShowAdvancedNotification('Pôle Emploi', '~b~Annonce Pôle Emploi', 'Vous êtes de nouveau au chomage', 'CHAR_ALL_PLAYERS_CONF', 8)
                        end
                    end)
                end, function()
                end)   
            end
        end)
    end
end


