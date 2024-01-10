ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
        Wait(1)
    end
end)

vehicle = nil

local FarmJobs_in_menu = false

RMenu.Add('Extasy_bucheron', 'main', RageUI.CreateMenu("Bucheron", nil))
RMenu:Get('Extasy_bucheron', 'main'):SetSubtitle("~p~Chef de la Scierie")
RMenu:Get('Extasy_bucheron', 'main').Closed = function()
    FarmJobs_in_menu = false
end

openFarmJobsMenu = function()
	if not FarmJobs_in_menu then 
		FarmJobs_in_menu = true
		RageUI.Visible(RMenu:Get('Extasy_bucheron', 'main'), true)
	
		Citizen.CreateThread(function()
			while FarmJobs_in_menu do
                Citizen.Wait(1)
                RageUI.IsVisible(RMenu:Get('Extasy_bucheron', 'main'), true, true, true, function()

            if not InWork then
                RageUI.Button("Demander Un Travail à la Scierie", "", {}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        Extasy.ShowNotification("Alors comme ça tu veux bosser pour les ~g~Bucherons~w~ hein ? Très bien, met un casque et prends tees outils ! Si tu es faible , dis le moi tout de suite !")
                        InWork = true
                        local model = GetEntityModel(GetPlayerPed(-1))
                            TriggerEvent('skinchanger:getSkin', function(skin)
                            if model == GetHashKey("mp_m_freemode_01") then
                                clothesSkin = {
                                    ['bags_1'] = 0, ['bags_2'] = 0,
                                    ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                                    ['torso_1'] = 143, ['torso_2'] = 0,
                                    ['arms'] = 0,
                                    ['pants_1'] = 19, ['pants_2'] = 3,
                                    ['shoes_1'] = 42, ['shoes_2'] = 0,
                                    ['mask_1'] = 0, ['mask_2'] = 0,
                                    ['bproof_1'] = 3,
                                    ['helmet_1'] = 0, ['helmet_2'] = 0
                                }
                            else
                                clothesSkin = {
                                    ['tshirt_1'] = 14,  ['tshirt_2'] = 0,
                                    ['torso_1'] = 81,   ['torso_2'] = 1,
                                    ['decals_1'] = 0,   ['decals_2'] = 0,
                                    ['arms'] = 0,
                                    ['pants_1'] = 18,   ['pants_2'] = 3,
                                    ['shoes_1'] = 26,   ['shoes_2'] = 0,
                                    ['helmet_1'] = 0,  ['helmet_2'] = 0,
                                    ['chain_1'] = -1,    ['chain_2'] = 0,
                                    ['mask_1'] = -1,  	['mask_2'] = 0,
                                    ['bproof_1'] = 5,  	['bproof_2'] = 0,
                                    ['ears_1'] = -1,     ['ears_2'] = 0,
                                    ['bags_1'] = 0,    ['bags_2'] = 0,
                                    ['glasses_1'] = 5,    ['glasses_2'] = 0
                                }
                            end
                            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                        end)
                        DebutTravail("bucheron")
                    end
                end)
            else
                RageUI.Button("Arreter De Travailler", "", {}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        Extasy.ShowNotification("Ah ! Tu stop déja ? je savais que tu étais Faible , tiens prend ta paye")
                        InWork = false
                        FinTravail()
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                            local isMale = skin.sex == 0
                            TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                    TriggerEvent('skinchanger:loadSkin', skin)
                                    TriggerEvent('esx:restoreLoadout')
                                end)
                            end)
                        end)
                    end
                end)
            end
        end, function()
        end)   
    end
end)
end
end

