ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
end)

RMenu.Add('PropsMenu', 'main', RageUI.CreateMenu("Menu Props", "Catégories"))
RMenu:Get('PropsMenu', 'main').EnableMouse = false
RMenu:Get('PropsMenu', 'main').Closed = function()
end;

RMenu.Add('PropsMenu', 'object', RageUI.CreateSubMenu(RMenu:Get('PropsMenu', 'main'), "Props", "Appuyer sur ~p~[E] ~s~pour poser les objets"))
RMenu.Add('PropsMenu', 'object2', RageUI.CreateSubMenu(RMenu:Get('PropsMenu', 'main'), "Props", "Appuyer sur ~p~[E] ~s~pour poser les objets"))
RMenu.Add('PropsMenu', 'object3', RageUI.CreateSubMenu(RMenu:Get('PropsMenu', 'main'), "Props", "Appuyer sur ~p~[E] ~s~pour poser les objets"))
RMenu.Add('PropsMenu', 'object4', RageUI.CreateSubMenu(RMenu:Get('PropsMenu', 'main'), "Props", "Appuyer sur ~p~[E] ~s~pour poser les objets"))
RMenu.Add('PropsMenu', 'object5', RageUI.CreateSubMenu(RMenu:Get('PropsMenu', 'main'), "Props", "Appuyer sur ~p~[E] ~s~pour poser les objets"))
RMenu.Add('PropsMenu', 'object6', RageUI.CreateSubMenu(RMenu:Get('PropsMenu', 'main'), "Props", "Catégories"))
RMenu.Add('PropsMenu', 'object6-0', RageUI.CreateSubMenu(RMenu:Get('PropsMenu', 'object6'), "Props", "Appuyer sur ~p~[E] ~s~pour poser les objets"))
RMenu.Add('PropsMenu', 'object6-1', RageUI.CreateSubMenu(RMenu:Get('PropsMenu', 'object6'), "Props", "Appuyer sur ~p~[E] ~s~pour poser les objets"))
RMenu.Add('PropsMenu', 'object6-2', RageUI.CreateSubMenu(RMenu:Get('PropsMenu', 'object6'), "Props", "Appuyer sur ~p~[E] ~s~pour poser les objets"))
RMenu.Add('PropsMenu', 'object6-3', RageUI.CreateSubMenu(RMenu:Get('PropsMenu', 'object6'), "Props", "Appuyer sur ~p~[E] ~s~pour poser les objets"))
RMenu.Add('PropsMenu', 'object7', RageUI.CreateSubMenu(RMenu:Get('PropsMenu', 'main'), "Props", "Appuyer sur ~p~[E] ~s~pour poser les objets"))
RMenu.Add('PropsMenu', 'objectlist', RageUI.CreateSubMenu(RMenu:Get('PropsMenu', 'main'), "Suppression d'objets", "Suppression d'objets"))

object = {}
OtherItems = {}local inventaire = false
local status = true
local playerPed = PlayerPedId()

