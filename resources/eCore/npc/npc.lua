active_npc = {}

npcList = {
    {
        hash            = "ig_stretch", 
        pos             = vector3(2073.506, 6271.071, 16.91674),
        heading         = 50.07121658325195,
        interactMessage = "Appuyez sur ~p~~INPUT_TALK~ ~w~pour vendre de la coke",
        action          = function()
            startDrugsSellCoke()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,

        blip_enable     = false,
    },
    {
        hash            = "ig_stretch", 
        pos             = vector3(3332.604, 7318.721, 17.71837),
        heading         = 180.785888671875,
        interactMessage = "Appuyez sur ~p~~INPUT_TALK~ ~w~pour vendre de la weed",
        action          = function()
            startDrugsSellWeed()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,

        blip_enable     = false,
    },

    {
        hash            = "ig_stretch", 
        pos             = vector3(2359.47, 4694.604, 11.06907),
        heading         = 336.7249450683594,
        interactMessage = "Appuyez sur ~p~~INPUT_TALK~ ~w~pour vendre de la meth",
        action          = function()
            startDrugsSellMeth()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,

        blip_enable     = false,
    },

    {
        hash            = "s_m_y_barman_01", 
        pos             = vector3(2561.836, 4685.298, 11.50513),
        heading         = 337.829,
        action          = function()
            openGrossiste()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,

        blip_enable     = false,
        sprite          = 351,
        color           = 21, 
        title           = "Cabinet d'avocat",
        scale           = 0.65,

        img_blip        = false,
        description     = "Besoin d'aide judiciaire ? C'est ici qu'on vous aide !",
        frequency       = "~o~Moyen",
        streamed        = "avocat"
    },
    {
        hash            = "cs_barry", 
        pos             = vector3(2351.04, 5739.81, 12.07),
        heading         = 183.569,
        action          = function()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,

        blip_enable     = true,
        sprite          = 351,
        color           = 21, 
        title           = "Cabinet d'avocat",
        scale           = 0.65,

        img_blip        = true,
        description     = "Besoin d'aide judiciaire ? C'est ici qu'on vous aide !",
        frequency       = "~o~Moyen",
        streamed        = "avocat"
    },
    {
        hash            = "ig_vccop", -- Garage VCPD
        pos             = vector3(3613.13, 5700.03, 11.28),
        heading         = 141.06,
        action          = function()
            if playerJob == 'vcpd' then
                VCPD_Garage("car")
            else
                Extasy.ShowNotification("~r~Vous n'êtes pas VCPD")
            end
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 25,
        freeze          = true,
        msg             = true,

        blip_enable     = false,
        sprite          = nil,
        color           = nil, 
        title           = nil,
        scale           = nil,
    },
    {
        hash            = "ig_vccop",
        pos             = vector3(3634.03, 5705.21, 5.55),
        heading         = 50.10,
        action          = function()
            if playerJob == 'vcpd' then
                VCPD_Weapon()
            else
                Extasy.ShowNotification("~r~Vous n'êtes pas VCPD")
            end
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 25,
        freeze          = true,
        msg             = true,

        blip_enable     = false,
        sprite          = nil,
        color           = nil, 
        title           = nil,
        scale           = nil,
    },
    {
        hash            = "a_f_y_fitness_01", -- Gym
        pos             = vector3(2421.35, 4860.00, 10.37),
        heading         = 269.83,
        action          = function()
            openGym()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,

        blip_enable     = true,
        sprite          = 311,
        color           = 5, 
        title           = "Salle de Gym",
        scale           = 0.65,

        img_blip        = true,
        description     = "Prenez soin et bâtissez votre corps de rêve dans cette salle commune dernier cri !",
        frequency       = "~o~Moyen",
        streamed        = "gym"
    },
    {
        hash            = "a_f_y_fitness_01", -- Gym
        pos             = vector3(2420.12, 4856.88, 10.38),
        heading         = 245.83,
        action          = function()
            openGym()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,

        blip_enable     = false,
    },
    {
        hash            = "mp_m_boatstaff_01", -- Auto école bateau
        pos             = vector3(2854.32, 4843.93, 7.07),
        heading         = 269.83,
        action          = function()
            openAutoEcoleBoat()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,

        blip_enable     = true,
        sprite          = 525,
        color           = 4, 
        title           = "Auto-école | Bateau",
        scale           = 0.65,
    },
    {
        hash            = "s_m_y_valet_01", -- Arcade accueil
        pos             = vector3(3795.363, 6001.205, 12.66076),
        heading         = 93.8847885131836,
        action          = function()
            Extasy.ShowAdvancedNotification("Dave & Busters", "Bienvenue", "Bienvenue chez Dave & Busters ! Amusez-vous bien !", "DAVE_BUSTERS")
        end,

        spawned         = false,
        entity          = nil,
        load_dst        = 25,
        msg             = true,
        freeze          = true,


        blip_enable     = false,
        img_blip        = false,
    },
    {
        hash            = "u_m_m_jewelsec_01", -- Arcade vigile
        pos             = vector3(3790.137, 6004.317, 12.78872),
        heading         = 2.09423828125,
        action          = function()
        end,

        spawned         = false,
        entity          = nil,
        load_dst        = 25,
        msg             = false,
        freeze          = true,
        anim            = true,
        animType        = 'TaskStartScenarioInPlace',
        animData        = {
            name        = 'WORLD_HUMAN_GUARD_STAND',
        },


        blip_enable     = false,
        img_blip        = false,
    },
    {
        hash            = "u_m_m_jewelsec_01", -- Arcade vigile
        pos             = vector3(3786.305, 6004.317, 12.78949),
        heading         = 2.09423828125,
        action          = function()
        end,

        spawned         = false,
        entity          = nil,
        load_dst        = 25,
        msg             = false,
        freeze          = true,
        anim            = true,
        animType        = 'TaskStartScenarioInPlace',
        animData        = {
            name        = 'WORLD_HUMAN_GUARD_STAND',
        },


        blip_enable     = false,
        img_blip        = false,
    },
    {
        hash            = "ig_mrk", -- Post OP
        pos             = vector3(2396.953, 4914.331, 10.31836),
        heading         = 71.39081573486328,
        action          = function()
            --if ESX.PlayerData.job and ESX.PlayerData.job.name == 'delivery' then 
                openGopostal()
            --else
                --Extasy.ShowNotification("~r~Vous n'êtes pas un employé de Post OP !")
            --end
        end,

        spawned         = false,
        entity          = nil,
        load_dst        = 25,
        msg             = true,
        freeze          = true,


        blip_enable     = true,
        sprite          = 478,
        color           = 21,
        title           = "Post OP",
        scale           = 0.65,

        img_blip        = true,
        description     = "Post OP gère la livraison de tous les colis de Vice City !",
        frequency       = "~o~Moyen",
        streamed        = "gopostal"
    },

    --[[{
        hash            = "a_m_m_beach_02",
        pos             = vector3(2853.89, 5548.23, 6.92),
        heading         = 318.65,
        action          = function()
            openPedalo(1)
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 50,
        msg             = true,
        dst             = 2.0,

        blip_enable     = true,
        sprite          = 410,
        color           = 60,
        title           = "Activité pédalo",
        scale           = 0.65,

        img_blip        = true,
        description     = "Venez vous amuser grace à des pédalos dans un lac plus que remarcable !",
        frequency       = "~o~moyen",
        streamed        = "pedalo"
    },--]]
    {
        hash            = "ig_miguelmadrazo",
        pos             = vector3(3027.54, 4906.21, 8.07),
        heading         = 92.76,
        action          = function()
            BoatShopPreviewMenu(GetEntityCoords(PlayerPedId()))
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 50,
        msg             = true,
        freeze          = true,

        text3d          = "Catalogue bateaux",

        blip_enable     = true,
        sprite          = 455,
        color           = 53, 
        title           = "Concessionnaire bateau",
        scale           = 0.75,
    },
    {
        hash            = "g_m_y_lost_01",
        pos             = vector3(2416.983, 7541.432, 10.62507),
        heading         = 208.06,
        action          = function()
            BikeShopPreviewMenu(GetEntityCoords(PlayerPedId()))
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 50,
        msg             = true,
        freeze          = true,

        text3d          = "Catalogue motos",

        blip_enable     = false,
        sprite          = 455,
        color           = 53, 
        title           = "Concessionnaire moto",
        scale           = 0.75,
    },
    {
        hash            = "ig_lifeinvad_01", -- Arcade
        pos             = vector3(3820.70, 5995.12, 12.70),
        heading         = 153.30,
        action          = function()
            openArcade()
        end,

        spawned         = false,
        entity          = nil,
        load_dst        = 25,
        msg             = true,
        freeze          = true,


        blip_enable     = true,
        sprite          = 740,
        color           = 1,
        title           = "Dave & Buster's",
        scale           = 0.65,

        img_blip        = true,
        description     = "Venez vous amuser dans ce centre muni des bornes d'arcade dernières génération !",
        frequency       = "~r~Fort",
        streamed        = "arcadevice"
    },
    {
        hash            = "a_m_m_hillbilly_01", ---pêche
        pos             = vector3(2681.88, 4700.32, 6.90),
        heading         = 69.74,
        action          = function()
        end,

        spawned         = false,
        entity          = nil,
        load_dst        = 25,
        msg             = true,
        freeze          = true,


        blip_enable     = true,
        sprite          = 68,
        color           = 49,
        title           = "Vente poissons",
        scale           = 0.65,

        img_blip        = true,
        description     = "Venez vendre vos poissons fraîchement péchés !",
        frequency       = "~o~Moyen",
        streamed        = "ventepoissons"
    },
    {
        hash            = "a_m_m_hillbilly_01", ---pêche
        pos             = vector3(3847.24, 4432.35, 7.50),
        heading         = 106.42,
        action          = function()
        end,

        spawned         = false,
        entity          = nil,
        load_dst        = 25,
        msg             = true,
        freeze          = true,


        blip_enable     = true,
        sprite          = 68,
        color           = 49,
        title           = "Vente tortues",
        scale           = 0.65,

        img_blip        = true,
        description     = "Venez vendre vos tortues fraîchement péchées !",
        frequency       = "~o~Moyen",
        streamed        = "ventetortues"
    },
    {
        hash            = "a_m_m_hillbilly_01", ---pêche
        pos             = vector3(2445.42, 5841.67, 7.25),
        heading         = 48.29,
        action          = function()
        end,

        spawned         = false,
        entity          = nil,
        load_dst        = 25,
        msg             = true,
        freeze          = true,


        blip_enable     = true,
        sprite          = 68,
        color           = 49,
        title           = "Vente requins",
        scale           = 0.65,

        img_blip        = true,
        description     = "Venez vendre vos requins fraîchement péchés !",
        frequency       = "~o~Moyen",
        streamed        = "batoconcess"
    },
    {
        hash            = "cs_casey",
        pos             = vector3(2581.513, 7435.252, 10.038),
        heading         = 268.807,
        
        action          = function()
            OpenMenuStand()
        end,

        spawned         = false,
        entity          = nil,
        load_dst        = 25,
        msg             = true,
        freeze          = true,

        blip_enable     = true,
        sprite          = 119,
        color           = 10,
        title           = "Stand de tir",
        scale           = 0.65,
    },
    --[[{
        hash            = "a_m_m_eastsa_02",
        pos             = vector3(180.02, 2793.22, 45.66),
        heading         = 276.26,
        action          = function()
            openFruitsMenu()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 25,
        msg             = true,

        blip_enable     = true,
        sprite          = 85,
        color           = 35, 
        title           = "Revente de fruits",
        scale           = 0.60,
    },--]]
    {
        hash            = "a_m_y_business_03", -- Loterie
        pos             = vector3(3105.17, 5059.22, 12.44),
        heading         = 47.27,
        
        action          = function()
            OpenLottery()
        end,

        spawned         = false,
        entity          = nil,
        load_dst        = 25,
        msg             = true,
        freeze          = true,

        blip_enable     = true,
        sprite          = 617,
        color           = 81,
        title           = "Vice Loterie",
        scale           = 0.65,
    },
    {
        hash            = "a_f_m_eastsa_02", -- Animalerie
        pos             = vector3(3790.384, 7484.896, 17.18194),
        heading         = 130.162,

        action          = function()
            --if getPlayerVip() == "PLATINUM" or getPlayerVip() == "DIAMOND" then
                openAnimalerieMenu()
            --else
                --Extasy.ShowNotification("~r~Vous n'avez pas le grade nécessaire pour accéder cette fonctionnalité.~n~Vous devez être minimum:\n~g~PLATINUM")
            --end
        end,

        spawned         = false,
        entity          = nil,
        load_dst        = 25,
        msg             = true,
        freeze          = true,

        blip_enable     = true,
        sprite          = 273,
        color           = 3, 
        title           = "Animalerie",
        scale           = 0.70,
    },
    {
        hash            = "a_m_m_prolhost_01", -- Hotel
        pos             = vector3(3686.91, 5582.06, 10.01),
        heading         = 244.5,

        action          = function()
            TriggerServerEvent("hotel:requestMenu", token)
        end,

        spawned         = false,
        entity          = nil,
        load_dst        = 25,
        msg             = true,
        freeze          = true,

        blip_enable     = true,
        sprite          = 475,
        color           = 29, 
        title           = "Hôtel",
        scale           = 0.70,
    },
    {
        hash            = "a_m_y_latino_01", -- Terrain de cross
        pos             = vector3(3905.87, 7017.8, 12.39),
        heading         = 105.038,
        action          = function()
            opencross(1)
        end,

        spawned         = false,
        entity          = nil,
        load_dst        = 25,
        msg             = true,
        freeze          = true,

        blip_enable     = true,
        sprite          = 376,
        color           = 1, 
        title           = "Terrain de cross (activité)",
        scale           = 0.70,

        img_blip        = true,
        description     = "Serrez bien votre casque sur ce terrain ouvert au public !",
        frequency       = "~r~Fort",
        streamed        = "cross"
    },
    {
        hash            = "a_m_y_latino_01", -- Terrain de cross
        pos             = vector3(2826.36, 7619.95, 9.58),
        heading         = 153.10,
        action          = function()
            opencross(2)
        end,

        spawned         = false,
        entity          = nil,
        load_dst        = 25,
        msg             = true,
        freeze          = true,

        blip_enable     = true,
        sprite          = 376,
        color           = 1, 
        title           = "Terrain de cross (activité)",
        scale           = 0.70,

        img_blip        = true,
        description     = "Serrez bien votre casque sur ce terrain ouvert au public !",
        frequency       = "~r~Fort",
        streamed        = "crossvert"
    },
    --{
    --   hash            = "a_m_m_soucent_02", -- Chasse
    --   pos             = vector3(-1490.35, 4981.59, 63.36),
    --   heading         = 82.93,
    --
    --   action          = function()
    --       OpenHunterDialog()
    --   end,

    --    spawned         = false,
    --    entity          = nil,
    --    load_dst        = 25,
    --    msg             = true,
    --    freeze          = true,

    --    blip_enable     = true,
    --    sprite          = 442,
    --    color           = 51, 
    --    title           = "Chasse",
    --    scale           = 0.60,
    --},
    {
        hash            = "a_m_m_soucent_02", -- Préfécture
        pos             = vector3(3756.89, 6719.15, 11.0693),
        heading         = 177.75,

        action          = function()
            TriggerServerEvent('Extasy:recupcarteid', token)
        end,

        spawned         = false,
        entity          = nil,
        load_dst        = 25,
        msg             = true,
        freeze          = true,

        blip_enable     = true,
        sprite          = 498,
        color           = 36, 
        title           = "Prefecture",
        scale           = 0.65,
    },
    {
        hash            = "csb_thornton", -- Craigslist
        pos             = vector3(2374.11, 6087.47, 10.05),
        heading         = 242.67,
        action          = function()
            TriggerServerEvent("Craigslist:interact", token)
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 25,
        msg             = true,
        freeze          = true,

        blip_enable     = true,
        sprite          = 642,
        color           = 36, 
        title           = "Craigslist Vehicles",
        scale           = 0.65,

        img_blip        = true,
        description     = "Avec craigslist, trouvez la bonne affaire, réalisez-la bonne vente pour votre voiture, bateau ou même avion.",
        frequency       = "~b~Faible",
        streamed        = "craigslist"
    },
    {
        hash            = "s_m_y_barman_01", -- Run farm
        pos             = vector3(3335.725, 5400.266, 10.69463),
        heading         = 242.9302520751953,
        action          = function()
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'yellow' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'malibu' or ESX.PlayerData.job and ESX.PlayerData.job.name == 'bahamas' then 
                recolterunfarm()
            else
                Extasy.ShowNotification("~r~Tu peux pas lui parler")
            end
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,
    },
    {
        hash            = "s_m_y_construct_01", -- FarmJobs Bucheron
        pos             = vector3(-570.853, 5367.214, 70.21643),
        heading         = 289.134,
        action          = function()
            openFarmJobsMenu()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,

        --[[blip_enable     = true,
        sprite          = 477,
        color           = 21, 
        title           = "Bucheron",
        scale           = 0.55,
        description     = "",
        frequency       = "~o~Moyen",
        streamed        = "buche"--]]
    },
    {
        hash            = "s_m_y_construct_01", -- FarmJobs Mine
        pos             = vector3(2831.689, 2798.311, 57.49803),
        heading         = 117.689,
        action          = function()
            openFarmJobsMineMenu()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,

        --[[blip_enable     = true,
        sprite          = 477,
        color           = 70, 
        title           = "Mine",
        scale           = 0.55,
        description     = "",
        frequency       = "~o~Moyen",
        streamed        = "mine"--]]
    },
    --[[{
        hash            = "a_f_m_eastsa_01", -- Pôle Emploi
        pos             = vector3(-927.1508, -2035.441168, 9.54),
        heading         = 218.03,
        action          = function()
            openJoblistingMenu()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,

        blip_enable     = true,
        sprite          = 590,
        color           = 32, 
        title           = "Pôle Emplois",
        scale           = 0.70,
    },--]]
    {
        hash            = "u_m_y_mani",
        pos             = vector3(2364.42, 7325.01, 10.09),
        heading         = 272.16,
        action          = function()
            openShop(1, 'Sud')
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,

        blip_enable     = true,
        sprite          = 52,
        color           = 2, 
        title           = "Épicerie",
        scale           = 0.6,

        img_blip        = false
    },
    {
        hash            = "u_m_y_mani",
        pos             = vector3(3699.21, 6987.16, 11.91),
        heading         = 7.52,
        action          = function()
            openShop(2, 'Sud')
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,

        blip_enable     = true,
        sprite          = 52,
        color           = 2, 
        title           = "Épicerie",
        scale           = 0.6,

        img_blip        = false
    },
    {
        hash            = "u_m_y_mani",
        pos             = vector3(3290.64, 5129.53, 9.43),
        heading         = 87.63,
        action          = function()
            openShop(3, 'Nord')
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,

        blip_enable     = true,
        sprite          = 52,
        color           = 2, 
        title           = "Épicerie",
        scale           = 0.6,

        img_blip        = false
    },
    {
        hash            = "u_m_y_mani", -- Cayo périco
        pos             = vector3(4466.96, -4463.58, 4.25),
        heading         = 202.84,
        action          = function()
            openShop(4, 'Nord')
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,

        blip_enable     = true,
        sprite          = 52,
        color           = 2, 
        title           = "Épicerie",
        scale           = 0.6,

        img_blip        = false
    },
    {
        hash            = "u_m_y_mani",
        pos             = vector3(2348.93, 6014.42, 10.14),
        heading         = 90.31,
        action          = function()
            openShop(5, 'Sud')
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,

        blip_enable     = true,
        sprite          = 52,
        color           = 2, 
        title           = "Épicerie",
        scale           = 0.6,

        img_blip        = false
    },
    {
        hash            = "ig_bankman",
        pos             = vector3(2332.77, 5861.18, 12.39),
        heading         = 310.79,
        action          = function()
            openBank()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,

        blip_enable     = true,
        sprite          = 500,
        color           = 2, 
        title           = "Vice City Central Bank",
        scale           = 0.8,

        img_blip        = true,
        description     = "Bank",
        frequency       = "~o~Moyen",
        streamed        = "bank"
    },
    {
        hash            = "ig_bankman",
        pos             = vector3(2328.94, 5865.08, 12.39),
        heading         = 306.39,
        action          = function()
            openBank()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,
    },
    {
        hash            = "cs_solomon",
        pos             = vector3(1834.418, 5377.617, 13.82917),
        heading         = 221.36,
        action          = function()
            openLocation(0)
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        msg             = true,
        freeze          = true,

        blip_enable     = true,
        sprite          = 134,
        color           = 60, 
        title           = "Solomon Richards Renting",
        scale           = 0.8,
    },
    {
        hash            = "cs_solomon",
        pos             = vector3(2211.058, 7535.436, 7.705315),
        heading         = 92.96,
        action          = function()
            openLocation(1)
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        msg             = true,
        freeze          = true,

        blip_enable     = true,
        sprite          = 134,
        color           = 60, 
        title           = "Location",
        scale           = 0.8,
    },
    {
        hash            = "cs_solomon",
        pos             = vector3(3035.355, 4962.453, 9.427214),
        heading         = 271.215,
        action          = function()
            openLocation(2)
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        msg             = true,
        freeze          = true,

        blip_enable     = true,
        sprite          = 134,
        color           = 60, 
        title           = "Location",
        scale           = 0.8,
    },
    {
        hash            = "cs_solomon",
        pos             = vector3(3817.956, 6735.03, 11.01571),
        heading         = 91.695,
        action          = function()
            openLocation(3)
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        msg             = true,
        freeze          = true,

        blip_enable     = true,
        sprite          = 134,
        color           = 60, 
        title           = "Location",
        scale           = 0.8,
    },
    {
        hash            = "cs_solomon",
        pos             = vector3(2366.951, 5570.329, 10.23588),
        heading         = 188.075,
        action          = function()
            openLocation(4)
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        msg             = true,
        freeze          = true,

        blip_enable     = true,
        sprite          = 134,
        color           = 60, 
        title           = "Location",
        scale           = 0.8,
    },
    {
        hash            = "a_m_m_business_01", -- Concessionnaire
        pos             = vector3(2235.56, 5343.31, 12.04),
        heading         = 132.02,
        action          = function()
            openCatalogue()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,

        blip_enable     = true,
        sprite          = 326,
        color           = 37, 
        title           = "Concessionnaire",
        scale           = 0.60,

        img_blip        = true,
        description     = "Peu importe si vous aimez les grosses cylindrées ou même des motos, vous trouverez votre bonheur ici !",
        frequency       = "~r~Fort",
        streamed        = "concessvice"
    },
    {
        hash            = "a_f_y_scdressy_01", -- Garage Vice City Customs
        pos             = vector3(2075.91, 3402.62, 47.52),
        heading         = 255.861,
        action          = function()
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'NorthMecano' then 
                openGarageNorthMeca()
            else
                Extasy.ShowNotification("~r~Vous n'êtes pas un employer du NorthMecano")
            end
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,
    },

    -- Job Weazel News --
    {
        hash            = "s_f_m_shop_high", -- Accueil Weazel News
        pos             = vector3(2287.77, 7531.02, 10.21),
        heading         = 38.80,
        action          = function()
            openLobbyWeazelNewsMenu()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,

        blip_enable     = true,
        sprite          = 459,
        color           = 59,
        title           = "Siège de Weazel News",
        scale           = 0.65,

        img_blip        = true,
        description     = "Entreprise de journalisme qui informe les citoyens aux quotidiens",
        frequency       = "~b~Faible",
        streamed        = "weazel"
    },
    {
        hash            = "ig_ortega", -- Blanchisseur 
        pos             = vector3(1109.063, -2336.487, 31.29795),
        heading         = 111.9,
        action          = function()
            openWashing()
            --Extasy.ShowNotification("~r~Le blanchissement à temporairement été désactivé")
            CheckSuccesIllegalMenu()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,
    },
    {
        hash            = "csb_avon", -- Avocat Boss Action 
        pos             = vector3(-1912.0, -569.14, 19.09),
        heading         = 179.9,
        action          = function()
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'avocat' and ESX.PlayerData.job.grade_name == 'boss' then 
                openBossMenu('avocat')
            else
                Extasy.ShowNotification("~r~Vous n'êtes pas un Patron Avocat")
            end
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,
    },
    {
        hash            = "s_m_m_scientist_01", -- Pharmacie Ambulance 
        pos             = vector3(3089.36, 5235.57, 9.41),
        heading         = 190.37,
        action          = function()
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then 
                openAmbulancePharmacie()
            else
                Extasy.ShowNotification("~r~Vous n'êtes pas un Ambulancier")
            end
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,
    },
    {
        hash            = "s_m_m_scientist_01", -- Acceuil Ambulance 
        pos             = vector3(3103.96, 5225.26, 9.41),
        heading         = 147.18,
        action          = function()
            Extasy.ShowNotification("Bienvenue à l'hôpital !")
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,

        blip_enable     = true,
        sprite          = 61,
        color           = 2,
        title           = "Jackson Memorial Hospital",
        scale           = 0.65,

        img_blip        = true,
        description     = "Le Jackson Memorial Hospital (connu sous le nom de Jackson ou abrégé JMH) est le principal hospitalier de Vice City",
        frequency       = "~r~Fort",
        streamed        = "vicehopital"
    },
    {
        hash            = "ig_omega", -- WeedShop
        pos             = vector3(2352.24, 5796.44, 12.32),
        heading         = 351.62,
        action          = function()
            Extasy.ShowNotification("Yo Man, c'est de la bonne ici !")
        end,

        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,

        blip_enable     = true,
        sprite          = 140,
        color           = 2,
        title           = "Weed Shop",
        scale           = 0.65,

        img_blip        = true,
        description     = "Venez acheter votre came en toute légalité !",
        frequency       = "~r~Fort",
        streamed        = "weedshop"
    },
    {
        hash            = "s_m_o_busker_01", -- recolte du bennys
        pos             = vector3(2179.796, 6562.494, 10.2218),
        heading         = 185.11,
        action          = function()
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vccustoms' then 
                openRecoltePiece()
            else
                Extasy.ShowNotification("~r~Vous n'êtes pas mécanicien.")
            end
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,
    },
    {
        hash            = "s_m_o_busker_01", -- transfo du bennys
        pos             = vector3(3239.912, 4939.428, 9.425026),
        heading         = 92.38,
        action          = function()
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vccustoms' then 
                openTransormationKit()
            else
                Extasy.ShowNotification("~r~Vous n'êtes pas mécanicien.")
            end
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,
    },
    {
        hash            = "s_m_o_busker_01", -- garage vigneron
        pos             = vector3(-1925.4, 2048.01, 140.83),
        heading         = 255.65,
        action          = function()
            garagevigneron()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,
    },
    {
        hash            = "", -- Blips label
        pos             = vector3(2144.15, 7520.90, 8.42),
        heading         = 272.94,
        action          = function()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = false,

        blip_enable     = true,
        sprite          = 136,
        color           = 44, 
        title           = "Label de musique",
        scale           = 0.55,

        img_blip        = true,
        description     = "C'est ici que tous les plus gros bangers de Vice City sont nés !",
        frequency       = "~b~Faible",
        streamed        = "label"
    },
    {
        hash            = "ig_vccop", -- VCPD Blips
        pos             = vector3(3638.81, 5724.01, 0.00),
        heading         = 322.40,
        action          = function()
            --openVcpdReport()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 1,
        freeze          = true,
        msg             = false,

        blip_enable     = true,
        sprite          = 60,
        color           = 3, 
        title           = "Vice City Police Departement",
        scale           = 0.65,

        img_blip        = true,
        description     = "le Vice City Police Department (abrégé VCPD) garantit l'ordre et la sécurité des citoyens au sein de Vice City",
        frequency       = "~o~Moyen",
        streamed        = "vcpd"
    },
    {
        hash            = "u_m_y_pogo_01", 
        pos             = vector3(3353.62, 4900.98, 3.31),
        heading         = 173.09,
        action          = function()
            openMasks(1)
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,

        blip_enable     = true,
        sprite          = 362,
        color           = 18, 
        title           = "Magasin de masques",
        scale           = 0.65,

        img_blip        = true,
        description     = "Toutes les tailles sont disponibles",
    },
    {
        hash            = "s_m_m_lifeinvad_01",
        pos             = vector3(3304.98, 7166.79, 10.18),
        heading         = 262.70,
        action          = function()
            openIllegalMarket()
            CheckSuccesIllegalMenu()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,
    },
    {
        hash            = "g_m_m_armlieut_01", -- Contrebandier
        pos             = vector3(3317.85, 7163.58, 10.18),
        heading         = 53.05,
        action          = function()
            OpenSmugglerSellMenu()
        end,

        spawned         = false,
        entity          = nil,
        load_dst        = 25,
        msg             = true,
        freeze          = true,
        anim            = true,
        animType        = 'TaskStartScenarioInPlace',
        animData        = {
            name        = 'WORLD_HUMAN_GUARD_STAND',
        },


        blip_enable     = false,
        img_blip        = false,
    },
    {
        hash            = "s_m_y_ammucity_01",
        pos             = vector3(2229.93, 5694.04, 10.39),
        heading         = 273.89,
        action          = function()
            openWeaponShopMenu()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,

        blip_enable     = true,
        sprite          = 313,
        color           = 75, 
        title           = "Ammunation",
        scale           = 0.55,

        img_blip        = true,
        description     = "C'est ici que vous pouvez vous procurer des armes légalement, uniquement pour la self-defense bien sûr !",
        frequency       = "~o~Moyen",
        streamed        = "ammu"
    },
    {
        hash            = "mp_f_cardesign_01",
        pos             = vector3(3779.82, 6084.55, 12.29),
        heading         = 357.62,
        action          = function()
            openDrivingMenu()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,

        blip_enable     = true,
        sprite          = 525,
        color           = 4, 
        title           = "Auto-école",
        scale           = 0.65,
    },
    {
        hash            = "a_m_m_golfer_01",
        pos             = vector3(2225.73, 5820.42, 9.91),
        heading         = 214.52,
        action          = function()
            openParachutisme()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 25,
        freeze          = true,
        msg             = true,

        blip_enable     = true,
        sprite          = 94,
        color           = 32, 
        title           = "Parachutisme",
        scale           = 0.50,
    },
    {
        hash            = "a_m_m_golfer_01",
        pos             = vector3(3184.40, 7160.10, 9.89),
        heading         = 327.10,
        action          = function()
            openParachutisme()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 25,
        freeze          = true,
        msg             = true,

        blip_enable     = true,
        sprite          = 94,
        color           = 32, 
        title           = "Parachutisme",
        scale           = 0.50,
    },
    {
        hash            = "a_m_m_golfer_01",
        pos             = vector3(3146.339, 4603.844, 10.0),
        heading         = 147.09,
        action          = function()
            openParachutisme()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 25,
        freeze          = true,
        msg             = true,

        blip_enable     = true,
        sprite          = 94,
        color           = 32, 
        title           = "Parachutisme",
        scale           = 0.50,
    },
    {
        hash            = "a_m_m_golfer_01",
        pos             = vector3(2402.61, 7010.55, 10.05),
        heading         = 138.66,
        action          = function()
            openParachutisme()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 25,
        freeze          = true,
        msg             = true,

        blip_enable     = true,
        sprite          = 94,
        color           = 32, 
        title           = "Parachutisme",
        scale           = 0.50,
    },
    {
        hash            = "", -- Blips Garage Mécano
        pos             = vector3(2389.33, 6480.43, 10.25),
        heading         = 127.51,
        action          = function()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = false,

        blip_enable     = true,
		sprite          = 446,
		color           = 5, 
		title           = "Vice City Customs",
		scale           = 0.65,
	
		img_blip        = true,
		description     = "Venez exprimer votre créativité en customisant vos véhicules chez Vice City Customs !",
		frequency       = "~o~Moyen",
		streamed        = "mecanovice",
    },
    {
        hash            = "s_m_y_xmech_02_mp",
        pos             = vector3(2137.869, 6490.559, 11.21578),
        heading         = 317.46,
        action          = function()
            openimpound_menu(1, 'car')
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,

        blip_enable     = true,
        sprite          = 477,
        color           = 9, 
        title           = "Fourrière",
        scale           = 0.65,

        img_blip        = true,
        description     = "Venez chercher vos véhicules embarqués par la fourrière !",
        frequency       = "~o~Moyen",
        streamed        = "fouriere"
    },
    {
        hash            = "s_m_y_xmech_02_mp",
        pos             = vector3(-1807.05, -2810.24, 13.94),
        heading         = 147.39,
        action          = function()
            openimpound_menu(2, 'helicopter')
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,

        --blip_enable     = true,
        --sprite          = 477,
        --color           = 9, 
        --title           = "Fourrière Hélicopter",
        --scale           = 0.65,
    },
    {
        hash            = "a_m_y_business_03",
        pos             = vector3(-1242.15, -3393.17, 13.94),
        heading         = 58.80,
        action          = function()
            openHelishopCatalogue()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = false,
    },
    {
        hash            = "cs_molly", -- vetement
        pos             = vector3(3487.97, 5202.65, 9.48),
        heading         = 118.22,
        action          = function()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = false,

        blip_enable     = true,
        sprite          = 73,
        color           = 64, 
        title           = "Magasin de vêtements",
        scale           = 0.55,

        img_blip        = true,
        description     = "Exprimez votre style en venant acheter vos vêtements ici !",
        frequency       = "~o~Moyen",
        streamed        = "binco",
    },
    {
        hash            = "cs_molly", -- vetement
        pos             = vector3(2442.41, 7210.17, 10.06),
        heading         = 314.70,
        action          = function()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = false,

        blip_enable     = true,
        sprite          = 73,
        color           = 64, 
        title           = "Magasin de vêtements",
        scale           = 0.55,

        img_blip        = true,
        description     = "Exprimez votre style en venant acheter vos vêtements ici !",
        frequency       = "~o~Moyen",
        streamed        = "binco",
    },
    {
        hash            = "u_m_y_tattoo_01", -- Tattoo Shop
        pos             = vector3(2040.346, 5866.098, 9.879869),
        heading         = 235.98,
        action          = function()
            openTattooShopMenu()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,

        blip_enable     = true,
        sprite          = 75,
        color           = 0, 
        title           = "Tattoo Shop",
        scale           = 0.55,

        img_blip        = true,
        description     = "Venez marquer votre peau avec un design moderne et permanent !",
        frequency       = "~b~Faible",
        streamed        = "tattoo",
    },
    {
        hash            = "s_m_m_hairdress_01", -- Barber Shop
        pos             = vector3(2362.027, 5938.67, 10.01),
        heading         = 267.37,
        action          = function()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = false,

        blip_enable     = true,
        sprite          = 71,
        color           = 51, 
        title           = "Barber Shop",
        scale           = 0.55,

        img_blip        = true,
        description     = "Salon de coiffure",
        frequency       = "~o~Moyen",
        streamed        = "barber",
    },
    {
        hash            = "s_m_m_hairdress_01", -- Barber Shop 2
        pos             = vector3(3676.39, 7522.84, 18.74),
        heading         = 173.12,
        action          = function()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = false,

        blip_enable     = true,
        sprite          = 71,
        color           = 51, 
        title           = "Barber Shop",
        scale           = 0.55,

        img_blip        = true,
        description     = "Salon de coiffure",
        frequency       = "~o~Moyen",
        streamed        = "barber",
    },
    {
        hash            = "u_m_y_tattoo_01", -- Tattoo Shop
        pos             = vector3(3644.338, 6335.057, 10.10405),
        heading         = 356.25,
        action          = function()
            openTattooShopMenu()
        end,
        spawned         = false,
        entity          = nil,
        load_dst        = 35,
        freeze          = true,
        msg             = true,

        blip_enable     = true,
        sprite          = 75,
        color           = 0, 
        title           = "Tattoo Shop",
        scale           = 0.55,

        img_blip        = true,
        description     = "Salon de tatouage",
        frequency       = "~b~Faible",
        streamed        = "tattoo",
    },
    {
        hash            = "cs_molly",
        pos             = vector3(78.92, 112.55, 81.17),
        heading         = 161.95,
        
        action          = function()
            openPostalVestiaire()
        end,

        spawned         = false,
        entity          = nil,
        load_dst        = 25,
        msg             = true,
        freeze          = true,
    },
}

