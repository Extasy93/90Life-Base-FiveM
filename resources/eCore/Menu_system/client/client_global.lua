ESX = nil

Citizen.CreateThread(function ()
  while ESX == nil do
    TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
  end
end)
ConfigGlobalMenu.Animation = true
ConfigGlobalMenu.AnimationTime = 2500 -- Miliseconds
Extasy_items_weaponshop = {}
Extasy_items_illegalshop = {}

Extasy_items_weaponshop.whiteweapons ={
    --{Label = "Poing américan", Name = "WEAPON_KNUCKLE", Price = 2400},
    --{Label = "Lampe torche", Name = "WEAPON_FLASHLIGHT", Price = 4000},
    {Label = "Batte de baseball", Name = "WEAPON_BAT", Price = 3000},
    {Label = "Machette", Name = "WEAPON_MACHETE", Price = 3700},
    {Label = "Couteau Papillon", Name = "WEAPON_SWITCHBLADE", Price = 4500},
    {Label = "Club de golf", Name = "WEAPON_GOLFCLUB", Price = 10300},
    {Label = "Parachute", Name = "GADGET_PARACHUTE", Price = 6500},
    --{Label = "Pétoire", Name = "WEAPON_SNSPISTOL", Price = 25000},
}

Extasy_items_weaponshop.accessoriesweapon = {
    {Label = "Munitions de pistolet", Name = "ammo_pistol", Price = 1000},
    {Label = "Munitions de fusil", Name = "ammo_rifle", Price = 1500},
    {Label = "Munitions de fusil à pompe", Name = "ammo_pistol", Price = 1750},
    {Label = "Munitions de SMG léger", Name = "ammo_smg", Price = 1600},
    {Label = "Munitions de SMG lourdes", Name = "ammo_smg_large", Price = 1800},
    {Label = "Munitions de sniper", Name = "ammo_snp", Price = 2000},
}

Extasy_items_illegalshop.Illegalweapons ={
    --{Label = "Pistolet 50", Name = "weapon_pistol50", Price = 220000},
    --{Label = "Smg", Name = "weapon_smg", Price = 350000},
    --{Label = "AK 47", Name = "weapon_assaultrifle", Price = 8775000},
    --{Label = "balayeuse gusenberg (thompson)", Name = "weapon_gusenberg", Price = 5875000},
    --{Label = "Sniper", Name = "weapon_sniperrifle", Price = 11675000},
    --{Label = "Pistolet Calibre50", Name = "weapon_pistol50", Price = 165000},
    --{Label = "Flares", Name = "weapon_flare", Price = 750},
    --{Label = "Molotov", Name = "weapon_molotov", Price = 4500},
    {Label = "Lancer d'artifices", Name = "WEAPON_FIREWORK", Price = 10000000},
    --{Label = "Parachute", Name = "gadget_parachute", Price = 9500},
}

--Extasy_items_illegalshop.accessoriesweaponIllegal = {
    --{Label = "Chargeur normal", Name = "clip", Price = 500},
--}

Extasy_items_illegalshop.objectillegal = {
    {Label = "Pillule de l'oublie", Name = "piluleoubli", Price = 750},
    {Label = "Net Cracker", Name = "net_cracker", Price = 1200},
    {Label = "Outils de crochetage de véhicule", Name = "lockpickcar", Price = 4500},
    {Label = "Outils de cambriolage", Name = "lockpick", Price = 500},
    {Label = "fake carte d'identification ", Name = "id_card_f", Price = 2300},
    {Label = "fake carte de secours", Name = "secure_card", Price = 1500},
    {Label = "Fausse Plaque", Name = "fakeplate", Price = 2500},
    --{Label = "Cagoule", Name = "cagoule", Price = 500},
}

local WeaponShop_illegal_in_menu = false

