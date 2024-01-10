ESX = nil
local PlayerData = {}
local jobListe = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end
end)

local society_open_menu = false

RMenu.Add('society_boss_menu', 'main_menu', RageUI.CreateMenu("Société", "Que souhaitez-vous faire ?", 1, 100))
RMenu.Add('society_boss_menu', 'society_employee_list', RageUI.CreateSubMenu(RMenu:Get('society_boss_menu', 'main_menu'), "Employés", "Que souhaitez-vous faire ?"))
RMenu.Add('society_boss_menu', 'society_employee_list_choose', RageUI.CreateSubMenu(RMenu:Get('society_boss_menu', 'society_employee_list_choose'), "Employés", "Que souhaitez-vous faire ?"))
RMenu:Get('society_boss_menu', 'main_menu').Closed = function()
    society_open_menu = false
end

OpenBossMenu_m = function(society, options, societymoney, wash)
  local options  = options or {}
  local elements = {}
  local defaultOptions = {
    withdraw  = true,
    deposit   = true,
    employees = true,
    grades    = false
  }
  if society_open_menu then
      society_open_menu = false
      return
  else
      society_open_menu = true
      Citizen.CreateThread(function()
          while society_open_menu do
              Wait(1)
              RageUI.IsVisible(RMenu:Get('society_boss_menu', 'main_menu'), true, true, true, function()

                for k,v in pairs(defaultOptions) do
                   if options[k] == nil then
                      options[k] = v
                   end
                end

                if societymoney ~= nil then
                    RageUI.Separator("[ Societé ~p~"..ESX.PlayerData.job.label.."~s~ ] - [ Argent ~g~"..societymoney.."$~s~ ]")
                end
          
              if options.withdraw then
                  if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unemployed' then 
                      TriggerServerEvent('euhtesserieuxmek')
                  else
                      RageUI.Button("Retirer argent société", nil, {RightLabel = ""}, true, function(H, A, S)
                          if S then
                              amount = Extasy.KeyboardInput("Combien souhaitez-vous retirer ?", "", 20)
                              if amount ~= nil and amount ~= "" then
                                  amount = ESX.Math.Round(tonumber(amount))
                                  if amount > 0 then
                                      TriggerServerEvent('Society:withdrawwMoney', society, amount)
                                      ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
                                        societymoney = ESX.Math.GroupDigits(money)
                                      end, society)
                                  else
                                      Extasy.ShowNotification("~r~Action impossible")
                                  end
                              end
                          end
                      end)
                  end
              end
          
              if options.deposit then
                  if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unemployed' then 
                    TriggerServerEvent('euhtesserieuxmek')
                  else
                      RageUI.Button("Déposer argent société", nil, {RightLabel = ""}, true, function(H, A, S)
                          if S then
                              amount = Extasy.KeyboardInput("Combien souhaitez-vous retirer ?", "", 20)
                              if amount ~= nil and amount ~= "" then
                                  amount = ESX.Math.Round(tonumber(amount))
                                  if amount > 0 then
                                      TriggerServerEvent('Society:deposittMoney', society, amount)
                                      ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
                                        societymoney = ESX.Math.GroupDigits(money)
                                      end, society)
                                  else
                                      Extasy.ShowNotification("~r~Action impossible")
                                  end
                              end
                          end
                      end)
                  end
              end
          
              if playerJob == "oceanview" or playerJob == "bikeshop" or playerJob == "boatshop" then
                  if playerJob == 'unemployed' then 
                      TriggerServerEvent('euhtesserieuxmek')
                  else
                      RageUI.Button("Blanchir de l'argent", nil, {RightLabel = ""}, true, function(H, A, S)
                          if S then
                              amount = Extasy.KeyboardInput("Combien souhaitez-vous Blanchir ?", "", 20)
                              if amount ~= nil and amount ~= "" then
                                  amount = ESX.Math.Round(tonumber(amount))
                                  if amount > 0 then
                                      TriggerServerEvent('Society:washMoney', amount)
                                  else
                                      Extasy.ShowNotification("~r~Action impossible")
                                  end
                              end
                          end
                      end)
                  end
              end
          
              if options.employees then
                  if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unemployed' then 
                    TriggerServerEvent('euhtesserieuxmek')
                  else
                      RageUI.Button("Liste des employés", nil, {}, true, function(h, a, s)
                          if s then
                              ESX.TriggerServerCallback('Society:GetListeJob', function(list)
                                    jobListe = list
                              end, society)
                              filterstring = nil
                          end
                      end, RMenu:Get('society_boss_menu', 'society_employee_list'))
                  end
              end
            
              if options.grades then
                if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unemployed' then 
                    TriggerServerEvent('euhtesserieuxmek')
                else
                    -- Gestion des salaires
                end
              end

              end, function()
              end)

              RageUI.IsVisible(RMenu:Get('society_boss_menu', 'society_employee_list'), true, true, true, function()

                  RageUI.Button("Rechercher", false, {RightLabel = filterstring}, true, function(h, a, s)
                      if s then
                          filterstring = Extasy.KeyboardInput("entysearch", "~b~Rechercher", "", 50)
                      end
                  end)

                  RageUI.Separator("↓ ~b~Liste ~s~↓")

                  for i = 1, #jobListe, 1 do
                      if filterstring == nil or string.find(jobListe[i].prenom, filterstring) then
                          RageUI.ButtonWithStyle(jobListe[i].prenom.." "..jobListe[i].nom, nil, {RightLabel = 'Virer'}, true, function(h, a, s)
                              if s then
                                  TriggerServerEvent('Society:KickPlayerForBossMenu', jobListe[i].identifier)
                                  Extasy.ShowNotification("La personne a été viré")
                                  RageUI.CloseAll()
                                  society_open_menu = false
                              end
                          end)
                      end
                  end
                
              end, function()
              end)
          end
      end)
  end
