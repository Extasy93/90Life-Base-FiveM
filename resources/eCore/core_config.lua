extasy_core_cfg = {}
extasy_core_cfg.loaded = false

-- Défault Config
extasy_core_cfg["map_los_santos"]                        = true
extasy_core_cfg["token_security"]                        = true
extasy_core_cfg["anti_troll"]                            = false
extasy_core_cfg["anti-cross"]                            = true
extasy_core_cfg["daily_pieces_activity"]                 = false

-- # Event thème 

extasy_core_cfg["noel_periode"]                          = false
extasy_core_cfg["halloween_periode"]                     = false

-- # Configuration des prix pour les permis de conduire
extasy_core_cfg["license_car_price"]                     = 900
extasy_core_cfg["license_bike_price"]                    = 900
extasy_core_cfg["license_truck_price"]                   = 1300
extasy_core_cfg["license_boat_price"]                    = 1400


extasy_core_cfg["vehicle_break_mult"] 					 = 1
extasy_core_cfg["player_can_have_ped"]                   = false

-- # Configuration sur les prix de revente des entreprises privées
extasy_core_cfg["gopostal_sell_price"]                   = 90
extasy_core_cfg["private_society_sell_price"]            = 50
extasy_core_cfg["little_prick_sell_garbage"]             = 900
extasy_core_cfg["ambulance_transfert_mission"]           = 2500
extasy_core_cfg["ambulance_heal_price"]                  = 7500
extasy_core_cfg["ambulance_revive_price"]                = 15000

-- # Configuration à propos de l'auto-école

extasy_core_cfg["permis_price_voiture"]                  = 800
extasy_core_cfg["permis_price_camion"]                   = 1000
extasy_core_cfg["permis_price_moto"]                     = 500
extasy_core_cfg["permis_price_bateau"]                   = 1500

-- # Configuration saut en parachute 

extasy_core_cfg["parachute_price"]                       = 350

-- # Configuration à propos du job taxi
extasy_core_cfg["taxi_global_mult"]                      = 1
extasy_core_cfg["taxi_min_chance_npc_mission"]           = 100000
extasy_core_cfg["taxi_transfert_mission_price_society"]  = 150
extasy_core_cfg["taxi_transfert_mission_price_player"]   = 50

-- # Configuration de la paye 

extasy_core_cfg["time_to_wait_for_reward_service"]       = 15 -- Temps entre chaques pay en minutes

extasy_core_cfg["reward_money_service_mult"]             = 1.5

extasy_core_cfg["reward_money_service_unemployed"]       = 25

extasy_core_cfg["reward_money_service_vcpd"]             = 85
extasy_core_cfg["reward_money_service_ambulance"]        = 85
extasy_core_cfg["reward_money_service_cityhall"]         = 85
extasy_core_cfg["reward_money_service_vccustoms"]        = 50
extasy_core_cfg["reward_money_service_AgentImmo"]        = 50
extasy_core_cfg["reward_money_service_miner"]            = 50
extasy_core_cfg["reward_money_service_abatteur"]         = 50
extasy_core_cfg["reward_money_service_bucheron"]         = 50
extasy_core_cfg["reward_money_service_greasychopper"]    = 50
extasy_core_cfg["reward_money_service_malibu"]           = 50
extasy_core_cfg["reward_money_service_avocat"]           = 50
extasy_core_cfg["reward_money_service_label"]            = 50
extasy_core_cfg["reward_money_service_tabac"]            = 50
extasy_core_cfg["reward_money_service_taxi"]             = 50
extasy_core_cfg["reward_money_service_oceanview"]        = 50
extasy_core_cfg["reward_money_service_weedshop"]         = 50
extasy_core_cfg["reward_money_service_bikeshop"]         = 50
extasy_core_cfg["reward_money_service_boatshop"]         = 50
extasy_core_cfg["reward_money_service_delivery"]         = 50
extasy_core_cfg["reward_money_service_frontpage"]        = 50
extasy_core_cfg["reward_money_service_pizza"]            = 50
extasy_core_cfg["reward_money_service_weazelnews"]       = 50
extasy_core_cfg["reward_money_service_icecreamcompagny"] = 50

-- # Configuration Factures

extasy_core_cfg["max_billing_amount"] = 2500000
extasy_core_cfg["available_payments_billing"] = { -- Ne pas modifier
    "~b~Banque~s~",
    "~g~Liquide~s~"
}
extasy_core_cfg["available_payments_billing_society"]    = { -- Ne pas modifier
    "~o~Société~s~",
    "~b~Banque~s~",
    "~g~Liquide~s~"
}
-- # Configuration du prix que le joueur doit payer pour sortir son véhicule de la fourrière

extasy_core_cfg["impound_service_price"]                 = 300

-- # Tenues max par joueur

extasy_core_cfg["max_clothes_save"]                      = 10  

-- # Véhicules max par joueurs

extasy_core_cfg["max_vehicle_garage"]                    = 10

-- # Configuration du job concessionnaire