RMenu.Add('Extasy_global_shop_superette', 'shopillegalMenu', RageUI.CreateMenu("Blackmarket", 'Que souhaitez-vous faire ?', 10, 140))
RMenu:Get('Extasy_global_shop_superette', 'shopillegalMenu'):SetRectangleBanner(110, 7, 0, 255)
RMenu.Add('Extasy_global_shop_superette', 'Illegalweapons', RageUI.CreateSubMenu(RMenu:Get('Extasy_global_shop_superette', 'shopillegalMenu'),"Blackmarket", 'Que souhaitez-vous faire ?',10, 140))
RMenu.Add('Extasy_global_shop_superette', 'accessoriesweaponIllegal', RageUI.CreateSubMenu(RMenu:Get('Extasy_global_shop_superette', 'shopillegalMenu'),"Blackmarket", "Que souhaitez-vous faire ?",10, 140))
RMenu.Add('Extasy_global_shop_superette', 'objectillegal', RageUI.CreateSubMenu(RMenu:Get('Extasy_global_shop_superette', 'shopillegalMenu'),"Blackmarket", "Que souhaitez-vous faire ?",10, 140))
RMenu:Get('Extasy_global_shop_superette', 'shopillegalMenu').Closed = function()
    WeaponShop_illegal_in_menu = false
end
RMenu:Get('Extasy_global_shop_superette', 'Illegalweapons').Closed = function()
    WeaponShop_illegal_in_menu = false
end

