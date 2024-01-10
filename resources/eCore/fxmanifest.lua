fx_version "bodacious"

game "gta5"

author "Extasy#0093"
description "eCore"
version "2.1"
data_file "DLC_ITYP_REQUEST" "vw_prop_vw_collectibles.ytyp" -- EasterEgg Dependency

--Loading Screen--
files {
	'LoadingScreen/style.css',
	'LoadingScreen/script.js',
	'LoadingScreen/music.mp3',
	'LoadingScreen/logo.png',
	'LoadingScreen/index.html'
}

loadscreen 'LoadingScreen/index.html'

--

client_scripts {
    "@eExtended/locale.lua", --BASE
    "LoadingScreen/cl_loadingscreen.lua",

    "core_config.lua",
    "utils/utils.lua", -- Utils D�pendence for eCore
    "utils/scaleforms.lua",
    "utils/bob_ipl.lua", -- IPLS
    "utils/cl_deleteWeaponCops.lua", -- Delete Weapons Car Cops

    ----------------- D�pendency ------------------

    "dependency/Basicneeds/cl_basicneeds.lua",
    "dependency/Basicneeds/cl_status.lua",

    "dependency/propertyD/cfg_propertyD.lua",
    "dependency/propertyD/cl_propertyD.lua",

    "dependency/Instance/config.lua",
	"dependency/Instance/cl_instance.lua",

    "dependency/Doorlock/config.lua",
	"dependency/Doorlock/cl_doorlock.lua",

	"dependency/Skinchanger/cl_skinchanger_locale.lua",
    "dependency/Skinchanger/config.lua",
    "dependency/Skinchanger/cl_skinchanger.lua",
	"dependency/Skinchanger/cl_skinchanger_module.lua",

    "dependency/RageUI/src/RMenu.lua", -- RAGE UI
    "dependency/RageUI/src/menu/RageUI.lua", -- RAGE UI
    "dependency/RageUI/src/menu/Menu.lua", -- RAGE UI
    "dependency/RageUI/src/menu/MenuController.lua", -- RAGE UI
    "dependency/RageUI/src/components/*.lua", -- RAGE UI
    "dependency/RageUI/src/menu/elements/*.lua", -- RAGE UI
    "dependency/RageUI/src/menu/items/*.lua", -- RAGE UI
    "dependency/RageUI/src/menu/panels/*.lua", -- RAGE UI
    "dependency/RageUI/src/menu/panels/*.lua", -- RAGE UI
    "dependency/RageUI/src/menu/windows/*.lua", -- RAGE UI

    "player_handler/cl_card.lua",
    "player_handler/cl_commandes.lua",
    "player_handler/getter.lua",
    "player_handler/key.lua",
    "player_handler/animationHansdler.lua",
    "player_handler/oxygen.lua", -- Gym

    "Login/cl_login.lua",

    "hud/cfg_hud.lua", -- HUD
    "hud/cl_hud.lua", -- HUD

    "Jobs/Org/cfg_org.lua", -- Syst�me d'organisation / Gangs
    "Jobs/Org/cl_org.lua", -- Syst�me d'organisation / Gangs

    "Menu_system/config.lua", -- Config global des menus en RUI
    "Menu_system/client/client_global.lua",
    "Menu_system/client/fuel_client.lua",
    "Menu_system/client/thread.lua",
    "Menu_system/client/shop/*.lua",
    "Menu_system/client/starter_pack/*.lua",
    
    "npc/npc.lua", -- PNJ / NPC 
    "npc/blips.lua", -- PNJ / NPC 
    "npc/cars.lua", -- PNJ / NPC 
    "npc/DrawMarker.lua", -- PNJ / NPC 
    "npc/peds.lua", -- PNJ / NPC 
    "npc/peds2.lua", -- PNJ / NPC 
    "npc/vprompt.lua",

    "bank/cl_bank.lua",
    "bank/cl_bank_handler.lua",
    "bank/bank_hacking/cl_bank_hacking.lua",

    "shops_robbery/cfg_shops_robbery.lua", -- Sup�rette 
    "shops_robbery/cl_shops_robbery.lua", -- Sup�rette
    
    "barber_handler/cfg_barber.lua",
    "barber_handler/cl_barber.lua",
    "barber_handler/makeup/cfg_makeup.lua",
    "barber_handler/makeup/cl_makeup.lua",

    "simpleRobberys/cfg_simpleRobberys.lua", -- Simple Robbery
    "simpleRobberys/computer.lua", -- Simple Robbery
    "simpleRobberys/cl_simpleRobberys.lua", -- Simple Robbery
    "simpleRobberys/utils_drilling.lua", -- Simple Robbery

    "BlackMarket/cfg_blackmarket.lua", -- Ill�gal Shop
    "BlackMarket/cl_blackmarket.lua", -- Ill�gal Shop

    "Weather/cl_weather.lua", -- Gestion du temps (/time, /weather)

    "garage/cfg_*.lua", --garage
    "garage/cl_*.lua",

    "prostitutes/cfg_prostitutes.lua", -- Syst�me de prostitu�es
    "prostitutes/cl_prostitutes.lua", -- Syst�me de prostitu�es

    "EasterEgg/cl_easteregg.lua", -- Systeme de figurines (EasterEgg)

    "Chaise/cl_chaise.lua", -- Chaise en props

    "Lottery/cfg_lottery.lua", -- Lottery  
    "Lottery/cl_lottery.lua", -- Lottery  

    "Radio/cfg_radio.lua", -- radio
    "Radio/cl_radio.lua", -- radio

    "Identity/cfg_identity.lua", -- identity
    "Identity/cl_identity.lua", -- identity
    "Identity/cl_functions.lua", -- identity
    "Identity/starter_pack/cl_starter_pack.lua", -- identity Starter Pack

    "Animalerie/cfg_animalerie.lua", -- Animalerie
    "Animalerie/cl_animalerie.lua", -- Animalerie

    "Cross/cfg_cross.lua", -- Terrain de cross
    "Cross/cl_cross.lua", -- Terrain de cross

    "spray/cfg_spray.lua", -- Spray
    "spray/cl_spray.lua", -- Spray

    --"WheelArcade/cl_WheelArcade.lua", -- Arcade
    "arcade/cfg_arcade.lua", -- Arcade
    "arcade/cl_arcade.lua", -- Arcade

    "Gym/cfg_gym.lua", -- Gym
    "Gym/cl_gym.lua", -- Gym

    "ClothesShop/cfg_clothesshop.lua", -- ClothesShop
    "ClothesShop/cl_clothesshop.lua", -- ClothesShop

    "TattooShop/cfg_tattooshop.lua", -- TattooShop
    "TattooShop/cl_tattooshop.lua", -- TattooShop

    "Cambriolage/cfg_cambriolage.lua", -- Cambriolage Systeme
    "Cambriolage/cl_cambriolage.lua", -- Cambriolage Systeme

    "fakeplate/cfg_fakeplate.lua", -- Fausse plaque
    "fakeplate/client/client.lua", -- Fausse plaque
    "fakeplate/client/utils.lua", -- Fausse plaque

    "Helicam/cl_heli.lua", -- Cam�ra h�licopt�re

    "Tebex/cfg_tebex.lua", -- Liaison de la boutique automatique tebex
    "Tebex/cl_tebex.lua", -- Liaison de la boutique automatique tebex

    "Chasse/cl_chasse.lua", -- Systeme de chasse

    "Fishing/cfg_fishing.lua", -- Script de peche
    "Fishing/cl_fishing.lua", -- Script de peche

    "Parachutisme/cfg_parachutisme.lua", -- Script de parachutage
    "Parachutisme/cl_parachutisme.lua", -- Script de parachutage

    "Coffre/config.lua", -- Coffre
    "Coffre/cl_coffre_menu.lua", -- Coffre

    "AutoEvents/cl_main.lua", -- AutoEvent
    "AutoEvents/EventModule/package.lua", -- AutoEvent Module
    "AutoEvents/EventModule/fourgon.lua", -- AutoEvent Module

    "driving_school/cfg_drivingschool.lua", -- Auto Ecole
    "driving_school/cl_drivingschool.lua", -- Auto Ecole

    "prison/cl_prison.lua", -- Systeme de prison

    "Ban/cfg_ban.lua", -- Systeme de banissement
    "Ban/cl_ban.lua", -- Systeme de banissement

    "LTD_rob/config.lua", -- Braquage de superettes
    "LTD_rob/cl_rob.lua", -- Braquage de superettes

    "reticle/reticle.lua", -- Pas de Viseur

    "me/cl_me.lua", -- /me

    "Mask/cfg_mask.lua", -- Mask
    "Mask/cl_mask.lua", -- Mask

    "Holograms/cl.lua", -- Textes holographique au Spawn

    "sac/client.lua", --Sac

    "Armes/cl_animweapon.lua", -- Cin�matique Armes

    "zone/client.lua", -- Zone Safe

    "location/cfg_location.lua", --Config location
    "location/cl_location.lua", --location

    "clip/cl_clip.lua", --Chargeurs

    "drogues/cl_coords.lua",--Syst�me de drogues
    "drogues/cfg_drugs_four.lua",--Syst�me de drogues vente
    "drogues/cl_drugs_four.lua",--Syst�me de drogues vente
    "drogues/cl_coke_vente.lua",--Syst�me de drogues vente

    "Emotes/Config.lua", -- Menu DPEmotes
    "Emotes/Client/*.lua", -- Menu DPEmotes

    "stand/cl_stand.lua", --Stand de tire

    "pillule/cl_oblivionPill.lua", -- Pillule de l"oublie

    "DiscordBot/config.lua",-- logs Disocrd
    "DiscordBot/config.lua",-- logs Disocrd
    "DiscordBot/client/Client.lua",-- logs Disocrd

    "interact_cmds/cl_porter.lua", -- /porter
    "interact_cmds/cl_otage.lua", -- /otage
    "interact_cmds/cl_me.lua", -- /me
    "interact_cmds/cl_tackle.lua", -- Takle

    "Failure/config.lua", -- D�gats v�hcule
    "Failure/client.lua", -- D�gats v�hcule

    "CacherCoffre/client.lua", -- Se cacher dans un coffre

    "jumelles/client.lua", -- Jumelles 

    "teleport/cl_teleport.lua",

    "NoMoreTroll/cl_nomoretroll.lua", -- nomoretroll

    "MenuAdmin/cfg_menustaff.lua", --Menu Admin
    "MenuAdmin/cl_menu.lua", --Menu Admin

    "MenuBeta/cl_beta.lua", --Menu Beta
    "MenuBeta/cfg_beta.lua",

    "missionsbuilder/shared/*.lua",
    "missionsbuilder/client/*.lua",

    "Activity/illegal_daily_pieces/cfg_illegal_daily_pieces.lua",
    "Activity/illegal_daily_pieces/cl_illegal_daily_pieces.lua",
    "Activity/recolt_activity/cfg_recolt_activity.lua",
    "Activity/recolt_activity/cl_recolt_activity.lua",
    "Activity/pedalo/cfg_pedalo.lua",
    "Activity/pedalo/cl_pedalo.lua",

    "auto_mapper/cfg_auto_mapper.lua",
    "auto_mapper/cl_auto_mapper.lua",

    "Hotel/cfg_hotel.lua", -- Hotel   
    "Hotel/cl_hotel.lua", -- Hotel

    "Tv/cfg_tv.lua", -- TV
    "Tv/cl_tv.lua", -- TV

    "serflex/cfg_serflex.lua", -- Serflex
    "serflex/cl_serflex.lua", -- Serflex

    "boombox/cl_boombox.lua",

    --------------- JOBS -----------------

    "Jobs/cl_jobs.lua",

    "Jobs/easyBlacklist/cfg_easyBlacklist.lua",
    "Jobs/easyBlacklist/cl_easyBlacklist.lua",

    "Jobs/Society/cfg_society.lua",
    "Jobs/Society/cl_society.lua",

    "Jobs/Facture/cl_facture.lua",

    "Jobs/cl_load.lua",

    "Jobs/Blanchisseur/cfg_money_wash.lua",
    "Jobs/Blanchisseur/cl_blanchisseur.lua",

    "Jobs/Ocean_view/cfg_ocean_view.lua",
    "Jobs/Ocean_view/cl_ocean_view.lua",
    "Jobs/Ocean_view/firework/progressive.lua",
    "Jobs/Ocean_view/firework/statique.lua",

    "Jobs/GreasyChopper/cfg_thegreasychopper.lua",
    "Jobs/GreasyChopper/cl_thegreasychopper.lua",

    "Jobs/WeazelNews/cfg_weazel_news.lua",
    "Jobs/WeazelNews/cl_weazel_news.lua",
    "Jobs/WeazelNews/addons/cl_addons.lua",

    "Jobs/customs/config.lua",
	"Jobs/customs/functions.lua",
	"Jobs/customs/client/main.lua",

    "Jobs/Vcpd/cfg_vcpd.lua",
    "Jobs/Vcpd/cl_vcpd.lua",
    "Jobs/Vcpd/modules/manager.lua",
    "Jobs/Vcpd/modules/zonesManager.lua",
    "Jobs/Vcpd/k9/cl_k9.lua",

    "Jobs/Bennys/client/*.lua",
    "Jobs/Bennys/config.lua",

    "Jobs/VcCustoms/cfg_vccustoms.lua",
    "Jobs/VcCustoms/cl_vccustoms.lua",

    "Jobs/Malibu/cfg_malibu.lua",
    "Jobs/Malibu/cl_malibu.lua",
    "Jobs/Malibu/firework/progressive.lua",
    "Jobs/Malibu/firework/statique.lua",

    "Jobs/Cafe/cfg_cafe.lua",
    "Jobs/Cafe/cl_cafe.lua",

    "Jobs/Robina/cfg_robina.lua",
    "Jobs/Robina/cl_robina.lua",

    "Jobs/Icecream/cfg_icecream.lua",
    "Jobs/Icecream/cl_icecream.lua",

    "Jobs/Pizza/cl_pizza.lua",

    "Jobs/Gouvernement/cl_gouv.lua",

    "Jobs/Grossiste/cl_grossiste.lua",
    "Jobs/Grossiste/cfg_grossiste.lua",

    "Jobs/yellowJack/cfg_yellowJack.lua",
    "Jobs/yellowJack/cl_yellowJack.lua",

    "Jobs/Bahamas/cl_coffre.lua",
    "Jobs/Bahamas/cl_menu.lua",
    "Jobs/Bahamas/config.lua",

    "Jobs/RealEstateAgency/cfg_realestateagency.lua",
	"Jobs/RealEstateAgency/cl_realestateagency.lua",
    "Jobs/RealEstateAgency/cl_instance.lua",

	"Jobs/Taxi/cfg_taxi.lua",
    "Jobs/Taxi/cl_taxi.lua",

    "Jobs/Joblisting/config.lua",
    "Jobs/Joblisting/jobs/Camioneur/cl_camioneur.lua",
    "Jobs/Joblisting/cl_joblist.lua",

    "Jobs/Gouvernement/cl_garage.lua",

    "Jobs/Concess/cfg_concess.lua",
    "Jobs/Concess/cl_concess.lua",
    "Jobs/Concess/cl_concess_utils.lua",

    "Jobs/BoatShop/cfg_boatshop.lua",
    "Jobs/BoatShop/cl_boatshop.lua",

    "Jobs/BikeShop/cfg_bikeshop.lua",
    "Jobs/BikeShop/cl_bikeshop.lua",

    "Jobs/Ambulance/cfg_ambulance.lua",
    "Jobs/Ambulance/cl_ambulance.lua",

    "Jobs/FarmJobs/interim.lua",
    "Jobs/FarmJobs/functions.lua",
    "Jobs/FarmJobs/metiers/bucheron.lua",
    "Jobs/FarmJobs/metiers/mineur.lua",
    "Jobs/FarmJobs/functions_job.lua",

    "Jobs/Avocat/cfg_avocat.lua",
    "Jobs/Avocat/cl_avocat.lua",

    "Jobs/Cityhall/cfg_cityhall.lua",
    "Jobs/Cityhall/cl_cityhall.lua",

    "Jobs/Vendeurarme/config.lua",
    "Jobs/Vendeurarme/client.lua",

    "Jobs/Run_farm/client.lua",

    "Jobs/WeedShop/cl_weedshop.lua",
    "Jobs/WeedShop/cfg_weedshop.lua",

    "Jobs/Vigneron/client.lua",
    "Jobs/Vigneron/config.lua",

    "Jobs/Tabac/cfg_tabac.lua",
    "Jobs/Tabac/cl_tabac.lua",
    
    "Jobs/Label/cl_label.lua",

    "Jobs/Abatteur/cfg_abatteur.lua",
    "Jobs/Abatteur/cl_abatteur.lua",

    "Jobs/Craigslist/cl_craigslist.lua",

    "Jobs/GoPostal/cfg_postal.lua", -- Gopostal
    "Jobs/GoPostal/cl_postal.lua",

    "MenuPerso/cfg_menuPerso.lua", -- Menu Perso
    "MenuPerso/cl_menuPerso.lua", -- Menu Perso
    "MenuPerso/cl_anim.lua", -- Menu Perso
    "MenuPerso/PropsMenu/cl_props.lua", -- Menu props

    "ammunation/cfg_ammunation.lua",
    "ammunation/cl_ammunation.lua",

    "Activity/armWrestling/cfg_armWrestling.lua", -- Bras de fer
    "Activity/armWrestling/cl_armWrestling.lua",

    "Vape/cfg_vape.lua",
    "Vape/Client/*.lua",
}

