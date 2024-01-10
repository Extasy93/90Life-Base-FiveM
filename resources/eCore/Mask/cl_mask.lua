mask_shop_openned = false
local mask_data         = nil
local mask_data2        = nil
local maskName          = {}
local mask_num          = nil
local mask_index        = 1
local mask_notspam      = {}
local mask_enabled      = false
local index      = 1
camera_mask = nil
camera_curr_fov = nil
local index_mask = 0
local show_mask_variant = false

RMenu.Add('mask_shop', 'main_menu', RageUI.CreateMenu("Masques", "Que souhaitez-vous acheter ?", 1, 100))
RMenu:Get('mask_shop', 'main_menu').Closed = function()
    mask_shop_openned = false

    playerPed = GetPlayerPed(-1)
    if mask_enabled then
        ClearPedProp(playerPed, 0, -1, 0, 2)
        SetPedComponentVariation(playerPed, mask_data, mask_data2, index_mask, 2)
        mask_enabled = false
    else
        ClearPedProp(playerPed, 0, -1, 0, 2)
        SetPedComponentVariation(playerPed, 1, 0, 0, 2)
    end
    RenderScriptCams(0, 1, 1750, 1, 1)
    SetCamShakeAmplitude(camera_mask, 0.0)
    SetCamEffect(0)
    ClearTimecycleModifier()
    DestroyCam(camera_mask, true)
    FreezeEntityPosition(playerPed, false)
    camera_mask = nil
    show_mask_variant = false
    index_mask = 0
end

openMask_Shop_menu = function()
    if mask_shop_openned then
        mask_shop_openned = false
        return
    else
        mask_shop_openned = true
        Citizen.CreateThread(function()
            while mask_shop_openned do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('mask_shop', 'main_menu'), true, true, true, function()

                    RageUI.List("Mode de paiement", extasy_core_cfg["available_payments"], index, nil, {}, true, function(Hovered, Active, Selected, Index)
                        index = Index
                    end)

                    RageUI.Separator("")
                    RageUI.Button("Aucun masque", nil, {RightLabel = "GRATUIT"}, true, function(Hovered, Active, Selected)
                        if Active then
                            local playerPed = GetPlayerPed(-1)

                            SetPedComponentVariation(playerPed, 1, 0, 0, 2)
                        end
                    end)

                    for k,v in pairs(cfg_mask.name) do

                        if mask_num == v.num then
                            t = {RightBadge = RageUI.BadgeStyle.Mask}
                        else
                            t = {RightLabel = v.price.."$"}
                        end

                        --if GetLabelText(tostring(v.GXT)) == "NULL" then
                            if v.typ == "bandana" then
                                n = v.name
                            else
                                n = "Masque #"..k
                            end
                        --else
                            --n = GetLabelText(tostring(v.GXT))
                        --end

                        RageUI.Button(n, nil, t, true, function(Hovered, Active, Selected)
                            if Active then
                                local playerPed = GetPlayerPed(-1)

                                if v.typ == "bandana" then
                                    SetPedPropIndex(playerPed, 0, 14, v.value_2, 2)
                                else
                                    ClearPedProp(playerPed, 0, -1, 0, 2)
                                    SetPedComponentVariation(playerPed, v.value, v.value_2, index_mask, 2)
                                end

                                print(v.value, v.value_2, index_mask)
                            end
                            if Selected then
                                TriggerServerEvent("Extasy:MaskMoney", token, index, v.price, v.typ, n, v.value, v.value_2, v.num, v.GXT)
                            end
                        end)
                    end

                end, function()
                end)
            end
        end)
    end
end

RegisterNetEvent("Extasy:canHaveMask")
AddEventHandler("Extasy:canHaveMask", function(price, typ, n, value, value_2, num, GXT)
    local playerPed = GetPlayerPed(-1)

    if typ == "bandana" then
        Addbank_transac("Achat bandana '"..n.."' ", Extasy.Math.GroupDigits(price), "out")
        --TriggerServerEvent("Extasy:GiveItem", token, v.item_name, 1, Extasy.GetPlayerCapacity())

        SetPedPropIndex(playerPed, 0, 14, value_2, 2)
        mask_data, mask_data2, mask_data3 = value, value_2, index_mask
        mask_enabled = true
        mask_num = num
    else
        print(value, value_2, index_mask, GXT, n)
        Addbank_transac("Achat masque '"..GetLabelText(tostring(GXT)).."' ", Extasy.Math.GroupDigits(price), "out")
        local d = {mask_1 = value, mask_2 = value_2, mask_3 = index_mask}
        TriggerServerEvent("Extasy:GiveMask", token, "Masque", 1, d, n)

        SetPedComponentVariation(playerPed, value, value_2, index_mask, 2)
        mask_data, mask_data2, mask_data3 = value, value_2, index_mask
        mask_enabled = true
        mask_num = num
    end
end)

openMasks = function(num)
    Extasy.SwitchCam(true, "default")
    Citizen.Wait(250)
    Extasy.CreateGlobalCamera()

    RageUI.Visible(RMenu:Get('mask_shop', 'main_menu'), true)
    openMask_Shop_menu()
    startShowMaskVariants()

    Extasy.SwitchCam(true, "face")

    -- if num == 1 then
        -- Extasy.CreateGoodCamera(vector3(-1336.47, -1278.76, 3.86), 290.51, 35.0, vector3(-1335.68, -1278.27, 5.48), 0.0, 0.0, 130.0, 1750)
    -- elseif num == 2 then
        -- Extasy.CreateGoodCamera(vector3(3.14, 6509.3, 31.88), 130.39, 35.0, vector3(3.14, 6509.3, 31.50), 0.0, 0.0, -40.0, 1750)
    -- end
end

checkMasks = function()
    if #playerMasksData > 0 then
        return true
    else
        return false
    end
end

startShowMaskVariants = function()
    show_mask_variant = true
    Citizen.CreateThread(function()
        while show_mask_variant do
            Wait(1)
            if IsControlJustPressed(1, 307) then
                if index_mask + 1 > 29 then
                    index_mask = 0
                else
                    index_mask = index_mask + 1
                end
            end

            if IsControlJustPressed(1, 308) then
                if index_mask - 1 < 0 then
                    index_mask = 29
                else
                    index_mask = index_mask - 1
                end
            end

            if IsControlJustPressed(1, 299) then
                index_mask = 0
            end
            if IsControlJustPressed(1, 300) then
                index_mask = 0
            end

            Extasy.PopupTime("~p~Variante actuelle: "..index_mask.."\n← → pour changer de variante", 1000)
        end
    end)
end