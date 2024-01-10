local img = "https://media.discordapp.net/attachments/717811885864517713/720626444740591746/271590_20200610135036_1.png?width=812&height=457"

local webhooks = {
    ["connexion"] = {w = "https://discord.com/api/webhooks/918221308288983100/JUb4DENYh88AhXQ2WaTRSTFg52SiMKBU5WfA2U3Ph0Wno6xmUrQPO-vlm0RUM47PW1PG"}, --
    ["connexion-extra"] = {w = "https://discord.com/api/webhooks/918221308288983100/JUb4DENYh88AhXQ2WaTRSTFg52SiMKBU5WfA2U3Ph0Wno6xmUrQPO-vlm0RUM47PW1PG"},--
    ["give-staff"] = {w = "https://discord.com/api/webhooks/901122310533156874/QMQlZ293e3fXk_tHZusuJw9DGj0n_CebcTheOeZaMOKAjYcdpKNV5K8qJ9WAcigP8kgh"},
    ["concess"] = {w = "https://discord.com/api/webhooks/981826393862189096/rnYUyE5P1WFCyNhn9MUPRKcam3bCsUgqQpyOiuNV04RZbHYC4ZH3R_rkLX7nfUZMd-wx"},
    ["veh-vente"] = {w = "https://discord.com/api/webhooks/981826393862189096/rnYUyE5P1WFCyNhn9MUPRKcam3bCsUgqQpyOiuNV04RZbHYC4ZH3R_rkLX7nfUZMd-wx"},
    --["identity"] = {w = ""},
    ["items"] = {w = "https://discord.com/api/webhooks/962681985355100170/Bi_5UYw5Hq88v2T4WB7uD6QMYsRZhAvobcnXHZohgTmTavSPdr_nV_lOAvWgiypiSmWU"},
    ["money"] = {w = "https://discord.com/api/webhooks/962681985355100170/Bi_5UYw5Hq88v2T4WB7uD6QMYsRZhAvobcnXHZohgTmTavSPdr_nV_lOAvWgiypiSmWU"},
    ["society"] = {w = "https://discord.com/api/webhooks/962682911969124383/KT_DKZwOKQ_CCppAAgJ8-o2BUNVlxY3Wpmfbt5sug_fN9jCU9f0Qh8h3_rXd7mIoG0iH"},
    ["society-money"] = {w = "https://discord.com/api/webhooks/962682911969124383/KT_DKZwOKQ_CCppAAgJ8-o2BUNVlxY3Wpmfbt5sug_fN9jCU9f0Qh8h3_rXd7mIoG0iH"},
    ["veh"] = {w = "https://discord.com/api/webhooks/981827827320111104/pwQlKB5NzdITO8KrHn4dl9UYZrSdBNTdwLZXMbaYYnmfCrJwE9VGj-JDMOS0fgTkLgm5"},
    ["gross-transaction"] = {w = "https://discord.com/api/webhooks/962681985355100170/Bi_5UYw5Hq88v2T4WB7uD6QMYsRZhAvobcnXHZohgTmTavSPdr_nV_lOAvWgiypiSmWU"},
    ["transaction-louche"] = {w = "https://discord.com/api/webhooks/962681985355100170/Bi_5UYw5Hq88v2T4WB7uD6QMYsRZhAvobcnXHZohgTmTavSPdr_nV_lOAvWgiypiSmWU"},
    ["kill"] = {w = "https://discord.com/api/webhooks/981828428766543912/nxhe-lYPz-sSm4HM1soPF81pq2JSV2AZtdb6Ig-fa7DHs9PyH55-gwVc6O3TEFALK7SX"},
    ["superette"] = {w = "https://discord.com/api/webhooks/981828580457717790/W2Dh45anSua6jwWmVh3td4At0O1dqFN1RofSydupfAAGHQU1FlbGdEDh8E5dFNYCYN5q"},
    ["facture"] = {w = "https://discord.com/api/webhooks/981828676729585664/tMEc1w976b3F8mauKdSDSNjh3LGAK-s3bK3g_CG0HGD2qyi5RbWY9p1WjQdk3ZZmad6P"},
    ["me"] = {w = "https://discord.com/api/webhooks/981828919445569576/to1loMDtav3N-p8LP0D9m801o-rCPlXCTzfkd0BuHFz56Op3RYugspbnggCU9dSIBmE1"},
    ["wheel"] = {w = "https://discord.com/api/webhooks/955092459766038558/5dxpJlGub45ONAkzha4pcjENPCXfCwBBj5x_TyjKBljcOQgBO60gy9Vc6CI3wANKhIxl"},
    ["bank"] = {w = "https://discord.com/api/webhooks/966691752767545415/km7K9cWlOh1kbZYsn-ELUyWNBLc07itjXWrj3nOxcHgy4M9l7U3I1V1G7Tzoz43rWh_k"},
    ["ac"] = {w = "https://discord.com/api/webhooks/966691752767545415/km7K9cWlOh1kbZYsn-ELUyWNBLc07itjXWrj3nOxcHgy4M9l7U3I1V1G7Tzoz43rWh_k"},
    ["annonce"] = {w = "https://discord.com/api/webhooks/983029769983623249/SDrSHdRDJQoBUza29yNYQ83Hans491YF0Wg_8YZh6AY-i5T4nV8e6KebNoZD1jY8eLOp"},
    ["admin"] = {w = "https://discord.com/api/webhooks/901122310533156874/QMQlZ293e3fXk_tHZusuJw9DGj0n_CebcTheOeZaMOKAjYcdpKNV5K8qJ9WAcigP8kgh"},
    ["report"] = {w = "https://discord.com/api/webhooks/962682783111741450/R81wVo3XmME-sMCF5WlvCPx6zDFUiuUhDat0Vdk0Ln25WeR7wJs9sp38F4fEDgjtfMFe"},
    ["org"] = {w = "https://discord.com/api/webhooks/962683093959991378/XrHCcAjEMTEHpeOZl-tYapq8gl6qJV97uC4Qf-L-ZAb0z-hJGDbRj3fRUnYSBha1TDlI"},
    ["spray"] = {w = "https://discord.com/api/webhooks/983069525790584863/PzE-BCXskwJt7hlpcOGItXJvO_n3UaZ9vXRH7-hOqR8_sOmk9PkqAvD5reIAC0rK3ova"},
}

SendLog = function(msg, type)
    local webhook = webhooks[type].w

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = type, content = msg, avatar_url = img, tts = false}), {['Content-Type'] = 'application/json'})
end

local DeathType = {
    [1] = {name = "mêlée"},
    [2] = {name = "tiré sur"},
    [3] = {name = "tranché"},
    [4] = {name = "renversé"},
    [5] = {name = "tué par un animal"},
    [6] = {name = "tué par dégats de chute"},
    [7] = {name = "tué par une explosion"},
    [8] = {name = "tué avec du fuel"},
    [9] = {name = "brulé"},
    [10] = {name = "noyé"},
    [11] = {name = "Inconnu"},
}

RegisterNetEvent("Extasy:LogPlayerDeath") 
AddEventHandler("Extasy:LogPlayerDeath", function(type, killerName, killerId)
    if type == 1 or type == 2 or type == 3 or type == 4 then
        SendLog("**["..killerId.."]** "..killerName.." "..DeathType[type].name.." **["..source.."]** "..GetPlayerName(source), "kill")
    else
        SendLog("**["..source.."]** "..GetPlayerName(source) .. " "..DeathType[type].name, "kill")
    end
end)