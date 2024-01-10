plainteCooldown = false
rdvCooldown = false


MenuLspd = false

openVcpdReport = function()
	RMenu.Add("Extasy_lspd_plainte", 'lspd_plainte', RageUI.CreateMenu("Dépot de plainte", "LSPD"))
	RMenu:Get("Extasy_lspd_plainte", 'lspd_plainte').Closed = function()
		MenuLspd = false
	end

	if not MenuLspd then 
		MenuLspd = true
		RageUI.Visible(RMenu:Get("Extasy_lspd_plainte", 'lspd_plainte'), true)
	
		Citizen.CreateThread(function()
			while MenuLspd do
            RageUI.IsVisible(RMenu:Get("Extasy_lspd_plainte",'lspd_plainte'),true,true,true,function()

                RageUI.ButtonWithStyle("Déposer plainte","Vous permets de déposer une plainte en ligne.", {RightLabel = "→→"}, not plainteCooldown, function(_,_,s)
                    if s then
                        RageUI.Visible(RMenu:Get("Extasy_lspd_plainte",'lspd_plainte'), false)
                        DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 5000)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0);
                            Wait(0);
                        end
                        if (GetOnscreenKeyboardResult()) then
                            local result = GetOnscreenKeyboardResult()
                            TriggerServerEvent("Extasy_lspd:plainte", token, result)
                            PlaySoundFrontend(-1, "Event_Message_Purple", "GTAO_FM_Events_Soundset", 0)
                            Extasy.ShowAdvancedNotification('~b~Poste de police', '~g~Succès', "Votre plainte a été correctement envoyée et sera traitée dans les plus brefs délais.", 'CHAR_CHAT_CALL', 2, true, false, 60)
                            plainteCooldown = true
                            Citizen.SetTimeout((1000*60)*2, function()
                                plainteCooldown = false
                            end)
                            MenuLspd = false
                        end
                    end
                end)

                RageUI.ButtonWithStyle("Demander un rendez-vous", "Vous permets d'envoyer une demande de RDV en ligne.", {RightLabel = "→→"}, not rdvCooldown, function(_,_,s)
                    if s then
                        RageUI.Visible(RMenu:Get("Extasy_lspd_plainte",'lspd_plainte'), false)
                        TriggerServerEvent("Extasy_lspd:rdv", token)
                        PlaySoundFrontend(-1, "Event_Message_Purple", "GTAO_FM_Events_Soundset", 0)
                        Extasy.ShowAdvancedNotification('~b~Poste de police', '~g~Succès', "Votre demande de rendez-vous a été prise en compte, vous recevrez une convocation sous peu.", 'CHAR_CHAT_CALL', 2, true, false, 60)
                        rdvCooldown = true
                        Citizen.SetTimeout((1000*60)*30, function()
                            rdvCooldown = false
                        end)
                        MenuLspd = false
                    end
                end)   
                
                end, function()    
                end, 1)
                Wait(1)
            end
            Wait(0)
            MenuLspd = false
        end)
    end
end


