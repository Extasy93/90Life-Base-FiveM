local dragStatus = {}
local IsHandcuffed = false
dragStatus.isDragged = false
local PlayerData, GUI, CurrentActionData, JobBlips = {}, {}, {}, {}
local publicBlip = false

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Wait(10)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	blipsrunfarm()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
    blipsrunfarm()
end)



function KeyboardInputrunfarm(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", 50)
    blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() 
        Wait(500) 
        blockinput = false
        return result 
    else
        Wait(500) 
        blockinput = false 
        return nil 
    end
end

function blipsrunfarm()
	Citizen.CreateThread(function()
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'yellow' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'malibu' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'bahamas' then 
            local RecolteBoison = AddBlipForCoord(3335.7248535156, 5400.2661132813, 10.694629669189)
            SetBlipSprite(RecolteBoison, 233)
            SetBlipColour(RecolteBoison, 3)
            SetBlipScale(RecolteBoison, 0.6)
            SetBlipAsShortRange(RecolteBoison, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString("Récolte Boisson")
            EndTextCommandSetBlipName(RecolteBoison)
        end
	end)
end

local dansmenu = false
local rum_farm_boison_in_menu = false
RMenu.Add('Extasy_run_farm_boison', 'main', RageUI.CreateMenu("Récolte", ""))
RMenu:Get('Extasy_run_farm_boison', 'main'):SetSubtitle("Récolte boisson")

RMenu:Get('Extasy_run_farm_boison', 'main').EnableMouse = false
RMenu:Get('Extasy_run_farm_boison', 'main').Closed = function()
	dansmenu = false
	rum_farm_boison_in_menu = false
	TriggerServerEvent('stop:farm', token)
	FreezeEntityPosition(playerPed, false)
end

function recolterunfarm()
	if not rum_farm_boison_in_menu then
		rum_farm_boison_in_menu = true
		RageUI.Visible(RMenu:Get('Extasy_run_farm_boison', 'main'), true)
	Citizen.CreateThread(function()
		while rum_farm_boison_in_menu do
			Citizen.Wait(1)

				RageUI.IsVisible(RMenu:Get('Extasy_run_farm_boison', 'main'), true, true, true, function()

					FreezeEntityPosition(playerPed, false)

					if dansmenu then
                    FreezeEntityPosition(playerPed, true)
                    RageUI.ButtonWithStyle("Récolte en cours", nil, { RightBadge = RageUI.BadgeStyle.Lock }, false, function(Hovered, Active, Selected)     
                        if (Selected) then
                        end
                        end)
		
                    else
					RageUI.ButtonWithStyle("Récolte eau", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
						if (Selected) then
							dansmenu = true 
							TriggerServerEvent('start:farm_water', token)
							FreezeEntityPosition(playerPed, true)
							cooldown = true
							Citizen.SetTimeout(10000,function()
								cooldown = false
							    end)
						    end 
					    end)
                    RageUI.ButtonWithStyle("Récolte fanta", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
						if (Selected) then
							dansmenu = true 
							TriggerServerEvent('start:farm_fanta', token)
							FreezeEntityPosition(playerPed, true)
							cooldown = true
							Citizen.SetTimeout(10000,function()
								cooldown = false
							    end)
						    end 
					    end)
                    RageUI.ButtonWithStyle("Récolte sprite", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
                        if (Selected) then
                            dansmenu = true 
                            TriggerServerEvent('start:farm_sprite', token)
                            FreezeEntityPosition(playerPed, true)
                            cooldown = true
                            Citizen.SetTimeout(10000,function()
                                cooldown = false
                                end)
                            end 
                        end)
                    RageUI.ButtonWithStyle("Récolte cocacola", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
                        if (Selected) then
                            dansmenu = true 
                            TriggerServerEvent('start:farm_cocacola', token)
                            FreezeEntityPosition(playerPed, true)
                            cooldown = true
                            Citizen.SetTimeout(10000,function()
                                cooldown = false
                                end)
                            end 
                        end)
                    RageUI.ButtonWithStyle("Récolte icetea", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
                        if (Selected) then
                            dansmenu = true 
                            TriggerServerEvent('start:farm_icetea', token)
                            FreezeEntityPosition(playerPed, true)
                            cooldown = true
                            Citizen.SetTimeout(10000,function()
                                cooldown = false
                                end)
                            end 
                        end)
                    RageUI.ButtonWithStyle("Récolte jusfruit", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
                        if (Selected) then
                            dansmenu = true 
                            TriggerServerEvent('start:farm_jusfruit', token)
                            FreezeEntityPosition(playerPed, true)
                            cooldown = true
                            Citizen.SetTimeout(10000,function()
                                cooldown = false
                                end)
                            end 
                        end)
                    RageUI.ButtonWithStyle("Récolte redbull", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
                        if (Selected) then
                            dansmenu = true 
                            TriggerServerEvent('start:farm_redbull', token)
                            FreezeEntityPosition(playerPed, true)
                            cooldown = true
                            Citizen.SetTimeout(10000,function()
                                cooldown = false
                                end)
                            end 
                        end)
                    RageUI.ButtonWithStyle("Récolte cocacola", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
                        if (Selected) then
                            dansmenu = true 
                            TriggerServerEvent('start:farm_cocacola', token)
                            FreezeEntityPosition(playerPed, true)
                            cooldown = true
                            Citizen.SetTimeout(10000,function()
                                cooldown = false
                                end)
                            end 
                        end)
                    RageUI.ButtonWithStyle("Récolte drpepper", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
                        if (Selected) then
                            dansmenu = true 
                            TriggerServerEvent('start:farm_drpepper', token)
                            FreezeEntityPosition(playerPed, true)
                            cooldown = true
                            Citizen.SetTimeout(10000,function()
                                cooldown = false
                                end)
                            end 
                        end)
                    RageUI.ButtonWithStyle("Récolte limonade", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
                        if (Selected) then
                            dansmenu = true 
                            TriggerServerEvent('start:farm_limonade', token)
                            FreezeEntityPosition(playerPed, true)
                            cooldown = true
                            Citizen.SetTimeout(10000,function()
                                cooldown = false
                                end)
                            end 
                        end)
                    RageUI.ButtonWithStyle("Récolte tequila", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
                        if (Selected) then
                            dansmenu = true 
                            TriggerServerEvent('start:farm_tequila', token)
                            FreezeEntityPosition(playerPed, true)
                            cooldown = true
                            Citizen.SetTimeout(10000,function()
                                cooldown = false
                                end)
                            end 
                        end)
                    RageUI.ButtonWithStyle("Récolte jagerbomb", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
                        if (Selected) then
                            dansmenu = true 
                            TriggerServerEvent('start:farm_jagerbomb', token)
                            FreezeEntityPosition(playerPed, true)
                            cooldown = true
                            Citizen.SetTimeout(10000,function()
                                cooldown = false
                                end)
                            end 
                        end)
                    RageUI.ButtonWithStyle("Récolte martini", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
                        if (Selected) then
                            dansmenu = true 
                            TriggerServerEvent('start:farm_martini', token)
                            FreezeEntityPosition(playerPed, true)
                            cooldown = true
                            Citizen.SetTimeout(10000,function()
                                cooldown = false
                                end)
                            end 
                        end)
                    RageUI.ButtonWithStyle("Récolte rhum", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
                        if (Selected) then
                            dansmenu = true 
                            TriggerServerEvent('start:farm_rhum', token)
                            FreezeEntityPosition(playerPed, true)
                            cooldown = true
                            Citizen.SetTimeout(10000,function()
                                cooldown = false
                                end)
                            end 
                        end)
                    RageUI.ButtonWithStyle("Récolte vodka", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
                        if (Selected) then
                            dansmenu = true 
                            TriggerServerEvent('start:farm_vodka', token)
                            FreezeEntityPosition(playerPed, true)
                            cooldown = true
                            Citizen.SetTimeout(10000,function()
                                cooldown = false
                                end)
                            end 
                        end)
                    RageUI.ButtonWithStyle("Récolte whiskycoca", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
                        if (Selected) then
                            dansmenu = true 
                            TriggerServerEvent('start:farm_whiskycoca', token)
                            FreezeEntityPosition(playerPed, true)
                            cooldown = true
                            Citizen.SetTimeout(10000,function()
                                cooldown = false
                                end)
                            end 
                        end)
                    RageUI.ButtonWithStyle("Récolte vodkaenergy", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
                        if (Selected) then
                            dansmenu = true 
                            TriggerServerEvent('start:farm_vodkaenergy', token)
                            FreezeEntityPosition(playerPed, true)
                            cooldown = true
                            Citizen.SetTimeout(10000,function()
                                cooldown = false
                                end)
                            end 
                        end)
                    RageUI.ButtonWithStyle("Récolte vodkafruit", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
                        if (Selected) then
                            dansmenu = true 
                            TriggerServerEvent('start:farm_vodkafruit', token)
                            FreezeEntityPosition(playerPed, true)
                            cooldown = true
                            Citizen.SetTimeout(10000,function()
                                cooldown = false
                                end)
                            end 
                        end)
                    RageUI.ButtonWithStyle("Récolte rhumfruit", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
                        if (Selected) then
                            dansmenu = true 
                            TriggerServerEvent('start:farm_rhumfruit', token)
                            FreezeEntityPosition(playerPed, true)
                            cooldown = true
                            Citizen.SetTimeout(10000,function()
                                cooldown = false
                                end)
                            end 
                        end)
                    RageUI.ButtonWithStyle("Récolte rhumcoca", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
                        if (Selected) then
                            dansmenu = true 
                            TriggerServerEvent('start:farm_rhumcoca', token)
                            FreezeEntityPosition(playerPed, true)
                            cooldown = true
                            Citizen.SetTimeout(10000,function()
                                cooldown = false
                                end)
                            end 
                        end)
                    RageUI.ButtonWithStyle("Récolte mojito", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
                        if (Selected) then
                            dansmenu = true 
                            TriggerServerEvent('start:farm_mojito', token)
                            FreezeEntityPosition(playerPed, true)
                            cooldown = true
                            Citizen.SetTimeout(10000,function()
                                cooldown = false
                                end)
                            end 
                        end)
                    end
				end)
			end
		end)
	end
end

local Vendeur_in_menu_recolte2 = false
RMenu.Add('Extasy_vendeur_recolte2', 'main', RageUI.CreateMenu("Récolte", ""))
RMenu:Get('Extasy_vendeur_recolte2', 'main'):SetSubtitle("Vendeur")

RMenu:Get('Extasy_vendeur_recolte2', 'main').EnableMouse = false
RMenu:Get('Extasy_vendeur_recolte2', 'main').Closed = function()
	dansmenu = false
	Vendeur_in_menu_recolte2 = false
	TriggerServerEvent('stop:farm', token)
	FreezeEntityPosition(playerPed, false)
end

function recoltemeche()
	if not Vendeur_in_menu_recolte2 then
		Vendeur_in_menu_recolte2 = true
		RageUI.Visible(RMenu:Get('Extasy_vendeur_recolte2', 'main'), true)
	Citizen.CreateThread(function()
		while Vendeur_in_menu_recolte2 do
			Wait(1)

				RageUI.IsVisible(RMenu:Get('Extasy_vendeur_recolte2', 'main'), true, true, true, function()

					FreezeEntityPosition(playerPed, false)

					if dansmenu then
							FreezeEntityPosition(playerPed, true)
						RageUI.ButtonWithStyle("Récolter des mèches", nil, { RightBadge = RageUI.BadgeStyle.Lock }, false, function(Hovered, Active, Selected)     
							if (Selected) then
							end
						  end)
		
						else 

					RageUI.ButtonWithStyle("Récolter des mèches", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
						if (Selected) then
							dansmenu = true 
							TriggerServerEvent('start:farm2')
							FreezeEntityPosition(playerPed, true)
							cooldown = true
							Citizen.SetTimeout(10000,function()
								cooldown = false
							    end)
						    end 
					    end)
				    end
				end)
			end
		end)
	end
end

local Vendeur_in_menu_recolte3 = false
RMenu.Add('Extasy_vendeur_recolte3', 'main', RageUI.CreateMenu("Récolte", ""))
RMenu:Get('Extasy_vendeur_recolte3', 'main'):SetSubtitle("Vendeur")

RMenu:Get('Extasy_vendeur_recolte3', 'main').EnableMouse = false
RMenu:Get('Extasy_vendeur_recolte3', 'main').Closed = function()
	dansmenu = false
	Vendeur_in_menu_recolte3 = false
	TriggerServerEvent('stop:farm', token)
	FreezeEntityPosition(playerPed, false)
end

function recoltecanon()
	if not Vendeur_in_menu_recolte3 then
		Vendeur_in_menu_recolte3 = true
		RageUI.Visible(RMenu:Get('Extasy_vendeur_recolte3', 'main'), true)
	Citizen.CreateThread(function()
		while Vendeur_in_menu_recolte3 do
			Wait(1)

				RageUI.IsVisible(RMenu:Get('Extasy_vendeur_recolte3', 'main'), true, true, true, function()

					FreezeEntityPosition(playerPed, false)

					if dansmenu then
							FreezeEntityPosition(playerPed, true)
						RageUI.ButtonWithStyle("Récolter des canons", nil, { RightBadge = RageUI.BadgeStyle.Lock }, false, function(Hovered, Active, Selected)     
							if (Selected) then
							end
						  end)
		
						else 

					RageUI.ButtonWithStyle("Récolter des canons", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
						if (Selected) then
							dansmenu = true 
							TriggerServerEvent('start:farmC', token)
							FreezeEntityPosition(playerPed, true)
							cooldown = true
							Citizen.SetTimeout(10000,function()
								cooldown = false
							    end)
						    end 
					    end)
				    end
				end)
			end
		end)
	end
end


local Vendeur_in_menu_recolte4 = false
RMenu.Add('Extasy_vendeur_recolte4', 'main', RageUI.CreateMenu("Récolte", ""))
RMenu:Get('Extasy_vendeur_recolte4', 'main'):SetSubtitle("Vendeur")

RMenu:Get('Extasy_vendeur_recolte4', 'main').EnableMouse = false
RMenu:Get('Extasy_vendeur_recolte4', 'main').Closed = function()
	dansmenu = false
	Vendeur_in_menu_recolte4 = false
	TriggerServerEvent('stop:farm', token)
	FreezeEntityPosition(playerPed, false)
end

function recoltelevier()
	if not Vendeur_in_menu_recolte4 then
		Vendeur_in_menu_recolte4 = true
		RageUI.Visible(RMenu:Get('Extasy_vendeur_recolte4', 'main'), true)
	Citizen.CreateThread(function()
		while Vendeur_in_menu_recolte4 do
			Wait(1)

				RageUI.IsVisible(RMenu:Get('Extasy_vendeur_recolte4', 'main'), true, true, true, function()

					FreezeEntityPosition(playerPed, false)

					if dansmenu then
							FreezeEntityPosition(playerPed, true)
						RageUI.ButtonWithStyle("Récolter des levier", nil, { RightBadge = RageUI.BadgeStyle.Lock }, false, function(Hovered, Active, Selected)     
							if (Selected) then
							end
						  end)
		
						else 

					RageUI.ButtonWithStyle("Récolter des levier", nil, {RightLabel = "→"}, not cooldown, function(Hovered, Active, Selected) 
						if (Selected) then
							dansmenu = true
							TriggerServerEvent('start:farm4', token)
							FreezeEntityPosition(playerPed, true)
							cooldown = true
							Citizen.SetTimeout(10000,function()
								cooldown = false
							    end)
						    end 
					    end)
				    end
				end)
			end
		end)
	end
end