end

openBossMenu = function(society, options)
    RageUI.Visible(RMenu:Get('society_boss_menu', 'main_menu'), true)
    ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
        societymoney = ESX.Math.GroupDigits(money)
        Wait(50)
        OpenBossMenu_m(society, options, societymoney)
    end, society)
end



















society_farm_data = {}
tenue_menu  = false
garage_menu = false
public_society_chest_openned  = false
society_shop_list_menu = false
society_shop_list_obj_menu = false
society_ped_menu = false
tenue_menu            = false
local defaultskin     = {}
local clothes_notspam = {}
local defaultskincool = false
local defaultskin = {}
local index = 1
local lastCoordsData = {}
local count_i = {
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15"
}

RMenu.Add('society_work', 'main_menu', RageUI.CreateMenu("Société", "Que souhaitez-vous faire ?", 1, 100))
RMenu:Get('society_work', 'main_menu').Closed = function()
    tenue_menu = false
end

RMenu.Add('society_work', 'garage_menu', RageUI.CreateMenu("Garage", "Que souhaitez-vous faire ?", 1, 100))
RMenu:Get('society_work', 'garage_menu').Closed = function()
    garage_menu = false
end

RMenu.Add('society_work', 'clothes_menu', RageUI.CreateMenu("Vestiaire Société", "Que souhaitez-vous faire ?", 1, 100))
RMenu.Add('society_work', 'my_clothes', RageUI.CreateSubMenu(RMenu:Get('society_work', 'clothes_menu'), "Vestiaire Société", "Que souhaitez-vous faire ?"))
RMenu:Get('society_work', 'clothes_menu').Closed = function()
    tenue_menu = false

    TriggerEvent("skinchanger:loadPlayerSkin", playerSkin)
end

RMenu.Add('society_shop_list', 'main_menu', RageUI.CreateMenu("Achats", "Que souhaitez-vous acheter ?", 1, 100))
RMenu:Get('society_shop_list', 'main_menu').Closed = function()
    society_shop_list_menu = false
end

RMenu.Add('society_shop_list_obj', 'main_menu', RageUI.CreateMenu("Menu entreprise", "Que souhaitez-vous faire ?", 1, 100))
RMenu:Get('society_shop_list_obj', 'main_menu').Closed = function()
    society_shop_list_obj_menu = false
end

RMenu.Add('society_peds_menu', 'main_menu', RageUI.CreateMenu("Peds", "Quel ped souhaitez-vous mettre ?", 1, 100))
RMenu:Get('society_peds_menu', 'main_menu').Closed = function()
    society_ped_menu = false
end

RMenu.Add('society_public_chest', 'main_menu', RageUI.CreateMenu("Coffre d'entreprise", "Que souhaitez-vous faire ?", 1, 100))
RMenu.Add('society_public_chest', 'remove_chest', RageUI.CreateSubMenu(RMenu:Get('society_public_chest', 'main_menu'), "Prendre", nil))
RMenu.Add('society_public_chest', 'deposite_chest', RageUI.CreateSubMenu(RMenu:Get('society_public_chest', 'main_menu'), "Déposer", nil))
RMenu:Get('society_public_chest', 'main_menu').Closed = function()
    public_society_chest_openned = false
end