openWeaponIllegalShopMenu = function()
    if not WeaponShop_illegal_in_menu then 
        WeaponShop_illegal_in_menu = true
        RageUI.Visible(RMenu:Get('Extasy_global_shop_superette', 'shopillegalMenu'), true)
    
        Citizen.CreateThread(function()
          while WeaponShop_illegal_in_menu do
            Wait(1)

        RageUI.IsVisible(RMenu:Get('Extasy_global_shop_superette', 'shopillegalMenu'), true, false, true, function()
            --RageUI.Button("Acessoires d'armes", "Accessoires d'armes a feux", {RightLabel = "Suivant →"}, true, function()
            --end, RMenu:Get('Extasy_global_shop_superette', 'accessoriesweaponIllegal'))

        

            --RageUI.Button("Armes a feu", 'Armes disponible a tous !', {RightLabel = "Suivant →"}, true, function()
            --end, RMenu:Get('Extasy_global_shop_superette', 'Illegalweapons')) 

            RageUI.Button("Liste des Objects", nil, {RightLabel = "Suivant →"}, true, function()
            end, RMenu:Get('Extasy_global_shop_superette', 'objectillegal'))

            RageUI.Button("Vendre des Objects", nil, {RightLabel = "Suivant →"}, true, function()
            end, RMenu:Get('Extasy_global_shop_superette', 'sellobjectillegal'))
        end)    

        RageUI.IsVisible(RMenu:Get('Extasy_global_shop_superette', 'accessoriesweaponIllegal'), true, false, true, function()

            for k,v in pairs(Extasy_items_illegalshop.accessoriesweaponIllegal) do
                RageUI.Button(v.Label , nil, {LeftBadge = nil, RightBadge = nil, RightLabel = v.Price.."~g~ $"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local thePrice = v.Price
                        local theItem = v.Name
                        local theLabel = v.Label
                        TriggerServerEvent('buyItems', token, thePrice, theItem, theLabel)
                        RageUI.GoBack()
                    end
                end)    
            end
        end, function()
        end)    

        RageUI.IsVisible(RMenu:Get('Extasy_global_shop_superette', 'objectillegal'), true, false, true, function()

            for k,v in pairs(Extasy_items_illegalshop.objectillegal) do
                RageUI.Button(v.Label , nil, {LeftBadge = nil,RightBadge = nil,RightLabel = v.Price.."~g~ $"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local thePrice = v.Price
                        local theItem = v.Name
                        local theLabel = v.Label
                        TriggerServerEvent('buyBlackItems', token,thePrice,theItem,theLabel)
                        RageUI.GoBack()
                    end
                end)    
            end
        end, function()
        end)    

        RageUI.IsVisible(RMenu:Get('Extasy_global_shop_superette', 'Illegalweapons'), true, false, true, function()

            for k,v in pairs(Extasy_items_illegalshop.Illegalweapons) do
                RageUI.Button(v.Label , nil, {LeftBadge = nil,RightBadge = nil,RightLabel = v.Price.."~g~ $"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local theWeapon = v.Name
                        local thePrice = v.Price
                        TriggerServerEvent('buyWeaponsIllegals', token, theWeapon, thePrice)
                        RageUI.GoBack()
                    end
                end)     
            end
   
            local degpistol = GetWeaponDamage(0x1B06D571)
            local degpistol = degpistol / 80
            RageUI.StatisticPanel(degpistol, "Dégats", 3)
            RageUI.StatisticPanel(0.45, "Précision", 3)
            
            local degpistolsns = GetWeaponDamage(0xBFD21232)
            local degpistolsns = degpistolsns / 80
            RageUI.StatisticPanel(degpistolsns, "Dégats", 4)
            RageUI.StatisticPanel(0.45, "Précision", 4)
            
            local degpistollourd = GetWeaponDamage(0xD205520E)
            local degpistollourd = degpistollourd / 80
            RageUI.StatisticPanel(degpistollourd, "Dégats", 5)
            RageUI.StatisticPanel(0.56, "Précision", 5)
            
            local pisdetresse = GetWeaponDamage(0x47757124)
            local pisdetresse = pisdetresse / 70
            RageUI.StatisticPanel(pisdetresse, "Dégats", 6)
            RageUI.StatisticPanel(0.30, "Précision", 6)

        end, function()
        end)   
    end
end)
end
end

local WeaponShop_in_menu = false
local index = 1

RMenu.Add('Extasy_global_weaponshop', 'weaponMenu', RageUI.CreateMenu("", 'Articles disponible dans les rayons :',10, 140,'shopui_title_gunclub','shopui_title_gunclub'))
RMenu.Add('Extasy_global_weaponshop', 'whiteweapons', RageUI.CreateSubMenu(RMenu:Get('Extasy_global_weaponshop', 'weaponMenu'),"", 'Comptoir a armes blanches',10, 140))
RMenu.Add('Extasy_global_weaponshop', 'accessoriesweapon', RageUI.CreateSubMenu(RMenu:Get('Extasy_global_weaponshop', 'weaponMenu'),"", "Comptoir a accessoires d'armes ",10, 140))
RMenu.Add('Extasy_global_weaponshop', 'weaponMenu', RageUI.CreateMenu("", 'Articles disponible dans les rayons :',10, 140,'shopui_title_gunclub','shopui_title_gunclub'))
RMenu:Get('Extasy_global_weaponshop', 'weaponMenu').Closed = function()
    WeaponShop_in_menu = false
end

RMenu:Get('Extasy_global_weaponshop', 'whiteweapons').Closed = function()
    WeaponShop_in_menu = false
end

RMenu:Get('Extasy_global_weaponshop', 'accessoriesweapon').Closed = function()
    WeaponShop_in_menu = false
end


  
openWeaponShopMenu = function()
      if not WeaponShop_in_menu then 
          WeaponShop_in_menu = true
          RageUI.Visible(RMenu:Get('Extasy_global_weaponshop', 'weaponMenu'), true)
      
          Citizen.CreateThread(function()
            while WeaponShop_in_menu do
            Wait(1)
  
            RageUI.IsVisible(RMenu:Get('Extasy_global_weaponshop', 'weaponMenu'), true, false, true, function()
            Weaponshop_in_menu = true

            RageUI.Button("Acessoires d'armes", "Accessoires d'armes a feux", {RightLabel = "Suivant →"}, true, function()
            end, RMenu:Get('Extasy_global_weaponshop', 'accessoriesweapon'))


            RageUI.Button("Armes", 'Armes disponible a tous !', {RightLabel = "Suivant →"}, true, function()
            end, RMenu:Get('Extasy_global_weaponshop', 'whiteweapons'))
        end)    

        RageUI.IsVisible(RMenu:Get('Extasy_global_weaponshop', 'accessoriesweapon'), true, false, true, function()
            Weaponshop_in_menu = true

            RageUI.List("Mode de paiement", extasy_core_cfg["available_payments"], index, nil, {}, true, function(Hovered, Active, Selected, Index)
                index = Index
            end)

            RageUI.Separator("")

            for k,v in pairs(Extasy_items_weaponshop.accessoriesweapon) do
                RageUI.Button(v.Label , nil, {LeftBadge = nil,RightBadge = nil,RightLabel = v.Price.."~g~ $"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local thePrice = v.Price
                        local theItem = v.Name
                        local theLabel = v.Label
                        TriggerServerEvent('Extasy:buyWeaponShop', token, theItem, thePrice, index, theLabel)
                        PlaySoundFrontend(-1, 'NAV', 'HUD_AMMO_SHOP_SOUNDSET', false)
                        Weaponshop_in_menu = false
                    end
                end)    
            end
        end, function()
        end)  


        RageUI.IsVisible(RMenu:Get('Extasy_global_weaponshop', 'whiteweapons'), true, false, true, function()
            Weaponshop_in_menu = true

            RageUI.List("Mode de paiement", extasy_core_cfg["available_payments"], index, nil, {}, true, function(Hovered, Active, Selected, Index)
                index = Index
            end)

            RageUI.Separator("")

            for k,v in pairs(Extasy_items_weaponshop.whiteweapons) do
                RageUI.Button(v.Label , nil, {LeftBadge = nil, RightBadge = nil, RightLabel = v.Price.."~g~ $"}, true, function(Hovered, Active, Selected)
                    if Active then 
                    end
                    if Selected then
                        local theWeapon = v.Name
                        local thePrice = v.Price
                        local theLabel = v.Label
                        TriggerServerEvent('Extasy:buyWeaponShop', token, theWeapon, thePrice, index, theLabel)
                        PlaySoundFrontend(-1, 'NAV', 'HUD_AMMO_SHOP_SOUNDSET', false)
                        Weaponshop_in_menu = false
                    end
                end)    
            end
        end, function()
        end)    
    end
end)
end
end

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
		Wait(10)
	end

	while ESX.GetPlayerData().job == nil do
		Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

	while actualSkin == nil do
		TriggerEvent('skinchanger:getSkin', function(skin) actualSkin = skin end)
		Wait(10)
	end
end)

illegal_menu_succes = 0

Citizen.CreateThread(function()
    illegal_menu_succes = GetResourceKvpInt("IllegalSucces")
    if illegal_menu_succes == nil then
        illegal_menu_succes = 0
    end
end)

local succesIllegalSucces = {
    [1] = {
        texte = "Bienvenue dans l’illégal !"
    },
}

Citizen.CreateThread(function()
    local Last10 = 100
    for i = 100, 1000 do
        if i == Last10 + 10 then
            succesIllegalSucces[Last10] = {texte = Last10.." Pièces ramasser"}
            Last10 = Last10 + 10
        end
    end
end)

CheckSuccesIllegalMenu = function()
    illegal_menu_succes = illegal_menu_succes + 1
    if succesIllegalSucces[illegal_menu_succes] ~= nil then
        --PlayUrl("SUCCES", "https://www.youtube.com/watch?v=VpwqsYA44JI", 0.4, false)
        TriggerEvent("Ambiance:PlayUrl", "SUCCES", "https://www.youtube.com/watch?v=VpwqsYA44JI", 0.4, false )
        Wait(1000)
        SendNUIMessage({ 
            succes = true
        })
        Extasy.NotifSucces("~y~SUCCES!\n~w~"..succesIllegalSucces[illegal_menu_succes].texte)
        if succesIllegalSucces[illegal_menu_succes].suplementaire ~= nil then
            Extasy.NotifSucces("~y~SUCCES!\n~w~"..succesIllegalSucces[illegal_menu_succes].suplementaire)
        end
    end
    SetResourceKvpInt("IllegalSucces", illegal_menu_succes)
end