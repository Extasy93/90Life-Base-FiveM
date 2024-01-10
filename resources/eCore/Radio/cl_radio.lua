ESX = nil
local frequence, volume, finalvolume = 0, 0, 0
local radio_PercentagePanel_enable = false

TriggerEvent("ext:getSharedObject", function(obj) ESX = obj end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	ESX.PlayerData.job2 = job2
end)

RegisterNetEvent('OpenRadio')
AddEventHandler('OpenRadio', function()
	if not playerIsOnKeyBoard then
        if not IsHandcuffed then
            if not playerIsOnRadio then
                playerIsOnRadio = not playerIsOnRadio
                openRadio_m()
            else
                playerIsOnRadio = not playerIsOnRadio
                openRadio_m()
            end
        else
            Extasy.ShowNotification("~r~Vous ne pouvez pas interagir avec votre radio en étant menotté")
        end
    end
end)

RMenu.Add('radio', 'main_menu', RageUI.CreateMenu("Radio", "Que souhaitez-vous faire ?"))
RMenu:Get('radio', 'main_menu').EnableMouse = true
RMenu:Get('radio', 'main_menu').Closed = function()
    radio_open = false
end

openRadio_m = function()
    if radio_open then
        radio_open = false
        return
    else
        radio_open = true
        RageUI.Visible(RMenu:Get('radio', 'main_menu'), true)
        Citizen.CreateThread(function()
            while radio_open do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('radio', 'main_menu'), true, true, true, function()

                    RageUI.Checkbox("Allumer / Eteindre", false, cfg_radio.Checkbox.RadioActive, {}, function(Hovered, Selected, Active, Checked) 
                        cfg_radio.Checkbox.RadioActive = Checked
                        if Checked then
                            cfg_radio.Checkbox.RadioActive = true
                            --[[if Selected then
                                ExecuteCommand('me active sa radio') 
                                Extasy.ShowNotification("~p~Radio~s~\nVous avez ~p~activé~w~ votre radio.")
                            end--]]
                        else
                            cfg_radio.Checkbox.RadioActive = false
                            exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
                            exports["pma-voice"]:SetRadioChannel(tonumber(0))
                            frequence, volume, volume2 = 0, 0, 0
                            --[[if Selected then
                                ExecuteCommand('me désactive sa radio')
                                Extasy.ShowNotification("~p~Radio~s~\nVous avez ~r~désactivé~s~ la radio")
                            end--]]
                        end
                    end)

                    if cfg_radio.Checkbox.RadioActive then

                        radio_PercentagePanel_enable = true

                        RageUI.Separator("Fréquence - ~p~"..frequence.."Hz")
                        RageUI.Separator("Volume - ~p~"..finalvolume.."%")
                        RageUI.Separator("~p~← Fréquences →")

                        RageUI.Button("Entrez une fréquence", nil, {RightLabel = "→→"}, true, function(h, a, s) 
                            if s then
                                frequence = Extasy.KeyboardInput("Entrez la fréquence", "", 30)
                                frequence = tonumber(frequence)
                                for k, v in pairs(cfg_radio.PriverSalon) do
                                    if frequence == v.Frequence then
                                        if playerJob == v.JobName or playerJob2 == v.JobName then
                                            exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
                                            exports["pma-voice"]:SetRadioChannel(v.Frequence)
                                            Extasy.ShowNotification("~p~Radio~s~\nFréquence définie sur ~p~"..v.Frequence.."Hz")
                                        else
                                            Extasy.ShowNotification("~p~Radio~s~\nCette fréquence est privée.") 
                                            frequence = 0
                                            return
                                        end
                                    end
                                end

                                if frequence == nil or frequence == "" or frequence == 0 then
                                    Extasy.ShowNotification("~p~Radio~s~\n~s~Numero Invalide")
                                    frequence = 0
                                else
                                    exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
                                    exports["pma-voice"]:SetRadioChannel(frequence)
                                    Extasy.ShowNotification("~p~Radio~s~\nFréquence définie sur ~p~"..frequence.."Hz")
                                end
                            end
                        end)

                        for k, v in pairs(cfg_radio.PriverSalon) do
                            if playerJob == v.JobName or playerJob2 == v.JobName then
                                RageUI.Button("~p~"..v.JobLabel.."~s~ - Fréquence "..v.Frequence, nil, {RightLabel = "→"}, true, function(h, a, s) 
                                    if s then
                                        frequence = v.Frequence
                                        exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
                                        exports["pma-voice"]:SetRadioChannel(v.Frequence)
                                        Extasy.ShowNotification("~p~Radio~s~\nFréquence définie sur ~p~"..frequence.."Hz")
                                    end
                                end)
                            end
                        end
                    end

                end,function()
                    if radio_PercentagePanel_enable then
                        RageUI.PercentagePanel(volume, 'Volume de la radio', '0%', '200%', function(h, a, Percent)
                            volume = Percent
                            finalvolume = volume*200
                            if a then
                                exports['pma-voice']:setRadioVolume(tonumber(finalvolume))
                                RageUI.Text({message = "Volume de la radio à ~p~" ..finalvolume.. "~s~%"})
                            end
                        end)
                    end
                end)
            end
        end)
    end
end