CreateThread(function()
    while true do
        local near_point = false
        local ped        = GetPlayerPed(-1)
        local pedCoords  = GetEntityCoords(ped)

        for k,v in pairs(society_farm_data) do
            if v.pos ~= nil then
                local dst   = GetDistanceBetweenCoords(v.pos, pedCoords, true)
                local _size = v.size or 3.0
                local _msg  = v.msg or "~b~Appuyez sur ~INPUT_CONTEXT~ pour interagir"
                local _exp  = v.exp or 50

                if _size ~= nil then
                    if dst <= _size then
                        near_point = true
                        if v.type == 1 then
                            Extasy.ShowHelpNotification(_msg)
                            if IsControlJustReleased(1, 38) then
                                if IsPedInAnyVehicle(ped, false) then
                                    Extasy.ShowNotification("~r~Vous ne pouvez pas interagir en étant dans un véhicule")
                                else
                                    lastCoordsData.farm = v.pos
                                    startSocietyFarm(v.item, v.time, v.count)
                                end
                            end
                        elseif v.type == 2 then
                            Extasy.ShowHelpNotification(_msg)
                            if IsControlJustReleased(1, 38) then
                                if IsPedInAnyVehicle(ped, false) then
                                    Extasy.ShowNotification("~r~Vous ne pouvez pas interagir en étant dans un véhicule")
                                else
                                    lastCoordsData.transform = v.pos
                                    startSocietyTransform(v.item, v.time, v.item_g, v.count)
                                end
                            end
                        elseif v.type == 3 then
                            Extasy.ShowHelpNotification(_msg)
                            if IsControlJustReleased(1, 38) then
                                if IsPedInAnyVehicle(ped, false) then
                                    Extasy.ShowNotification("~r~Vous ne pouvez pas interagir en étant dans un véhicule")
                                else
                                    lastCoordsData.sell = v.pos
                                    startSocietySell(v.item, v.time, v.price, v.society)
                                end
                            end
                        elseif v.type == 4 then
                            Extasy.ShowHelpNotification(_msg)
                            if IsControlJustReleased(1, 38) then
                                if not tenue_menu then
                                    TriggerServerEvent("Extasy:GetTenues")
                                    TriggerServerEvent("Jobs:getAllWears", playerJob)
                                    while playerSocietyWears == {} do Wait(1) end
                                    RageUI.Visible(RMenu:Get('society_work', 'clothes_menu'), true)
                                    open_tenue()
                                else
                                    tenue_menu = false
                                    RageUI.CloseAll()
                                end
                            end
                        elseif v.type == 5 then
                            Extasy.ShowHelpNotification(_msg)
                            if IsControlJustReleased(1, 38) then
                                if not garage_menu then
                                    RageUI.Visible(RMenu:Get('society_work', 'garage_menu'), true)
                                    open_society_garage(v.name, v.name_garage, v.garage, v.need_service, v.spawnPoint)
                                else
                                    garage_menu = false
                                    RageUI.CloseAll()
                                end
                            end
                        elseif v.type == 6 then
                            if Extasy.IsPatron(ESX.PlayerData.job.grade_name, tonumber(playerJob_grade)) then
                                Extasy.ShowHelpNotification(_msg)
                                if IsControlJustReleased(1, 38) then
                                    if not boss_menu_openned then
                                        openBossMenu(playerJob)
                                    else
                                        RageUI.CloseAll()
                                        boss_menu_openned = false
                                    end
                                end
                            else
                                Extasy.ShowHelpNotification("~r~Vous n'avez pas accès à cela")
                            end
                        elseif v.type == 7 then
                            Extasy.ShowHelpNotification(_msg)
                            if IsControlJustReleased(1, 38) then
                                if IsPedInAnyVehicle(GetPlayerPed(-1), true) then 
                                    local v = GetVehiclePedIsIn(PlayerPedId())
                                    TaskLeaveVehicle(PlayerPedId(), v)
                                    Wait(2500)
                                    NetworkFadeOutEntity(v, true, false)
                                    Wait(2000)
                                    DeleteVehicle(v)
                                else
                                    Extasy.ShowNotification("~r~Vous devez être dans le véhicule")
                                end
                            end
                        elseif v.type == 8 then
                            Extasy.ShowHelpNotification(_msg)
                            if IsControlJustReleased(1, 38) then
                                if not society_shop_list_menu then
                                    if v.newTitle ~= nil then
                                        RMenu:Get('society_shop_list', 'main_menu'):SetTitle(v.newTitle)
                                    else
                                        RMenu:Get('society_shop_list', 'main_menu'):SetTitle("Achats")
                                    end

                                    if v.ppa then
                                        for _,itm in pairs(playerInventory) do
                                            if itm.name == "Permis_arme" then
                                                playerGotPPA = true
                                            end
                                        end
                                    end
                                    
                                    RageUI.Visible(RMenu:Get('society_shop_list', 'main_menu'), true)
                                    openSocietyListMenu(v.list, v.ppa, playerGotPPA, v.billing, v)
                                else
                                    society_shop_list_menu = false
                                    RageUI.CloseAll()
                                end
                            end
                        elseif v.type == 9 then
                            Extasy.ShowHelpNotification(_msg)
                            if IsControlJustReleased(1, 38) then
                                if not public_society_chest_openned then
                                    RageUI.Visible(RMenu:Get('society_public_chest', 'main_menu'), true)
                                    openSocietyChestMenu(playerJob)
                                else
                                    RageUI.CloseAll()
                                    public_society_chest_openned = false
                                end
                            end
                        elseif v.type == 10 then
                            Extasy.ShowHelpNotification(_msg)
                            if IsControlJustReleased(1, 38) then
                                if not society_ped_menu then              
                                    RageUI.Visible(RMenu:Get('society_peds_menu', 'main_menu'), true)
                                    openPedSocietyMenu(v.peds)
                                else
                                    RageUI.CloseAll()
                                    society_ped_menu = false
                                end
                            end
                        elseif v.type == 11 then
                            Extasy.ShowHelpNotification(_msg)
                            if IsControlJustReleased(1, 38) then
                                if not society_shop_list_obj_menu then
                                    RageUI.Visible(RMenu:Get('society_shop_list_obj', 'main_menu'), true)
                                    openSocietyListObjMenu(v.list)
                                else
                                    society_shop_list_obj_menu = false
                                    RageUI.CloseAll()
                                end
                            end
                        elseif v.type == 12 then
                            Extasy.ShowHelpNotification(_msg)
                            if IsControlJustReleased(1, 38) then
                                SetEntityCoords(ped, v.to)
                            end
                        end
                        if v.marker then
                            DrawMarker(6, v.pos.x, v.pos.y, v.pos.z - 1.0, nil, nil, nil, -90, nil, nil, _size, _size, _size, 100, 0, 200, 100, false, false)
                        end
                    end
                end
            end
        end

        if near_point then
            Wait(1)
        else
            Wait(1000)
        end
    end
end)

refreshChestSociety = function(society)
    ESX.TriggerServerCallback('societyChest:getPlayerInventory', function(inventory)
        inventoryChest = inventory.items
    end)

    ESX.TriggerServerCallback('societyChest:getSharedInventory', function(items)
        allChestItems = items
    end, society)

    while inventoryChest == nil do Wait(1) end
    while allChestItems == nil do Wait(1) end
end

