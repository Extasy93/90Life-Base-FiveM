local illegal_shop_menu_openned = false

RMenu.Add('illegal_shop', 'main_menu', RageUI.CreateMenu("Marchand illégal", "Que souhaitez-vous acheter ?", 1, 100))
RMenu:Get('illegal_shop', 'main_menu'):SetRectangleBanner(110, 7, 0, 255)
RMenu:Get('illegal_shop', 'main_menu').Closed = function()
    illegal_shop_menu_openned = false
end

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

openIllegalMarket = function()
    if illegal_shop_menu_openned then
        illegal_shop_menu_openned = false
        return
    else
        illegal_shop_menu_openned = true
        RageUI.Visible(RMenu:Get('illegal_shop', 'main_menu'), true)
        Citizen.CreateThread(function()
            while illegal_shop_menu_openned do
                Wait(1)
                
                RageUI.IsVisible(RMenu:Get('illegal_shop', 'main_menu'), true, true, true, function()

                    RageUI.Button("Chargeur", nil, {RightLabel = Extasy.Math.GroupDigits(extasy_core_cfg["illegal_shop_clip_price"]).."$"}, true, function(h, a, s)
                        if s then
                            if s then
                                TriggerServerEvent("illegal_shop:buySomething", token, "Chargeur", "Chargeur", 1, extasy_core_cfg["illegal_shop_clip_price"])
                            end
                        end
                    end)

                    RageUI.Separator("")

                    for k,v in pairs(extasy_core_cfg["illegal_shop"].items) do
                        if string.sub(v.item, 1, string.len("WEAPON_")) == "WEAPON_" then
                            if v.index > 1 then
                                RageUI.List(v.name.." ("..Extasy.Math.GroupDigits(v.price * 1.5).."$)", count_i, v.index, "Acheter "..v.index.." "..v.name.." vous coutera "..Extasy.Math.GroupDigits(v.index * v.price).."$", {}, true, function(h, a, s, Index)
                                    v.index = Index

                                    if s then
                                        if v.kevlar then
                                            TriggerServerEvent("illegal_shop:buySomething", token, "Kevlar", "Kevlar", v.index, v.price * 1.5, {draw = v.draw, texture = v.texture, damage = v.damage})
                                        else
                                            TriggerServerEvent("illegal_shop:buySomething", token, v.item, v.name, v.index, v.price)
                                        end
                                    end
                                end)
                            else
                                RageUI.List(v.name.." ("..Extasy.Math.GroupDigits(v.price * 1.5).."$)", count_i, v.index, nil, {}, true, function(h, a, s, Index)
                                    v.index = Index

                                    if s then
                                        if v.kevlar then
                                            TriggerServerEvent("illegal_shop:buySomething", token, "Kevlar", "Kevlar", v.index, v.price * 1.5, {draw = v.draw, texture = v.texture, damage = v.damage})
                                        else
                                            TriggerServerEvent("illegal_shop:buySomething", token, v.item, v.name, v.index, v.price)
                                        end
                                    end
                                end)
                            end
                        else
                            if v.index > 1 then
                                RageUI.List(v.name.." ("..Extasy.Math.GroupDigits(v.price).."$)", count_i, v.index, "Acheter "..v.index.." "..v.name.." vous coutera "..Extasy.Math.GroupDigits(v.index * v.price).."$", {}, true, function(h, a, s, Index)
                                    v.index = Index

                                    if s then
                                        if v.kevlar then
                                            TriggerServerEvent("illegal_shop:buySomething", token, "Kevlar", "Kevlar", v.index, v.price, {draw = v.draw, texture = v.texture, damage = v.damage})
                                        else
                                            TriggerServerEvent("illegal_shop:buySomething", token, v.item, v.name, v.index, v.price)
                                        end
                                    end
                                end)
                            else
                                RageUI.List(v.name.." ("..Extasy.Math.GroupDigits(v.price).."$)", count_i, v.index, nil, {}, true, function(h, a, s, Index)
                                    v.index = Index

                                    if s then
                                        if v.kevlar then
                                            TriggerServerEvent("illegal_shop:buySomething", token, "Kevlar", "Kevlar", v.index, v.price, {draw = v.draw, texture = v.texture, damage = v.damage})
                                        else
                                            TriggerServerEvent("illegal_shop:buySomething", token, v.item, v.name, v.index, v.price)
                                        end
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