local InZoneMarker = false

Citizen.CreateThread(function()
    while true do
        local ped       = GetPlayerPed(-1)
        local pedCoords = GetEntityCoords(ped)
        for _,v in pairs(npcList) do
            local dst = GetDistanceBetweenCoords(v.pos, pedCoords, true)

            if not v.spawned then
                if dst <= v.load_dst then
                    v.spawned = true
                    InZoneMarker = true

                    if v.npcType == nil then
                        Extasy.LoadModel(v.hash)
                        v.entity = CreatePed(1, v.hash, v.pos.x, v.pos.y, v.pos.z - 1.0, v.heading, 0, 0)
                        if v.freeze == true then
                            SetBlockingOfNonTemporaryEvents(v.entity, true)
                            FreezeEntityPosition(v.entity, true)
                            if v.invincible == nil then
                                SetBlockingOfNonTemporaryEvents(v.entity, true)
                                SetEntityInvincible(v.entity, true)
                            end
                        end

                        if v.anim then
                            if v.animType == 'TaskPlayAnim' then
                                RequestAnimDict(v.animData.dict)
                                while not HasAnimDictLoaded(v.animData.dict) do Citizen.Wait(1) end

                                Citizen.Wait(100)	
                                TaskPlayAnim(v.entity, v.animData.dict, v.animData.name, v.animData.blendIn, v.animData.blendOut, v.animData.duration, v.animData.flag, v.animData.playback, v.animData.lockX, v.animData.lockY, v.animData.lockZ)
                            elseif v.animType == 'TaskStartScenarioInPlace' then
                                SetBlockingOfNonTemporaryEvents(v.entity, true)
                                TaskStartScenarioInPlace(v.entity, v.animData.name, 0, true)
                            end
                        end

                        if v.skin ~= nil then
                            TriggerEvent("skinchanger:applySkinToPed", v.entity, v.skin)
                        end
                        table.insert(active_npc, {pos = v.pos, action = v.action, ped = v.entity, hash = v.hash, msg = v.msg})
                        if v.addToTable then
                            table.insert(v.tableInfo, {ped = v.entity})
                        end
                    elseif v.npcType == 'car' then
                        Citizen.CreateThread(function()
                            if not HasModelLoaded(v.hash) and IsModelInCdimage(v.hash) then
                                RequestModel(v.hash)
                                while not HasModelLoaded(v.hash) do Citizen.Wait(1) end
                            end
                            v.entity = CreateVehicle(v.hash, v.pos, v.heading, false, false)
                            SetVehicleUndriveable()
                            SetVehicleDoorsLocked(v.entity, true)
                            FreezeEntityPosition(v.entity, true)
                            RequestCollisionAtCoord(v.pos.x, v.pos.y, v.pos.z)
                            
                            if v.custom then
                                SetVehicleCustomPrimaryColour(v.entity, v.r, v.g, v.b)
                                SetVehicleCustomSecondaryColour(v.entity, v.r, v.g, v.b)
                                FullVehicleBoostNpc(v.entity)
                            end

                            table.insert(active_npc, {pos = v.pos, action = v.action, ped = v.entity, hash = v.hash, msg = v.msg, r = v.r, v = v.g, b = v.b})
                        end)
                    elseif v.npcType == 'drawmarker' then
                        local checked = false

                        Citizen.CreateThread(function()
                            while InZoneMarker == true do
                                Wait(1)
                                drawmarkerRotation = v.drawmarkerRotation or 0.0

                                if v.marker == true then
                                    DrawMarker(v.drawmarkerType, v.pos, 0.0, 0.0, 0.0, drawmarkerRotation, 0.0, 0.0, v.size, v.size, v.size, v.drawmarkerColorR, v.drawmarkerColorG, v.drawmarkerColorB, 155, 0)
                                end

                                if not checked then
                                    checked = true
                                    table.insert(active_npc, {pos = v.pos, action = v.action, ped = v.entity, hash = v.hash, interactMessage = v.interactMessage, drawmarker = v.drawmarker, drawmarkerSize = v.drawmarkerSize, drawmarkerColorR = v.drawmarkerColorR, drawmarkerColorG = v.drawmarkerColorG, drawmarkerColorB = v.drawmarkerColorB, text3d = v.text3d})
                                end
                            end
                            checked = false 
                        end)
                    end
                end
            else
                if dst > v.load_dst then
                    InZoneMarker = false
                    if DoesEntityExist(v.entity) then
                        v.spawned = false
                        DeleteEntity(v.entity)
                        for k,v in pairs(active_npc) do
                            if v.pos == v.pos then
                                table.remove(active_npc, k)
                            end
                        end
                    else
                        v.spawned = false
                        for k,v in pairs(active_npc) do
                            if v.pos == v.pos then
                                table.remove(active_npc, k)
                            end
                        end
                    end
                else
                    InZoneMarker = true
                end
            end
        end
        Wait(2500)
    end
end)