openSocietyChestMenu = function(society)
    refreshChestSociety(society)

    if not public_society_chest_openned then
        public_society_chest_openned = true
        Citizen.CreateThread(function()
            while public_society_chest_openned do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('society_public_chest', 'main_menu'), true, true, true, function()

                    RageUI.ButtonWithStyle("Prendre", nil, {RightLabel = "→→→"}, true, function()
                    end, RMenu:Get('society_public_chest', 'remove_chest'))
                    RageUI.ButtonWithStyle("Déposer", nil, {RightLabel = "→→→"}, true, function()
                    end, RMenu:Get('society_public_chest', 'deposite_chest'))

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('society_public_chest', 'remove_chest'), true, true, true, function()

                    for i=1, #allChestItems, 1 do
                        if allChestItems[i].count ~= 0 then
                            RageUI.ButtonWithStyle("x"..allChestItems[i].count.." "..allChestItems[i].label, nil, {RightLabel = "→→→"},true, function(h, a, s)
                                if s then   
                                    local k = Extasy.KeyboardInput("Combien voulez-vous prendre de '"..allChestItems[i].label.."' ?", "", 20)
                                    k = tonumber(k)

                                    if k ~= nil then
                                        if k > allChestItems[i].count or k < 1 then
                                            Extasy.ShowNotification("~r~Quantité invalide")
                                        else
                                            if string.sub(k, 1, string.len("-")) == "-" then
                                                Extasy.ShowNotification("~r~Quantité invalide")
                                            else
                                                TriggerServerEvent('societyChest:takeStockItem', allChestItems[i].name, k, society)
                                                refreshChestSociety(society)
                                                Wait(10)
                                                RageUI.GoBack()
                                            end
                                        end
                                    else
                                        Extasy.ShowNotification("~r~Quantité invalide")
                                    end
                                end
                            end)
                        end
                    end

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('society_public_chest', 'deposite_chest'), true, true, true, function()

                    for i=1, #inventoryChest, 1 do
                        if inventoryChest[i].count > 0 then
                            RageUI.ButtonWithStyle("x"..inventoryChest[i].count.." "..inventoryChest[i].label, nil, {RightLabel = "→→→"},true, function(h, a, s)
                                if s then   
                                    local k = Extasy.KeyboardInput("Combien voulez-vous déposer de '"..inventoryChest[i].label.."' ?", "", 20)
                                    k = tonumber(k)

                                    if k ~= nil then
                                        if k > inventoryChest[i].count or k < 1 then
                                            Extasy.ShowNotification("~r~Quantité invalide")
                                        else
                                            if string.sub(k, 1, string.len("-")) == "-" then
                                                Extasy.ShowNotification("~r~Quantité invalide")
                                            else
                                                TriggerServerEvent('societyChest:DepositStockItem', inventoryChest[i].name, k, society)
                                                refreshChestSociety(society)
                                                Wait(10)
                                                RageUI.GoBack()
                                            end
                                        end
                                    else
                                        Extasy.ShowNotification("~r~Quantité invalide")
                                    end
                                end
                            end)
                        end
                    end

                end, function()
                end)   
            end
        end)
    end
end

open_tenue = function()
    if tenue_menu then
        tenue_menu = false
        return
    else
        tenue_menu = true
        CreateThread(function()
            while tenue_menu do
                Wait(1)
                
                RageUI.IsVisible(RMenu:Get('society_work', 'clothes_menu'), true, true, true, function()

                    if Extasy.IsPatron(ESX.PlayerData.job.grade_name, tonumber(playerJob_grade)) then
                        RageUI.Button("Ajouter une tenue", nil, {}, true, function(H, A, S) end, RMenu:Get('society_work', 'my_clothes'))
                    end

                    RageUI.Button("Tenue de civil", nil, {}, true, function(Hovered, Active, Selected) 
                        if (Selected) then
                            RageUI.CloseAll()
                            tenue_menu = false
                            playerInService = false
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
								local isMale = skin.sex == 0
								TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
									ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
										TriggerEvent('skinchanger:loadSkin', skin)
                                        TriggerEvent('skinchanger:loadClothes', skin, defaultskin)
                                        playerSkin =  defaultskin
                                        defaultskin = nil
                                        defaultskincool = false
									end)
								end)
							end)
                            in_service = false
                            if playerJob == "vcpd" then
                                playerInService = false
                                TriggerServerEvent("Jobs:sendMsgToJobClients", 2, "vcpd", "~r~"..playerIdentity.prenom.." "..playerIdentity.nom.."~s~ vient de prendre sa fin de service")
                            end

                            --TriggerServerEvent("Jobs:remove", playerJob, GetPlayerServerId(GetPlayerIndex()))
                            playerInServiceLoop = false
                        end			
                    end)

                    if #playerSocietyWears > 0 then
                        RageUI.Separator("")
                    else
                        RageUI.Separator("")
                        RageUI.Separator("~r~Aucune tenue")
                        RageUI.Separator("")
                    end

                    for i,l in pairs(playerSocietyWears) do
                        if Extasy.IsPatron(ESX.PlayerData.job.grade_name, tonumber(playerJob_grade)) then
                            t = "Appuyez sur ← pour supprimer cette tenue"
                        else
                            t = nil
                        end

                        RageUI.ButtonWithStyle("Tenue #"..l.id.." '"..l.societyWearName.."'", t, {}, true, function(H, A, S) 
                            if H then
                                TriggerEvent("skinchanger:getSkin", function(skin)
                                    local d = json.decode(l.societyClothes)
                                    print(d)
                                    TriggerEvent("skinchanger:loadClothes", skin, d)
                                    TriggerEvent("skinchanger:loadClothes", skin, d)
                                end)
                            end

                            if Extasy.IsPatron(ESX.PlayerData.job.grade_name, tonumber(playerJob_grade)) then
                                if A then
                                    if IsControlJustPressed(1, 308) then
                                        TriggerServerEvent("Jobs:removeWearFromThisID", l.id, playerJob)
                                        playerSocietyWears = {}
                                        TriggerServerEvent("Jobs:getAllWears", playerJob)
                                        while playerSocietyWears == {} do Wait(1) end
                                    end
                                end
                            end

                            if S then
                                if playerJob == "vcpd" then
                                    playerInService = true
                                    TriggerServerEvent("Jobs:sendMsgToJobClients", 2, "vcpd", "~g~"..playerIdentity.prenom.." "..playerIdentity.nom.."~s~ vient de prendre son service")
                                end

                                local d = json.decode(l.societyClothes)

                                if d.type ~= 'ped' then
                                    if not defaultskincool then
                                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                            local isMale = skin.sex == 0
                                            --TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                                    local d = json.decode(l.societyClothes)
                                                    TriggerEvent('skinchanger:loadSkin', skin)
                                                    TriggerEvent('skinchanger:loadClothes', skin, d)
                                                end)
                                            --end)
                                        end)
                                        defaultskincool = true
                                    else
                                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                            local isMale = skin.sex == 0
                                            --TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                                    local d = json.decode(l.societyClothes)
                                                    TriggerEvent('skinchanger:loadSkin', skin)
                                                    TriggerEvent('skinchanger:loadClothes', skin, d)
                                                end)
                                            --end)
                                        end)
                                    end
                                else
                                    if extasy_core_cfg["player_can_have_ped"] then
                                        Extasy.SpawnPed(d.name)
                                    else
                                        Extasy.ShowNotification("~r~Vous n'avez pas le grade nécessaire pour accéder cette fonctionnalité.~n~Vous devez être minimum:\n~y~GOLDEN")
                                    end
                                end

                                TriggerEvent("skinchanger:getSkin", function(skin)
                                    playerSkin = skin
                                end)
                            end			
                        end)
                    end

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('society_work', 'my_clothes'), true, true, true, function()

                    for k,v in pairs(playerClothes) do
                        RageUI.Button("Tenue #"..k.." '"..v.label.."'", nil, {}, true, function(h, a, s)
                            if h then
                                if h then
                                    TriggerEvent("skinchanger:getSkin", function(skin)
                                        local d = json.decode(v.tenue)
                                        TriggerEvent("skinchanger:loadClothes", skin, d)
                                        TriggerEvent("skinchanger:loadClothes", skin, d)
                                    end)
                                end
                            end
                            if s then
                                TriggerEvent("skinchanger:getSkin", function(skin)
                                    local d = json.decode(v.tenue)
                                    TriggerEvent("skinchanger:loadClothes", skin, d)
                                    TriggerEvent("skinchanger:loadClothes", skin, d)
                                    TriggerServerEvent("Jobs:addNewWear", playerJob, v.tenue, v.label)
                                    TriggerServerEvent("Jobs:getAllWears", playerJob)
                                    while playerSocietyWears == {} do Wait(1) end
                                end)
                                RageUI.GoBack()
                            end
                        end)
                    end
                
                end, function()
                end)
                
            end
        end)
    end
