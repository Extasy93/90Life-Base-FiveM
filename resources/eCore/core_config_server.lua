extasy_sv_core_cfg = {}
extasy_sv_core_cfg.loaded = false

extasy_sv_core_cfg["display_debug"]                     = false

-- # Maintenance mode

extasy_sv_core_cfg["maintenance_mode"]                  = false

-- # Configuration Weabook Global

extasy_sv_core_cfg["webhook_ban"]                       = "https://discord.com/api/webhooks/921811284427681832/8LMHeeXBG_LSG8qFUtESGY7pD2g5gjrfLXJYnJNDDKVkgS_lTo8ir6YasxeiOnAzPB1d"
extasy_sv_core_cfg["webhook_unban"]                     = "https://discord.com/api/webhooks/921811284427681832/8LMHeeXBG_LSG8qFUtESGY7pD2g5gjrfLXJYnJNDDKVkgS_lTo8ir6YasxeiOnAzPB1d"
extasy_sv_core_cfg["webhook_fake_plate"]                = "https://discord.com/api/webhooks/938129771383128074/bKDpchnSrXJkKam56apgfKYAPxyPtjXYE3pwEtGSMcIwdTIuI6jgyuJ4ATVqi64vDa6B"
extasy_sv_core_cfg["webhook_admin_menu_give_weapon"]    = "https://discord.com/api/webhooks/901122310533156874/QMQlZ293e3fXk_tHZusuJw9DGj0n_CebcTheOeZaMOKAjYcdpKNV5K8qJ9WAcigP8kgh"
extasy_sv_core_cfg["webhook_admin_menu_report"]         = "https://discord.com/api/webhooks/962682783111741450/R81wVo3XmME-sMCF5WlvCPx6zDFUiuUhDat0Vdk0Ln25WeR7wJs9sp38F4fEDgjtfMFe"
extasy_sv_core_cfg["webhook_entreprise"]                = "https://discord.com/api/webhooks/962682911969124383/KT_DKZwOKQ_CCppAAgJ8-o2BUNVlxY3Wpmfbt5sug_fN9jCU9f0Qh8h3_rXd7mIoG0iH"
extasy_sv_core_cfg["webhook_pôle_emplois_abateur"]      = ""
extasy_sv_core_cfg["webhook_org"]                       = "https://discord.com/api/webhooks/962683093959991378/XrHCcAjEMTEHpeOZl-tYapq8gl6qJV97uC4Qf-L-ZAb0z-hJGDbRj3fRUnYSBha1TDlI"
extasy_sv_core_cfg["webhook_vape_simple"]               = ""
extasy_sv_core_cfg["webhook_vape_detail"]               = "https://discord.com/api/webhooks/923270272017117235/WOOkeXMb6M-JQAasPzjBfdVWXrtkcN4OeIWRoGWEcuoomOAerqYtLdBhQA_GqWdUazj2"
extasy_sv_core_cfg["webhook_lottery"]                   = "https://discord.com/api/webhooks/963428955002654781/SnyZzkEuu-iPEj-5M2LRbhC6uHitGZJa_MINJpNVwSXvu4zZ_gchGkHkuNqQDbwjPmen"

-- # Configuration Fishing

extasy_sv_core_cfg["resell_fish"]                       = 10
extasy_sv_core_cfg["resell_turtle"]                     = 75
extasy_sv_core_cfg["resell_shark"]                      = 250

-- # Configuration Jobs

extasy_sv_core_cfg["webhook_weazel_news_1"]             = "https://discord.com/api/webhooks/964946068213207144/gfWQaNVBvv3e17YpPVYPPMM17_5Lacw06oozsmv4_g11QMryM1eKef4NXUtK2BKxdWJl"
extasy_sv_core_cfg["webhook_weazel_news_2"]             = "https://discord.com/api/webhooks/964946101608251432/OKdonl_q3iOZGv0psjiCE-6_ywPTZaZl8bGu6oFfD_-9Jg7KUtmI-fp9jnl16EKBI7tB"

RegisterNetEvent("extasy_sv_core_cfg_loaded")
AddEventHandler("extasy_sv_core_cfg_loaded", function(token)
    if not CheckToken(token, source, "extasy_sv_core_cfg_loaded") then return end
    extasy_sv_core_cfg.loaded = true
end)