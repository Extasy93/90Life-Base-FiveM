local lottery_in_menu = false

RMenu.Add('Extasy_lottery', 'main_menu', RageUI.CreateMenu("Loterie", "Que voulez-vous faire ?", 1, 100))
RMenu.Add('Extasy_lottery', 'main_menu_register', RageUI.CreateSubMenu(RMenu:Get('Extasy_lottery', 'main_menu'), "Loterie", "Formulaire de participation"))
RMenu:Get('Extasy_lottery', 'main_menu').Closed = function()
    lottery_in_menu        = false
end

LOTTERY                    = {}
LOTTERY.loaded             = false
LOTTERY.nickname           = 'Inconnu'
LOTTERY.amount             = 5000
LOTTERY.index              = 1
LOTTERY.expireDate         = ''
LOTTERY.totalMoney         = 0
LOTTERY.participationCount = 0

OpenLottery = function()
    if lottery_in_menu then
        lottery_in_menu    = false
        return
    else
        TriggerServerEvent("lottery:getLotteryData", token)

        lottery_in_menu = true
        RageUI.Visible(RMenu:Get('Extasy_lottery', 'main_menu'), true)

        Citizen.CreateThread(function()
            while lottery_in_menu do

                    RageUI.IsVisible(RMenu:Get('Extasy_lottery', 'main_menu'), true, true, true, function()

                        RageUI.CenterButton("Tirage le ~o~"..LOTTERY.expireDate, nil, {}, true, function(_, _, s) end)
                        RageUI.CenterButton("Lot actuel ~g~"..Extasy.Math.GroupDigits(LOTTERY.totalMoney, 2).."$", nil, {}, true, function(_, _, s) end)
                        RageUI.CenterButton("Nombre de participation~p~ "..LOTTERY.participationCount, nil, {}, true, function(_, _, s) end)

                        RageUI.Separator("")

                        RageUI.Button("Participer à la loterie", nil, {}, true, function(_, _, s) end, RMenu:Get('Extasy_lottery', 'main_menu_register'))

                    end, function()
                    end)

                    RageUI.IsVisible(RMenu:Get('Extasy_lottery', 'main_menu_register'), true, true, true, function()

                        RageUI.CenterButton("~g~↓ Formulaire de participation ↓", nil, {}, true, function(_, _, s) end)

                        RageUI.Separator("")

                        RageUI.Button("Pseudo", "Vous pouvez mettre le nom que vous voulez, souvenez-en vous si vous gagnez !", {RightLabel = LOTTERY.nickname}, true, function(_, _, s)
                            if s then
                                local i = Extasy.KeyboardInput("Quel pseudo voulez-vous avoir ?", "", 20)
                                i = tostring(i)
                                if i ~= nil then
                                    LOTTERY.nickname = i
                                end
                            end
                        end)

                        RageUI.Button("Montant", nil, {RightLabel = Extasy.Math.GroupDigits(LOTTERY.amount, 2).."$"}, true, function(_, _, s)
                            if s then
                                local i = Extasy.KeyboardInput("Combien voulez-vous jouer ?", "", 20)
                                i = tonumber(i)
                                if i ~= nil then
                                    if i >= cfg_lottery.minAmount then
                                        ESX.TriggerServerCallback('Extasy_lottery:CheckAccount', function(hasEnoughMoney)
											if hasEnoughMoney then
												LOTTERY.amount = i
											else
												Extasy.ShowNotification("~r~Vous n'avez pas assez d'argent")
											end
										end, i)
                                    else
                                        Extasy.ShowNotification("~r~Le minimum à jouer pour participer est de "..Extasy.Math.GroupDigits(cfg_lottery.minAmount, 2).."$")
                                    end
                                end
                            end
                        end)

                        RageUI.Separator("")

                        RageUI.Button("~g~Je participe", nil, {}, true, function(_, _, s)
                            if s then
                                ESX.TriggerServerCallback('Extasy_lottery:DebitAccount', function(hasEnoughMoney)
                                    if hasEnoughMoney then
                                        TriggerServerEvent("lottery:registerNewPlayer", token, LOTTERY.nickname, LOTTERY.amount)
                                        Extasy.ShowNotification("~g~Participation validée !")
                                        Extasy.RequestStreamedTextureDict("DIA_CUSTOMER")
                                    else
                                        Extasy.ShowNotification("~r~Vous n'avez pas assez d'argent")
                                    end
                                end, LOTTERY.amount, LOTTERY.totalMoney)

                                TriggerServerEvent("lottery:getLotteryData", token)
                                RageUI.GoBack()
                                TriggerServerEvent("lottery:getLotteryData", token)
                                -- LOTTERY.nickname           = 'Inconnu'
                                -- LOTTERY.amount             = 5000
                                -- LOTTERY.index              = 1
                                -- LOTTERY.expireDate         = ''
                            end
                        end)

                    end, function()
                    end)
                Wait(1)
            end
        end)
    end
end

RegisterNetEvent("lottery:sendLotteryData")
AddEventHandler("lottery:sendLotteryData", function(eDate, eAmount, eParticipation)
    LOTTERY.expireDate             = eDate
    LOTTERY.totalMoney             = eAmount
    LOTTERY.participationCount     = eParticipation
end)