end

open_society_garage = function(name, name_garage, list, need, spawnPoint, livery)
    garage_menu = true
    CreateThread(function()
        while garage_menu do
            Wait(1)
            RageUI.IsVisible(RMenu:Get('society_work', 'garage_menu'), true, true, true, function()
                if playerJob == 'pizza' then
                    RageUI.Button("Commencer une livraison", nil, {RightLabel = "→→→"},true, function(h, a, s)
                        if s then
                            startPizzaLivraison()
                        end
                    end)
                end
                for k,v in pairs(list) do
                    RageUI.Button(v.name, nil, {}, true, function(h, a, s) 
                        if (s) then
                            local pos, heading = searchPlace(spawnPoint)
                            local _livery = v.livery or false
                            local _color = v.color or false

                            if _livery ~= false then
                                if _color ~= false then
                                    spawnVehicle(v.hash, pos, heading, _livery, _color, v.props)
                                else
                                    spawnVehicle(v.hash, pos, heading, _livery, false, v.props)
                                end
                            else
                                if _color ~= false then
                                    spawnVehicle(v.hash, pos, heading, false, _color, v.props)
                                else
                                    spawnVehicle(v.hash, pos, heading, false, false, v.props)
                                end
                            end
                        end			
                    end) 
                end
            end, function()
            end)
        end
    end)
end

spawnVehicle = function(model, coords, heading, livery, color, props)
    if coords then
        if livery ~= false then
            if color ~= false then
                Extasy.SpawnVehicle(model, coords, heading, function (vehicle) 
                    local vProps = Extasy.GetVehicleProperties(vehicle)
                    SetVehicleLivery(vehicle, livery)
                    SetVehicleColours(vehicle, color, color)
                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
                    if props ~= nil then
                        Extasy.SetVehicleProperties(vehicle, props)
                    end
                    Extasy.ShowNotification("~g~Vous avez reçu les clés du véhicule '"..vProps.plate.."'")
                    TriggerServerEvent('carlock:location', vProps.plate)
                end)
            else
                Extasy.SpawnVehicle(model, coords, heading, function (vehicle) 
                    local vProps = Extasy.GetVehicleProperties(vehicle)
                    SetVehicleLivery(vehicle, livery)
                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
                    if props ~= nil then
                        Extasy.SetVehicleProperties(vehicle, props)
                    end
                    Extasy.ShowNotification("~g~Vous avez reçu les clés du véhicule '"..vProps.plate.."'")
                    TriggerServerEvent('carlock:location', vProps.plate)
                end)
            end
        else
            if color ~= false then
                Extasy.SpawnVehicle(model, coords, heading, function (vehicle) 
                    local vProps = Extasy.GetVehicleProperties(vehicle)
                    SetVehicleColours(vehicle, color, color)
                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
                    if props ~= nil then
                        Extasy.SetVehicleProperties(vehicle, props)
                    end
                    Extasy.ShowNotification("~g~Vous avez reçu les clés du véhicule '"..vProps.plate.."'")
                    TriggerServerEvent('carlock:location', vProps.plate)
                end)
            else
                Extasy.SpawnVehicle(model, coords, heading, function (vehicle) 
                    local vProps = Extasy.GetVehicleProperties(vehicle)
                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
                    if props ~= nil then
                        Extasy.SetVehicleProperties(vehicle, props)
                    end
                    Extasy.ShowNotification("~g~Vous avez reçu les clés du véhicule '"..vProps.plate.."'")
                    TriggerServerEvent('carlock:location', vProps.plate)
                end)
            end
        end
        RageUI.CloseAll()
        garage_menu = false
    else
        Extasy.ShowNotification("~r~Aucune sortie de véhicule disponible")
    end