extasy_core_cfg["cardealer_priceMult"]                   = 1
extasy_core_cfg["cardealer_needed_for_automatic_buying"] = 1
extasy_core_cfg["cardealer_automatic_buying"]            = true
extasy_core_cfg["prev_vehicle_testing_price"]            = 5000
extasy_core_cfg["prev_vehicle_testing_time"]             = 60000
extasy_core_cfg["prev_vehicle_testing_dist"]             = 750

-- # Configuration Organisation

extasy_core_cfg["max_org_garage"]                        = 6
extasy_core_cfg["chest_capacity_price"]                  = 5000
extasy_core_cfg["windows_tint_buy"]                      = 90000
extasy_core_cfg["fullCustom"]                            = 245000
extasy_core_cfg["xenonlights_gang"]                      = 55000

-- # Configuration des prix de revente des fruits
extasy_core_cfg["price_fruit_mult"]                      = 1

extasy_core_cfg["framboise_price"]                       = math.random(10, 30)
extasy_core_cfg["mure_price"]                            = math.random(10, 30)
extasy_core_cfg["myrtille_price"]                        = math.random(10, 30)
extasy_core_cfg["pomme_price"]                           = math.random(10, 30)
extasy_core_cfg["orange_price"]                          = math.random(10, 30)

-- # Configurations à propos des braquages épicerie
extasy_core_cfg["shop_min_cops_vcpd"]                    = 4                           -- # Nombre minimum de VCPD connectés pour braquer une épicerie
extasy_core_cfg["shop_money"]                            = math.random(800, 2500)      -- # Combien le joueur reçoit quand il braque une épicerie

-- # Configurations à propos des cambriolages
extasy_core_cfg["cambriolage_min_cops_vcpd"]             = 2                           -- # Nombre minimum de VCPD connectés pour cambrioler une maison

-- # Configuration à propos du vendeur illégal (BlackMarket)
extasy_core_cfg["illegal_shop_clip_price"]               = 300 
extasy_core_cfg["illegal_shop"] = {
    items = {
        {
            name = "Serflex",
            price = 200,
            item = "Serflex",
            index = 1,
        },
        {
            name = "Clé USB (Piratage ATM)",
            price = 800,
            item = "USB",
            index = 1,
        },
        {
            name = "Clé USB KeyLogger (Piratage Banque)",
            price = 1000,
            item = "USB2",
            index = 1,
        },
        {
            name = "Outil de crochetage",
            price = 500,
            item = "Outil_crochetage",
            index = 1,
        },
        {
            name = "Pillule de l'oublie",
            price = 1200,
            item = "piluleoubli",
            index = 1,
        },
        {
            name = "Fausses Plaques D'immatriculation",
            price = 1100,
            item = "Fausses_plaques",
            index = 1,
        },
        --[[{
            name = "Cagoule",
            price = 7500,
            item = "Cagoule",
            index = 1,
        },
        {
            name = "Kevlar tactique I",
            price = 25000,
            item = "Kevlar",
            damage = 30,
            draw = 28,
            texture = 1,
            kevlar = true,
            index = 1,
        },
        {
            name = "Kevlar tactique I",
            price = 25000,
            item = "Kevlar",
            damage = 30,
            draw = 28,
            texture = 2,
            kevlar = true,
            index = 1,
        },
        {
            name = "Kevlar de combat I",
            price = 40000,
            item = "Kevlar",
            damage = 30,
            draw = 17,
            texture = 1,
            kevlar = true,
            index = 1,
        },
        {
            name = "Kevlar de combat I",
            price = 40000,
            item = "Kevlar",
            damage = 30,
            draw = 17,
            texture = 2,
            kevlar = true,
            index = 1,
        },
        {
            name = "Kevlar de combat II",
            price = 40000,
            item = "Kevlar",
            damage = 30,
            draw = 18,
            texture = 1,
            kevlar = true,
            index = 1,
        },
        {
            name = "Kevlar de combat II",
            price = 40000,
            item = "Kevlar",
            damage = 30,
            draw = 18,
            texture = 2,
            kevlar = true,
            index = 1,
        },--]]
    },
}

-- # Configuration de l'activité braquage
extasy_core_cfg["cayoperico_heist"]          = 20000
extasy_core_cfg["pacific_heist"]             = math.random(40000, 50000)
extasy_core_cfg["fleeca_reward_money"]       = math.random(40000, 50000)
-- #

-- # Paiements acceptés pour les épiceries, les tatoueurs, le vendeur de masques
extasy_core_cfg["available_payments"] = {
    "~b~Banque~s~",
    "~g~Liquide~s~",
    "~c~Source inconnue~s~"
}
 
RegisterNetEvent("extasy_core_cfg_loaded")
AddEventHandler("extasy_core_cfg_loaded", function(token)
    if not CheckToken(token, source, "extasy_core_cfg_loaded") then return end
    extasy_core_cfg.loaded = true
end)

--TriggerServerEvent("Extasy:InitialiseBddForOrg")