local player = PlayerPedId()
local coords = GetEntityCoords(player)
local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.00, 0, 70)

Citizen.CreateThread(function()
    while true do
        local near_npc  = false
        local ped       = GetPlayerPed(-1)
        local pedCoords = GetEntityCoords(ped)

        for k,v in pairs(npcList) do
            local dst = GetDistanceBetweenCoords(pedCoords, v.pos, true)
            local v_dst = v.dst or 2.5

            if v.text3d then
                if dst < 10.0 then
                    near_npc = true
                    Extasy.DrawText3D(vector3(v.pos.x, v.pos.y, v.pos.z + 1.15), v.text3d, 1.0, 255, 6)
                end
            end

            if dst <= v_dst then
                near_npc = true
                --if v.hash == "a_c_cow" or v.hash == "a_c_pig" or v.hash == 'a_c_hen' then
                    --ESX.ShowHelpNotification("Appuyez sur ~p~[E] ~w~pour interagir avec cet animal")
                --else
                    if v.msg then
                        Extasy.ShowHelpNotification("Appuyez sur ~p~~INPUT_TALK~ ~w~pour interagir avec ~p~la personne")
                    elseif v.interactMessage ~= nil then
                        InZoneMarker = true
                        Extasy.ShowHelpNotification(v.interactMessage)
                    end
                --end
                if IsControlJustReleased(1, 38) then
                    --if v.isCrew then
                        --if v.crew == playerCrew then
                            --v.action()
                        --else
                            --Extasy.ShowNotification("~r~Cette action est réservée aux crews")
                        --end
                    --else
                        if v.action ~= nil then 
                            v.action()
                        else
                            print(v.pos)
                            print("Débug: Aucune action d'enregistrer")
                        end
                    --end
                end
            end
        end

        if near_npc then
            Wait(1)
        else
            Wait(2300)
        end

        --[[local notified = {}

        Citizen.CreateThread(function()
            while true do
                local pPed = GetPlayerPed(-1)
                local inVeh = IsPedInAnyVehicle(pPed, true)
                local pSpeed = GetEntitySpeed(pPed)
                local vSpeed = math.ceil(pSpeed * 3.6)

                if inVeh then
                    if vSpeed > 80.0 then
                        if not notified["toggleLimit"] then
                            notified["toggleLimit"] = true
                            Extasy.ShowNotification("[ASTUCE]\n~p~La touche pour activer le limitateur de vitesse est ~s~[J]")
                        end
                    end
                end
                Citizen.Wait(7500)
            end
        end)
    
        Citizen.CreateThread(function()
            while true do
                notified = {}
                Citizen.Wait(3 * 60 * 1000)
            end
        end)--]] -- Possible qu'il je sois pas opti (bombarde le cache dynamique)
    end
end)