end

searchPlace = function(table)
    local found = false
    local pos = nil
    local heading = nil
    for k,v in pairs(table) do
        if Extasy.IsSpawnPointClear(v.pos, 3.0) then
            found = true
            pos = v.pos
            heading = v.heading
        end
    end
    if not found then
        return false
    else
        return pos, heading
    end
end

openPedSocietyMenu = function(peds)
    if society_ped_menu then
        society_ped_menu = false
        return
    else
        society_ped_menu = true
        CreateThread(function()
            while society_ped_menu do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('society_peds_menu', 'main_menu'), true, true, true, function()

                    RageUI.Button("Ped de base", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                        if s then
                            TriggerEvent("skinchanger:LoadForTheFirsTime", playerSkin)
                        end
                    end)

                    RageUI.Separator("")

                    for k,v in pairs(peds) do
                        RageUI.Button(v.name, nil, {RightLabel = "→→→"}, true, function(h, a, s)
                            if s then
                                Extasy.SpawnPed(v.hash)
                            end
                        end)
                    end

                end, function()
                end)
            end
        end)
    end
end

function openSocietyListObjMenu(data)
    if society_shop_list_ojb_menu then
        society_shop_list_ojb_menu = false
        return
    else
        society_shop_list_ojb_menu = true
        Citizen.CreateThread(function()
            while society_shop_list_ojb_menu do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('society_shop_list_obj', 'main_menu'), true, true, true, function()

                    for k,v in pairs(data) do
                        RageUI.Button(v.name, nil, {RightLabel = v.rLabel.." ("..v.nCount..")"}, true, function(H, A, S)
                            if S then
                                local tCount = Extasy.getItemCount(v.nName)

                                if tCount >= v.nCount then
                                    v.event()
                                else
                                    Extasy.ShowNotification(v.notEnoughMsg)
                                end
                            end
                        end)
                    end

                end, function()
                end)
            end
        end)
    end
end

function openSocietyListMenu(data, ppa, doesHave, billing, tableData)
    if society_shop_list_menu then
        society_shop_list_menu = false
        return
    else
        society_shop_list_menu = true
        Citizen.CreateThread(function()
            local t = nil
            if billing then
                t = extasy_core_cfg["available_payments_billing_society"]
            else
                t = extasy_core_cfg["available_payments_billing"]
            end
            while society_shop_list_menu do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('society_shop_list', 'main_menu'), true, true, true, function()

                    RageUI.List("Mode de paiement", extasy_core_cfg["available_payments_billing"], index, nil, {}, true, function(h, a, s, Index)
                        index = Index
                    end)

                    RageUI.Separator("")

                    for k,v in pairs(data) do
                        if v.boss then
                            if IsPatron(playerJob, tonumber(playerJob_grade)) then
                                if v.index > 1 then
                                    RageUI.List(v.name.." ("..v.price.."$)", count_i, v.index, "Acheter "..v.index.." "..v.name.." vous coutera "..Extasy.Math.GroupDigits(v.index * v.price).."$", {}, true, function(h, a, s, shop)
                                        v.index = shop
                                        if s then
                                            if tableData.anim then
                                                if type(tableData.anim) == 'function' then
                                                    tableData.anim(v.waitCook)
                                                end
                                            end
                                            if v.waitCook then
                                                TriggerEvent("core:drawBar", v.waitCook, "⏳ Préparation en cours...")
                                                Citizen.Wait(v.waitCook)
                                            end
                                            v.method = index
                                            v.needPpa = ppa

                                            TriggerServerEvent("society:buyItem", v)
                                        end
                                    end)
                                else
                                    RageUI.List(v.name.." ("..v.price.."$)", count_i, v.index, nil, {}, true, function(h, a, s, Index)
                                        v.index = Index
                                        if s then
                                            if tableData.anim then
                                                if type(tableData.anim) == 'function' then
                                                    tableData.anim(v.waitCook)
                                                end
                                            end
                                            if v.waitCook then
                                                TriggerEvent("core:drawBar", v.waitCook, "⏳ Préparation en cours...")
                                                Citizen.Wait(v.waitCook)
                                            end
                                            v.method = index
                                            v.needPpa = ppa

                                            TriggerServerEvent("society:buyItem", v)
                                        end
                                    end)
                                end
                            else
                                RageUI.List("~c~"..v.name.." ("..v.price.."$)", count_i, v.index, nil, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(h, a, s, Index)
                                    v.index = Index
                                end)
                            end
                        else
                            if v.index > 1 then
                                RageUI.List(v.name.." ("..v.price.."$)", count_i, v.index, "Acheter "..v.index.." "..v.name.."s vous coutera "..Extasy.Math.GroupDigits(v.index * v.price).."$", {}, true, function(h, a, s, shop)
                                    v.index = shop
                                    if s then
                                        if tableData.anim then
                                            if type(tableData.anim) == 'function' then
                                                tableData.anim(v.waitCook)
                                            end
                                        end
                                        if v.waitCook then
                                            TriggerEvent("core:drawBar", v.waitCook, "⏳ Préparation en cours...")
                                            Citizen.Wait(v.waitCook)
                                        end
                                        v.method = index
                                        v.needPpa = ppa

                                        TriggerServerEvent("society:buyItem", v)
                                    end
                                end)
                            else
                                RageUI.List(v.name.." ("..v.price.."$)", count_i, v.index, nil, {}, true, function(h, a, s, Index)
                                    v.index = Index
                                    if s then
                                        if tableData.anim then
                                            if type(tableData.anim) == 'function' then
                                                tableData.anim(v.waitCook)
                                            end
                                        end
                                        if v.waitCook then
                                            TriggerEvent("core:drawBar", v.waitCook, "⏳ Préparation en cours...")
                                            Citizen.Wait(v.waitCook)
                                        end
                                        v.method = index
                                        v.needPpa = ppa

                                        TriggerServerEvent("society:buyItem", v)
                                    end
                                end)
                            end
                        end
                    end

                end, function()
                end)
            end
        end)
    end