server_scripts {
    "@eExtended/locale.lua", --BASE
    "@eExtended/async.lua", --BASE
    "@mysql-async/lib/MySQL.lua", --BASE

    "core_config_server.lua",
    "utils/log.lua", -- Logs Système

    ----------------- D�pendency ------------------

    "dependency/Addonaccount/sv_addonaccount.lua",
	"dependency/Addonaccount/sv_main.lua",

    "dependency/Addoninventory/sv_addoninventory.lua",
	"dependency/Addoninventory/sv_main.lua",

    "dependency/Datastore/sv_datastore.lua",
	"dependency/Datastore/sv_main.lua",

    "dependency/Basicneeds/sv_basicneeds.lua",

    "dependency/propertyD/cfg_propertyD.lua",
    "dependency/propertyD/sv_propertyD.lua",

    "dependency/Instance/config.lua",
	"dependency/Instance/sv_instance.lua",

    "dependency/Doorlock/config.lua",
	"dependency/Doorlock/sv_doorlock.lua",

    "dependency/Skinchanger/config.lua",
    "dependency/Skinchanger/sv_skinchanger.lua",

    ----------------- CORE ------------------

    "player_handler/sv_tokenGenial.lua",
    "player_handler/sv_getter.lua",
    "player_handler/sv_commandes.lua",
    "player_handler/sv_key.lua",
    "player_handler/sv_card.lua",

    "Jobs/sv_jobs.lua",
    
    "Login/sv_login.lua",

    "Menu_system/server/F7/config.lua", -- Menu F7 (satff)
    "Menu_system/server/F7/ASP/server.lua", -- Menu F7 (satff)
    "Menu_system/server/F7/server.lua", -- Menu F7 (satff)
    "Menu_system/server/F7/srv_staffmod.lua", -- Menu F7 (satff)

    "Menu_system/server/sv_barbershop.lua", 

    "Menu_system/server/*.lua",
    "Menu_system/locales/fr.lua",
    "Menu_system/config.lua",

    "bank/sv_bank.lua",

    "Tebex/cfg_tebex.lua",
    "Tebex/sv_tebex.lua",

    "Chasse/sv_chasse.lua", -- Systeme de chasse

    "Cross/cfg_cross.lua", -- Terrain de Cross
    "Cross/sv_cross.lua", -- Terrain de Cross

    "spray/cfg_spray.lua", -- Spray
    "spray/sv_spray.lua", -- Spray

    --"WheelArcade/sv_WheelArcade.lua",
    "arcade/cfg_arcade.lua", -- Arcade
    "arcade/sv_arcade.lua", -- Arcade

    "Identity/cfg_identity.lua", -- RAGEUI identity
    "Identity/sv_identity.lua", -- RAGEUI identity 
    "Identity/starter_pack/sv_starter_pack.lua", -- identity Starter Pack
    
    "DiscordAPI/commands.lua", --Commande discord vers serveur

    "missionsbuilder/shared/*.lua",
    "missionsbuilder/server/*.lua",

    "Coffre/config.lua", 
    "Coffre/sv_c_truck.lua",
    "Coffre/sv_main.lua",
    "Coffre/sv_truck.lua",

    "Fishing/cfg_fishing.lua", -- Script de peche
    "Fishing/sv_fishing.lua", -- Script de peche

    "prostitutes/sv_prostitutes.lua",

    "EasterEgg/sv_easteregg.lua", -- Systeme de figurines (EasterEgg)

    "Hotel/cfg_hotel.lua", -- Hotel   
    "Hotel/sv_hotel.lua", -- Hotel

    "Lottery/cfg_lottery.lua", -- Lottery  
    "Lottery/sv_lottery.lua", -- Lottery  

    "Animalerie/cfg_animalerie.lua", -- Animalerie
    "Animalerie/sv_animalerie.lua", -- Animalerie

    "prison/sv_prison.lua", -- Systeme de prison

    "Cambriolage/cfg_cambriolage.lua", -- Cambriolage Systeme
    "Cambriolage/sv_cambriolage.lua", -- Cambriolage Systeme

    "driving_school/cfg_drivingschool.lua", -- Auto Ecole
    "driving_school/sv_drivingschool.lua", -- Auto Ecole

    "me/sv_me.lua", -- /me

    "npc/sv.lua",-- NPC GLOBAL

    "shops_robbery/cfg_shops_robbery.lua", -- Sup�rette 
    "shops_robbery/sv_shops_robbery.lua", -- Sup�rette 

    "barber_handler/sv_barber.lua",

    "simpleRobberys/cfg_simpleRobberys.lua", -- Simple Robbery
    "simpleRobberys/sv_simpleRobberys.lua", -- Simple Robbery

    "BlackMarket/cfg_blackmarket.lua", -- Ill�gal Shop
    "BlackMarket/sv_blackmarket.lua", -- Ill�gal Shop

    "Ban/cfg_ban.lua", -- Systeme de banissement
    "Ban/sv_ban.lua", -- Systeme de banissement

    "SaveSQL/cfg_saveSQL.lua", -- /SaveSQL
    "SaveSQL/sv_saveSQL.lua", -- /SaveSQL

    "LTD_rob/config.lua", -- Braquage des superettes
    "LTD_rob/sv_rob.lua", -- Braquage des superettes

    "garage/cfg_*.lua", --garage
    "garage/sv_*.lua",

    "ClothesShop/cfg_clothesshop.lua", -- ClothesShop
    "ClothesShop/sv_clothesshop.lua", -- Clothesshop

    "TattooShop/sv_tattooshop.lua", -- TattooShop

    "fakeplate/cfg_fakeplate.lua", -- Fausse plaque
    "fakeplate/server/*.lua", -- Fausse plaque

    "location/sv_location.lua",--location

    "clip/sv_clip.lua",--Chargeurs

    "Parachutisme/sv_parachutisme.lua", -- Script de parachutage

    "me/cl_me.lua", --/me

    "NotifCommands/sv_notif.lua", -- Notif Commande en jeu

    "pillule/sv_oblivionPill.lua", --Pillule de l"oublie

    "jumelles/server.lua", -- Jumelles

    "Mask/sv_mask.lua", -- Mask

    "Petshop/config.lua", -- Petshop
    "Petshop/sv_petshop.lua", -- Petshop

    "NoMoreTroll/sv_nomoretroll.lua", -- nomoretroll

    "Weather/sv_weather.lua", -- Gestion du temps (/time, /weather)

    "AutoEvents/srv_loop.lua", -- AutoEvent

    "Tv/cfg_tv.lua", --
    "Tv/sv_tv.lua", -- 

    "serflex/cfg_serflex.lua", -- Serflex
    "serflex/sv_serflex.lua", -- Serflex

    "boombox/sv_boombox.lua", -- Boombox

	"DiscordBot/config.lua",-- logs Disocrd
	"DiscordBot/server/main.lua",-- logs Disocrd
    "drogues/srv_coords.lua", --System de drogues
    "drogues/cfg_drugs_four.lua",--Syst�me de drogues vente
    "drogues/sv_drugs_four.lua",--Syst�me de drogues vente
    "drogues/sv_coke_vente.lua",--Syst�me de drogues vente
    "DiscordBot/Logs/taxi.log",-- logs Disocrd

    "MenuAdmin/cfg_menustaff.lua", --Menu Admin
    "MenuAdmin/server/ASP/server.lua", --Menu Admin
    "MenuAdmin/server/server.lua", --Menu Admin

    "Activity/illegal_daily_pieces/sv_illegal_daily_pieces.lua",
    "Activity/recolt_activity/sv_recolt_activity.lua",
    "Activity/pedalo/cfg_pedalo.lua",
    "Activity/pedalo/sv_pedalo.lua",

    "interact_cmds/sv_porter.lua", -- /porter
    "interact_cmds/sv_otage.lua", -- /otage
    "interact_cmds/sv_me.lua", -- /me
    "interact_cmds/sv_tackle.lua", -- Takle

    --------------- JOBS -----------------

    "Jobs/easyBlacklist/cfg_easyBlacklist.lua",
    "Jobs/easyBlacklist/sv_easyBlacklist.lua",

    "Jobs/Society/cfg_society.lua",
    "Jobs/Society/sv_society.lua",

    "Jobs/Facture/sv_facture.lua",

    "Jobs/Org/cfg_org.lua",
    "Jobs/Org/sv_org.lua",

    "Jobs/Blanchisseur/cfg_money_wash.lua",
    "Jobs/Blanchisseur/sv_blanchisseur.lua",

    "Jobs/Ocean_view/cfg_ocean_view.lua",
    "Jobs/Ocean_view/sv_ocean_view.lua",

    "Jobs/GreasyChopper/cfg_thegreasychopper.lua",
    "Jobs/GreasyChopper/sv_thegreasychopper.lua",

    "Jobs/WeazelNews/cfg_weazel_news.lua",
    "Jobs/WeazelNews/sv_weazel_news.lua",

    "Jobs/customs/config.lua",
	"Jobs/customs/functions.lua",
	"Jobs/customs/server/main.lua",

    "Jobs/Vcpd/cfg_vcpd.lua",
    "Jobs/Vcpd/sv_vcpd.lua",

    "Jobs/Malibu/cfg_malibu.lua",
    "Jobs/Malibu/sv_malibu.lua",

    "Jobs/Cafe/cfg_cafe.lua",
    "Jobs/Cafe/sv_cafe.lua",

    "Jobs/Robina/cfg_robina.lua",
    "Jobs/Robina/sv_robina.lua",

    "Jobs/Icecream/cfg_icecream.lua",
    "Jobs/Icecream/sv_icecream.lua",

    "Jobs/Pizza/sv_pizza.lua",

    "Jobs/Gouvernement/sv_gouv.lua",

    "Jobs/Grossiste/cfg_grossiste.lua",
    "Jobs/Grossiste/sv_grossiste.lua",

    "Jobs/Bennys/config.lua",
    "Jobs/Bennys/server/server.lua",

    "Jobs/VcCustoms/cfg_vccustoms.lua",
    "Jobs/VcCustoms/sv_vccustoms.lua",

    "Jobs/yellowJack/cfg_yellowJack.lua",
    "Jobs/yellowJack/sv_yellowJack.lua",

    "Jobs/Bahamas/config.lua",
    "Jobs/Bahamas/sv_main.lua",
    "Jobs/Bahamas/sv_bahamas.lua",

    "Jobs/RealEstateAgency/cfg_realestateagency.lua",
	"Jobs/RealEstateAgency/sv_realestateagency.lua",
    "Jobs/RealEstateAgency/sv_instance.lua",

	"Jobs/Taxi/cfg_taxi.lua",
    "Jobs/Taxi/sv_taxi.lua",

    "Jobs/Joblisting/config.lua",
    "Jobs/Joblisting/jobs/Camioneur/sv_camioneur.lua",
    "Jobs/Joblisting/jobs/Menuisier/sv_menuisier.lua",
    "Jobs/Joblisting/sv_joblist.lua",

    "Jobs/Concess/cfg_concess.lua",
    "Jobs/Concess/sv_concess.lua",

    "Jobs/BoatShop/cfg_boatshop.lua",
    "Jobs/BoatShop/sv_boatshop.lua",

    "Jobs/BikeShop/cfg_bikeshop.lua",
    "Jobs/BikeShop/sv_bikeshop.lua",

    "Jobs/Ambulance/cfg_ambulance.lua",
    "Jobs/Ambulance/sv_ambulance.lua",

    "Jobs/Avocat/cfg_avocat.lua",
    "Jobs/Avocat/sv_avocat.lua",

    "Jobs/Cityhall/cfg_cityhall.lua",
    "Jobs/Cityhall/sv_cityhall.lua",

    "Jobs/Vendeurarme/config.lua",
    "Jobs/Vendeurarme/server.lua",

    "Jobs/Run_farm/server.lua",

    "Jobs/WeedShop/sv_weedshop.lua",

    "Jobs/Vigneron/server.lua",

    "Jobs/Tabac/cfg_tabac.lua",
    "Jobs/Tabac/sv_tabac.lua",

    "Jobs/Label/sv_label.lua",

    "Jobs/Craigslist/sv_craigslist.lua",

    "Jobs/Abatteur/cfg_abatteur.lua",
    "Jobs/Abatteur/sv_abatteur.lua",

    "Jobs/GoPostal/cfg_postal.lua", -- Gopostal
    "Jobs/GoPostal/sv_postal.lua",

    "MenuPerso/sv_menuPerso.lua", --Menu Perso
    "MenuPerso/sv_anim.lua", -- Menu Perso

    "Activity/armWrestling/cfg_armWrestling.lua", -- Bras de fer
    "Activity/armWrestling/sv_armWrestling.lua", -- Bras de fer

    "teleport/sv_teleport.lua",

    "Vape/cfg_vape.lua",
    "Vape/Server/*.lua",
}

----------- Speedometer -----------

ui_page "speedometer/ui/index.html"

files {
	"speedometer/ui/index.html",
	"speedometer/ui/assets/clignotant-droite.svg",
	"speedometer/ui/assets/clignotant-gauche.svg",
	"speedometer/ui/assets/feu-position.svg",
	"speedometer/ui/assets/feu-route.svg",
	"speedometer/ui/assets/fuel.svg",
	"speedometer/ui/fonts/fonts/Roboto-Bold.ttf",
	"speedometer/ui/fonts/fonts/Roboto-Regular.ttf",
	"speedometer/ui/script.js",
	"speedometer/ui/style.css",
	"speedometer/ui/debounce.min.js"
}
client_scripts {
	"speedometer/client.lua",
}

-- Exports --
export "getPlayerVip"
export "IsAnyMenuOpenned"
export "Addbank_transac"
export "Extasy_ShowNotification"

server_exports {
    "AddPlayerLog",
    "CheckToken",
    "SendLog",
}