getBlipsInfo = function()
    return npcList
end

registerNewNPC = function(data)
    table.insert(npcList, data)
end

registerNewMarker = function(data)
    table.insert(npcList, data)
end

-- animData        = {
--     dict        = "mini@strip_club@idles@stripper",
--     name        = "stripper_idle_01",
--     blendIn     = 1.0,
--     blendOut    = 1.0,
--     duration    = -1,
--     flag        = 9,
--     playback    = 1.0,
--     lockX       = 0,
--     lockY       = 0,
--     lockZ       = 0,
-- },

SetRelationshipBetweenGroups(3, GetHashKey("AMBIENT_GANG_HILLBILLY"), GetHashKey('PLAYER'))

local blipsNPC = getBlipsInfo()

Citizen.CreateThread(function()
    for _, info in pairs(blipsNPC) do
        if info.blip_enable then
            --Charger les textures
            RequestStreamedTextureDict("world_blips", 1)
            while not HasStreamedTextureDictLoaded("world_blips") do
                Wait(0)
            end

            info.blip = AddBlipForCoord(info.pos.x, info.pos.y, info.pos.z)
            SetBlipSprite(info.blip, info.sprite)
            SetBlipDisplay(info.blip, 4)
            SetBlipColour(info.blip, info.color)
            SetBlipScale(info.blip, info.scale)
            SetBlipAsShortRange(info.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(info.title)
            EndTextCommandSetBlipName(info.blip)

            if info.img_blip then
                SetBlipInfoTitle(info.blip, info.title, false)
                SetBlipInfoImage(info.blip, "world_blips", info.streamed)
                AddBlipInfoText(info.blip, "Taux de fréquentation", info.frequency)
                AddBlipInfoHeader(info.blip, "")
                AddBlipInfoText(info.blip, info.description)
            end
        end
    end
end)