end

spawnVehicle = function(model, coords, heading, livery, color, props)
    if coords then
        if livery ~= false then
            if color ~= false then
                Extasy.SpawnVehicle(model, coords, heading, function (vehicle) 
                    local vProps = Extasy.GetVehicleProperties(vehicle)
                    SetVehicleLivery(vehicle, livery)
                    SetVehicleColours(vehicle, color, color)
                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
                    if props ~= nil then
                        Extasy.SetVehicleProperties(vehicle, props)
                    end
                    Extasy.ShowNotification("~g~Vous avez reçu les clés du véhicule '"..vProps.plate.."'")
                    TriggerServerEvent('carlock:location', vProps.plate)
                end)
            else
                Extasy.SpawnVehicle(model, coords, heading, function (vehicle) 
                    local vProps = Extasy.GetVehicleProperties(vehicle)
                    SetVehicleLivery(vehicle, livery)
                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
                    if props ~= nil then
                        Extasy.SetVehicleProperties(vehicle, props)
                    end
                    Extasy.ShowNotification("~g~Vous avez reçu les clés du véhicule '"..vProps.plate.."'")
                    TriggerServerEvent('carlock:location', vProps.plate)
                end)
            end
        else
            if color ~= false then
                Extasy.SpawnVehicle(model, coords, heading, function (vehicle) 
                    local vProps = Extasy.GetVehicleProperties(vehicle)
                    SetVehicleColours(vehicle, color, color)
                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
                    if props ~= nil then
                        Extasy.SetVehicleProperties(vehicle, props)
                    end
                    Extasy.ShowNotification("~g~Vous avez reçu les clés du véhicule '"..vProps.plate.."'")
                    TriggerServerEvent('carlock:location', vProps.plate)
                end)
            else
                Extasy.SpawnVehicle(model, coords, heading, function (vehicle) 
                    local vProps = Extasy.GetVehicleProperties(vehicle)
                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
                    if props ~= nil then
                        Extasy.SetVehicleProperties(vehicle, props)
                    end
                    Extasy.ShowNotification("~g~Vous avez reçu les clés du véhicule '"..vProps.plate.."'")
                    TriggerServerEvent('carlock:location', vProps.plate)
                end)
            end
        end
        RageUI.CloseAll()
        garage_menu = false
    else
        Extasy.ShowNotification("~r~Aucune sortie de véhicule disponible")
    end
end




















startSocietyFarm = function(item, time, count)
    if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
        local oldTime   = GetGameTimer()
        playerIsPlayingFarm = true
        local _time     = time or 3500
        local _count    = count or 1
        local ped       = PlayerPedId()
        local pCoords   = GetEntityCoords(ped)
        local pDst      = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, lastCoordsData.farm.x, lastCoordsData.farm.y, lastCoordsData.farm.z, false)

        -- if pDst > 5.0 then
        --     playerIsPlayingFarm = false
        --     FreezeEntityPosition(GetPlayerPed(-1), false)
        --     TriggerEvent("api:stopUI")
        --     Extasy.print("societyFarm", "^1Player is glitching, removing all society farm data now")
        -- end

        TriggerEvent("eCore:AfficherBar", _time, "⏳ Récolte en cours...")

        Extasy.StartInteractAnimation()

        Citizen.CreateThread(function()
            while playerIsPlayingFarm do
                FreezeEntityPosition(GetPlayerPed(-1), true)

                if playerIsDead then
                    Extasy.ShowNotification("~r~Vous ne pouvez pas interagir en étant dans le coma")

                    playerIsPlayingFarm = false
                    FreezeEntityPosition(ped, false)
                    --TriggerEvent("api:stopUI")
                end

                Wait(1)
            end
        end)

        Citizen.CreateThread(function()
            while playerIsPlayingFarm do
                Extasy.ShowHelpNotification("~p~Appuyez sur [E] pour annuler l'animation")
                if IsControlJustReleased(1, 38) then
                    playerIsPlayingFarm = false
                    FreezeEntityPosition(GetPlayerPed(-1), false)
                    --TriggerEvent("api:stopUI")
                end
                Wait(1)
            end
        end)

        while playerIsPlayingFarm do
            if oldTime + _time < GetGameTimer() then
                oldTime = GetGameTimer()
                --TriggerServerEvent("Extasy:GiveFarmItem", item, _count, Extasy.GetPlayerCapacity())
                TriggerServerEvent("Extasy:GiveFarmItem", item, _count)
                if not playerCanBypassE then
                    playerIsPlayingFarm = false
                    FreezeEntityPosition(GetPlayerPed(-1), false)
                end
                if playerCanBypassE then
                    playerIsPlayingFarm = false
                    startSocietyFarm(item, time, count)
                end
            end

            Wait(0)
        end
    else
        Extasy.ShowNotification("~r~Vous ne pouvez pas réaliser cette action en étant dans un véhicule")
    end