RageUI.CreateWhile(1.0, function()
    if IsControlJustPressed(1, 311) then
        if IsPedInAnyVehicle(playerPed,  false) then
            exports['okokNotify']:Alert("ERREUR", "Accès impossible au menu props depuis un véhicule", 3000, 'error')
        else
            RageUI.Visible(RMenu:Get('PropsMenu', 'main'), not RageUI.Visible(RMenu:Get('PropsMenu', 'main')))
        end
    end

    if RageUI.Visible(RMenu:Get('PropsMenu', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()

            RageUI.Button("Civil", "Appuyer sur ~p~[E] ~s~pour poser les objets", {RightLabel = "~p~→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('PropsMenu', 'object'))

            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vcpd' then
                RageUI.Button("VCPD", "Appuyer sur ~p~[E] ~s~pour poser les objets", {RightLabel = "~p~→→→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get('PropsMenu', 'object4'))
            end

            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
                RageUI.Button("EMS", "Appuyer sur ~p~[E] ~s~pour poser les objets", {RightLabel = "~p~→→→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get('PropsMenu', 'object2'))
            end

            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
                RageUI.Button("Mécanicien", "Appuyer sur ~p~[E] ~s~pour poser les objets", {RightLabel = "~p~→→→"}, true, function(Hovered, Active, Selected)
                end, RMenu:Get('PropsMenu', 'object7'))
            end

            RageUI.Button("Gang", "Appuyer sur ~p~[E] ~s~pour poser les objets", {RightLabel = "~p~→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('PropsMenu', 'object3'))

            RageUI.Button("Armes", "Appuyer sur ~p~[E] ~s~pour poser les objets", {RightLabel = "~p~→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('PropsMenu', 'object5'))

            RageUI.Button("Drogue", "Appuyer sur ~p~[E] ~s~pour poser les objets", {RightLabel = "~p~→→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('PropsMenu', 'object6'))

            RageUI.Button("Mode suppression", "Supprimer des objets", { RightLabel = "~r~XXX" }, true, function(Hovered, Active, Selected)
            end, RMenu:Get('PropsMenu', 'objectlist'))

        end, function()
            ---Panels
        end)
    end

-- Civil
    if RageUI.Visible(RMenu:Get('PropsMenu', 'object')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()

            RageUI.Button("Banc de musculation - ~h~[1]", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_muscle_bench_01")
                end
            end)

            RageUI.Button("Banc de musculation - ~h~[2]", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_muscle_bench_02")
                end
            end)

            RageUI.Button("Banc de musculation - ~h~[3]", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_muscle_bench_03")
                end
            end)

            RageUI.Button("Banc de musculation - ~h~[4]", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_muscle_bench_04")
                end
            end)

            RageUI.Button("Banc de musculation - ~h~[5]", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_muscle_bench_05")
                end
            end)

        	RageUI.Button("Chaise", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("apa_mp_h_din_chair_12")
                end
            end)

        	RageUI.Button("Carton", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_cardbordbox_04a")
                end
            end)

            RageUI.Button("Sac", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_cs_heist_bag_02")
                end
            end)

            RageUI.Button("Table 1", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_rub_table_02")
                end
            end)

            RageUI.Button("Table 2", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_table_04")
                end
            end)

            RageUI.Button("Table 3", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_weed_table_01b")
                end
            end)

            RageUI.Button("Table de cuisine", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("v_ret_fh_kitchtable")
                end
            end)

            RageUI.Button("Petite Chaise", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_clubhouse_chair_01")
                end
            end)

            RageUI.Button("Ordinateur", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_clubhouse_laptop_01a")
                end
            end)

            RageUI.Button("Chaise Bureau", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_clubhouse_offchair_01a")
                end
            end)

            RageUI.Button("Lit Bunker", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("gr_prop_bunker_bed_01")
                end
            end)

            RageUI.Button("Lit Biker", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("gr_prop_gr_campbed_01")
                end
            end)

            RageUI.Button("Chaise Peche", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("hei_prop_hei_skid_chair")
                end
            end)

            RageUI.Button("Chaise de cuisine", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("v_res_m_dinechair")
                end
            end)

            RageUI.Button("Chaise de dehors", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("v_res_trev_framechair")
                end
            end)

            RageUI.Button("Chaise de Barbier", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("v_serv_bs_barbchair2")
                end
            end)

            RageUI.Button("Chaise bleue", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("v_ilev_chair02_ped")
                end
            end)

            RageUI.Button("Chaise de cinéma", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_direct_chair_02")
                end
            end)

            RageUI.Button("Chaise de jardin", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_chair_08")
                end
            end)

            RageUI.Button("Chaise pliante", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_old_deck_chair")
                end
            end)

        end, function()
            ---Panels
        end)
    end

-- Mecano
if RageUI.Visible(RMenu:Get('PropsMenu', 'object7')) then
    RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()

        RageUI.Button("Outils", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_cs_trolley_01")
            end
        end)
        
        RageUI.Button("Outils mecano", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_carcreeper")
            end
        end)

        RageUI.Button("Sac à outils", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_cs_heist_bag_02")
            end
        end)

    end, function()
        ---Panels
    end)
end

-- EMS
    if RageUI.Visible(RMenu:Get('PropsMenu', 'object2')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()

            RageUI.Button("Sac mortuaire", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("xm_prop_body_bag")
                end
            end)

            RageUI.Button("Trousse médical 1", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("xm_prop_smug_crate_s_medical")
                end
            end)

            RageUI.Button("Trousse médical 2", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("xm_prop_x17_bag_med_01a")
                end
            end)

        end, function()
            ---Panels
        end)
    end

-- Gang
    if RageUI.Visible(RMenu:Get('PropsMenu', 'object3')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()
            
            RageUI.Button("Canapé - ~h~[1]", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("v_tre_sofa_mess_c_s")
                end
            end)

            RageUI.Button("Canapé - ~h~[2]", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("v_res_tre_sofa_mess_a")
                end
            end)

            RageUI.Button("Canapé - ~h~[3]", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("v_res_tre_sofa_mess_b")
                end
            end)

            RageUI.Button("Canapé - ~h~[4]", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_rub_couch01")
                end
            end)

            RageUI.Button("Canapé - ~h~[5]", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_rub_couch03")
                end
            end)

            RageUI.Button("Pancarte - ~h~[1]", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_cs_protest_sign_04a")
                end
            end)

            RageUI.Button("Pancarte - ~h~[2]", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_cs_protest_sign_03")
                end
            end)

            RageUI.Button("Pancarte - ~h~[3]", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_protest_sign_01")
                end
            end)

            RageUI.Button("Panneau « Ne pas entrer »", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_sign_road_03a")
                end
            end)

            RageUI.Button("Panneau « Stop »", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_sign_road_01a")
                end
            end)
            
            RageUI.Button("Panneau « Sortie uniquement »", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_sign_road_03y")
                end
            end)

            RageUI.Button("Chaise", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_weed_chair_01a")
                end
            end)

            RageUI.Button("Chaise délabrée", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("v_corp_lazychairfd")
                end
            end)

            RageUI.Button("Table « Légalisez la weed »", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_protest_table_01")
                end
            end)
            
            RageUI.Button("Table de poker", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("vw_prop_vw_table_01a")
                end
            end)

            RageUI.Button("Sac pour arme", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_gun_case_01")
                end
            end)

            RageUI.Button("Sac de frappe", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_fragtest_cnst_06")
                end
            end)

            RageUI.Button("Cash", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("hei_prop_cash_crate_half_full")
                end
            end)

            RageUI.Button("Machine à sous", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_money_counter")
                end
            end)

            RageUI.Button("Valise de cash", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_cash_case_02")
                end
            end)

            RageUI.Button("Petite pile de cash", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_cash_crate_01")
                end
            end)

            RageUI.Button("Poubelle", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_cs_dumpster_01a")
                end
            end)

            RageUI.Button("Pile de cash", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_bkr_cashpile_04")
                end
            end)

            RageUI.Button("Pile de cash 2", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_bkr_cashpile_05")
                end
            end)
            
        end, function()
            ---Panels
        end)
    end

-- PropsMenu
    if RageUI.Visible(RMenu:Get('PropsMenu', 'object4')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()

            RageUI.Button("Cone", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_roadcone02a")
                end
            end)
            RageUI.Button("Barrière", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_barrier_work05")
                end
            end)
            
            RageUI.Button("Gros carton", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_boxpile_07d")
                end
            end)

            RageUI.Button("Herse", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("p_ld_stinger_s")
                end
            end)

        end, function()
            ---Panels
        end)
    end

-- Armes
    if RageUI.Visible(RMenu:Get('PropsMenu', 'object5')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()
            
            RageUI.Button("Malette Armes", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_biker_gcase_s")
                end
            end)

            RageUI.Button("Caisse Batteuses", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("ex_office_swag_guns04")
                end
            end)

            RageUI.Button("Caisse Armes", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("ex_prop_crate_ammo_bc")
                end
            end)

            RageUI.Button("Caisse Batteuses 2", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("ex_prop_crate_ammo_sc")
                end
            end)

            RageUI.Button("Caisse Fermé", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("ex_prop_adv_case_sm_03")
                end
            end)

            RageUI.Button("Petite Caisse", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("ex_prop_adv_case_sm_flash")
                end
            end)

            RageUI.Button("Caisse Explosif", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("ex_prop_crate_expl_bc")
                end
            end)

            RageUI.Button("Caisse Vetements", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("ex_prop_crate_expl_sc")
                end
            end)

            RageUI.Button("Caisse Chargeurs", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("gr_prop_gr_crate_mag_01a")
                end
            end)

            RageUI.Button("Grosse Caisse Armes", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("gr_prop_gr_crates_rifles_01a")
                end
            end)

            RageUI.Button("Grosse Caisse Armes 2", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("gr_prop_gr_crates_weapon_mix_01a")
                end
            end)

        end, function()
        end)
    end

    -- # Drogue

    if RageUI.Visible(RMenu:Get('PropsMenu', 'object6')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()

            RageUI.Button("Général", "Appuyer sur ~p~[E] ~s~pour poser les objets", {RightLabel = "~p~→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('PropsMenu', 'object6-0'))

            RageUI.Button("Cocaïne", "Appuyer sur ~p~[E] ~s~pour poser les objets", {RightLabel = "~p~→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('PropsMenu', 'object6-1'))

            RageUI.Button("Weed", "Appuyer sur ~p~[E] ~s~pour poser les objets", {RightLabel = "~p~→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('PropsMenu', 'object6-2'))

            RageUI.Button("Méthamphétamine", "Appuyer sur ~p~[E] ~s~pour poser les objets", {RightLabel = "~p~→→"}, true, function(Hovered, Active, Selected)
            end, RMenu:Get('PropsMenu', 'object6-3'))
            
        end, function()
        end)
    end

    if RageUI.Visible(RMenu:Get('PropsMenu', 'object6-1')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()

            RageUI.Button("Table de Cocaïne - ~h~[1]~s~", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_coke_table01a")
                end
            end)

            RageUI.Button("Table de Cocaïne - ~h~[2]~s~", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("v_ret_ml_tablea")
                end
            end)

            RageUI.Button("Table de Cocaïne - ~h~[3]~s~", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("v_ret_ml_tableb")
                end
            end)

            RageUI.Button("Table de Cocaïne - ~h~[4]~s~", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("v_ret_ml_tablec")
                end
            end)

            RageUI.Button("Blocs de Cocaïne - ~h~[1]~s~", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_coke_block_01a")
                end
            end)

            RageUI.Button("Blocs de Cocaïne - ~h~[2]~s~", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("imp_prop_impexp_boxcoke_01")
                end
            end)

            RageUI.Button("Bloc de Cocaïne - ~h~[1]~s~", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_coke_block_01")
                end
            end)

            RageUI.Button("Bloc de Cocaïne - ~h~[2]~s~", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_coke_cutblock_01")
                end
            end)

            RageUI.Button("Cocaïne en poudre - ~h~[1]~s~", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_coke_powder_01")
                end
            end)

            RageUI.Button("Cocaïne en poudre - ~h~[2]~s~", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_coke_powder_02")
                end
            end)

            RageUI.Button("Cocaïne en jouet - ~h~[1]~s~", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_coke_boxeddoll")
                end
            end)

            RageUI.Button("Cocaïne en jouet - ~h~[2]~s~", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_coke_doll")
                end
            end)

            RageUI.Button("Carton de Cocaïne en jouet", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_coke_doll_bigbox")
                end
            end)

            RageUI.Button("Cocaïne en bouteille", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_coke_bottle_01a")
                end
            end)

            RageUI.Button("Cocaïne coupée", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_coke_cut_01")
                end
            end)

            RageUI.Button("Bol de Cocaïne", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_coke_fullmetalbowl_02")
                end
            end)

            RageUI.Button("Bassine de Cocaïne", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_coke_tub_01a")
                end
            end)
            
        end, function()
        end)
    end

    if RageUI.Visible(RMenu:Get('PropsMenu', 'object6-2')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()

            RageUI.Button("Palette de fertilisant - ~h~[1]", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_fertiliser_pallet_01a")
                end
            end)

            RageUI.Button("Palette de fertilisant - ~h~[2]", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_fertiliser_pallet_01b")
                end
            end)

            RageUI.Button("Palette de fertilisant - ~h~[3]", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_fertiliser_pallet_01c")
                end
            end)

            RageUI.Button("Palette de fertilisant - ~h~[4]", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_fertiliser_pallet_01d")
                end
            end)

            RageUI.Button("Pot de fertilisant", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_weed_bucket_01d")
                end
            end)

            RageUI.Button("Pousse de Weed", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_weed_01_small_01b")
                end
            end)

            RageUI.Button("Packet de Weed", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_weed_bigbag_03a")
                end
            end)

            RageUI.Button("Petit packet de Weed ouvert", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_weed_bigbag_open_01a")
                end
            end)

            RageUI.Button("Weed pendue", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_weed_drying_01a")
                end
            end)

            RageUI.Button("Plante de Weed", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_weed_lrg_01b")
                end
            end)

            RageUI.Button("Petite plante de Weed", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_weed_med_01b")
                end
            end)

            RageUI.Button("Palette de Weed", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("hei_prop_heist_weed_pallet")
                end
            end)

            RageUI.Button("Tas de Weed", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_weed_dry_02b")
                end
            end)

            RageUI.Button("Table de weed", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_weed_table_01a")
                end
            end)
            
        end, function()
        end)
    end

    if RageUI.Visible(RMenu:Get('PropsMenu', 'object6-0')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()

            RageUI.Button("Palette", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_coke_pallet_01a")
                end
            end)

            RageUI.Button("Balance", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_coke_scale_01")
                end
            end)

            RageUI.Button("Spatule", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_coke_spatula_04")
                end
            end)

            RageUI.Button("Caisse", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_crate_set_01a")
                end
            end)
            
        end, function()
        end)
    end

    if RageUI.Visible(RMenu:Get('PropsMenu', 'object6-3')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()

            RageUI.Button("Bac de Méthamphétamine rempli - ~h~[1]", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_meth_bigbag_03a")
                end
            end)

            RageUI.Button("Bac de Méthamphétamine rempli - ~h~[2]", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_meth_bigbag_04a")
                end
            end)

            RageUI.Button("Bac de Méthamphétamine fermé", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_meth_bigbag_01a")
                end
            end)

            RageUI.Button("Bac de Méthamphétamine vide", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_meth_bigbag_02a")
                end
            end)

            RageUI.Button("Acétone", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_meth_acetone")
                end
            end)

            RageUI.Button("Propylène glycol", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_meth_ammonia")
                end
            end)

            RageUI.Button("Lithium", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_meth_lithium")
                end
            end)

            RageUI.Button("Acide phosphorique", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_meth_phosphorus")
                end
            end)

            RageUI.Button("Pseudoéphédrine", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_meth_pseudoephedrine")
                end
            end)

            RageUI.Button("Fracas de Méthamphétamine", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_meth_smashedtray_01")
                end
            end)

            RageUI.Button("Sac de Méthamphétamine ouvert", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_meth_openbag_01a")
                end
            end)

            RageUI.Button("Table de Méthamphétamine", nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_meth_table01a")
                end
            end)
            
        end, function()
        end)
    end

    if RageUI.Visible(RMenu:Get('PropsMenu', 'objectlist')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()

            for k,v in pairs(object) do
                if GoodName(GetEntityModel(NetworkGetEntityFromNetworkId(v))) == 0 then table.remove(object, k) end
                RageUI.Button("~p~["..v.."]~s~ - Objet : ~h~"..GoodName(GetEntityModel(NetworkGetEntityFromNetworkId(v))), nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                    if Active then
                        local entity = NetworkGetEntityFromNetworkId(v)
                        local ObjCoords = GetEntityCoords(entity)
                        DrawMarker(0, ObjCoords.x, ObjCoords.y, ObjCoords.z+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 84, 3, 159, 170, 1, 0, 2, 1, nil, nil, 0)
                    end
                    if Selected then
                        RemoveObj(v, k)
                    end
                end)
            end
            
        end, function()
        end)
    end

end, 1)

--

function SpawnObj(obj)
    local playerPed = PlayerPedId()
	local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
    local objectCoords = (coords + forward * 1.0)
    local Ent = nil

    SpawnObject(obj, objectCoords, function(obj)
        SetEntityCoords(obj, objectCoords, 0.0, 0.0, 0.0, 0)
        SetEntityHeading(obj, GetEntityHeading(playerPed))
        PlaceObjectOnGroundProperly(obj)
        Ent = obj
        Wait(1)
    end)
    Wait(1)
    while Ent == nil do Wait(1) end
    SetEntityHeading(Ent, GetEntityHeading(playerPed))
    PlaceObjectOnGroundProperly(Ent)
    local placed = false
    while not placed do
        Citizen.Wait(1)
        local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
        local objectCoords = (coords + forward * 3.0)
        SetEntityCoords(Ent, objectCoords, 0.0, 0.0, 0.0, 0)
        SetEntityHeading(Ent, GetEntityHeading(playerPed))
        PlaceObjectOnGroundProperly(Ent)
        SetEntityAlpha(Ent, 170, 170)

        if IsControlJustReleased(1, 38) then
            placed = true
        end
    end

    FreezeEntityPosition(Ent, true)
    SetEntityInvincible(Ent, true)
    ResetEntityAlpha(Ent)
    local NetId = NetworkGetNetworkIdFromEntity(Ent)
    table.insert(object, NetId)

end

function RemoveObj(id, k)
    Citizen.CreateThread(function()
        SetNetworkIdCanMigrate(id, true)
        local entity = NetworkGetEntityFromNetworkId(id)
        NetworkRequestControlOfEntity(entity)
        local test = 0
        while test > 100 and not NetworkHasControlOfEntity(entity) do
            NetworkRequestControlOfEntity(entity)
            Wait(1)
            test = test + 1
        end
        SetEntityAsNoLongerNeeded(entity)

        local test = 0
        while test < 100 and DoesEntityExist(entity) do 
            SetEntityAsNoLongerNeeded(entity)
            TriggerServerEvent("DeleteEntity", NetworkGetNetworkIdFromEntity(entity))
            DeleteEntity(entity)
            DeleteObject(entity)
            if not DoesEntityExist(entity) then 
                table.remove(object, k)
            end
            SetEntityCoords(entity, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0)
            Wait(1)
            test = test + 1
        end
    end)
end

function GoodName(hash)
    if hash == GetHashKey("prop_roadcone02a") then
        return "Cone"
    elseif hash == GetHashKey("prop_barrier_work05") then
        return "Barrière"
    else
        return hash
    end

end

function SpawnObject(model, coords, cb)
	local model = GetHashKey(model)

	Citizen.CreateThread(function()
		RequestModels(model)
        Wait(1)
		local obj = CreateObject(model, coords.x, coords.y, coords.z, true, false, true)

		if cb then
			cb(obj)
		end
	end)
end

function RequestModels(modelHash)
	if not HasModelLoaded(modelHash) and IsModelInCdimage(modelHash) then
		RequestModel(modelHash)

        while not HasModelLoaded(modelHash) do
			Citizen.Wait(1)
		end
	end
end

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

--

RegisterCommand('props', function()
    RageUI.Visible(RMenu:Get('PropsMenu', 'main'), true)
end, true)

Citizen.CreateThread(function()
    if IsControlPressed(0, 26) then
        print('PRESSED')
    end
end)