end

startSocietyTransform = function(item, time, item_g, count)
    if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
        local oldTime   = GetGameTimer()
        playerIsPlayingFarm = true
        local _time     = time or 3500
        local _count    = count or 1
        local ped       = PlayerPedId()
        local pCoords   = GetEntityCoords(ped)
        local pDst      = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, lastCoordsData.transform.x, lastCoordsData.transform.y, lastCoordsData.transform.z, false)

        -- if pDst > 5.0 then
        --     playerIsPlayingFarm = false
        --     FreezeEntityPosition(GetPlayerPed(-1), false)
        --     TriggerEvent("api:stopUI")
        --     Extasy.print("societyFarm", "^1Player is glitching, removing all society farm data now")
        -- end

        TriggerEvent("eCore:AfficherBar", _time, "⏳ Traitement en cours...")

        Extasy.StartInteractAnimation()

        Citizen.CreateThread(function()
            while playerIsPlayingFarm do
                FreezeEntityPosition(ped, true)

                if playerIsDead then
                    Extasy.ShowNotification("~r~Vous ne pouvez pas interagir en étant dans le coma")

                    playerIsPlayingFarm = false
                    FreezeEntityPosition(ped, false)
                    --TriggerEvent("api:stopUI")
                end

                Wait(1)
            end
        end)

        Citizen.CreateThread(function()
            while playerIsPlayingFarm do
                Extasy.ShowHelpNotification("~p~Appuyez sur [E] pour annuler l'animation")
                if IsControlJustReleased(1, 38) then
                    playerIsPlayingFarm = false
                    FreezeEntityPosition(ped, false)
                    --TriggerEvent("api:stopUI")
                end
                Wait(1)
            end
        end)

        while playerIsPlayingFarm do
            if oldTime + _time < GetGameTimer() then
                --local iCount = Extasy.getItemCount(item)
                oldTime = GetGameTimer()
                --TriggerServerEvent("Extasy:ExhangeFarmItem", item, item_g, Extasy.GetPlayerCapacity())
                TriggerServerEvent("Extasy:ExhangeFarmItem", item, item_g)
                if not playerCanBypassE then
                    playerIsPlayingFarm = false
                    FreezeEntityPosition(ped, false)
                end
                if playerCanBypassE then
                    playerIsPlayingFarm = false
                    startSocietyTransform(item, time, item_g, count)
                end
            end

            Wait(0)
        end
    else
        Extasy.ShowNotification("~r~Vous ne pouvez pas réaliser cette action en étant dans un véhicule")
    end
end

startSocietySell = function(item, time, price, society)
    if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
        local oldTime   = GetGameTimer()
        playerIsPlayingFarm = true
        local _time     = time or 3500
        local _count    = count or 1
        local _price    = price or 100
        local ped       = PlayerPedId()
        local pCoords   = GetEntityCoords(ped)
        local pDst      = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, lastCoordsData.sell.x, lastCoordsData.sell.y, lastCoordsData.sell.z, false)

        -- if pDst > 5.0 then
        --     playerIsPlayingFarm = false
        --     FreezeEntityPosition(GetPlayerPed(-1), false)
        --     TriggerEvent("api:stopUI")
        --     Extasy.print("societyFarm", "^1Player is glitching, removing all society farm data now")
        -- end

        TriggerEvent("eCore:AfficherBar", _time, "⏳ Revente en cours...")

        Extasy.StartInteractAnimation()

        Citizen.CreateThread(function()
            while playerIsPlayingFarm do
                FreezeEntityPosition(ped, true)

                if playerIsDead then
                    Extasy.ShowNotification("~r~Vous ne pouvez pas interagir en étant dans le coma")

                    playerIsPlayingFarm = false
                    FreezeEntityPosition(ped, false)
                    --TriggerEvent("api:stopUI")
                end

                Wait(1)
            end
        end)

        Citizen.CreateThread(function()
            while playerIsPlayingFarm do
                Extasy.ShowHelpNotification("~p~Appuyez sur E pour annuler l'animation")
                if IsControlJustReleased(1, 38) then
                    playerIsPlayingFarm = false
                    FreezeEntityPosition(ped, false)
                    --TriggerEvent("api:stopUI")
                end
                Wait(1)
            end
        end)

        while playerIsPlayingFarm do
            if oldTime + _time < GetGameTimer() then
                --local iCount = Extasy.getItemCount(item)
                oldTime = GetGameTimer()
                TriggerServerEvent("Extasy:SellItemToSociety", item, _price, _count, society)
                
                if playerJob == 'tabac' then
                    TriggerServerEvent("tabac:add")
                elseif playerJob == 'oceanview' then
                    TriggerServerEvent("ocean_view:add")
                elseif playerJob == 'icecream' then
                    TriggerServerEvent("ice:add")
                end

                if not playerCanBypassE then
                    playerIsPlayingFarm = false
                    FreezeEntityPosition(ped, false)
                end
                FreezeEntityPosition(ped, false)
                if playerCanBypassE then
                    playerIsPlayingFarm = false
                    startSocietySell(item, time, price, society)
                end
            end

            Wait(0)
        end
    else
        Extasy.ShowNotification("~r~Vous ne pouvez pas réaliser cette action en étant dans un véhicule")
    end
end

registerSocietyFarmZone = function(data)
    table.insert(society_farm_data, data)
end