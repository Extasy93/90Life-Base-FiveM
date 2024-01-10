carte_identite = 0

Citizen.CreateThread(function()
    carte_identite = GetResourceKvpInt("IdentiteCard")
    if carte_identite == nil then
        carte_identite = 0
    end
end)

local succesIdentiteCard = {
    [1] = {
        texte = "Citoyen model !"
    },
}

CheckSuccesIdentiteCard = function()
    carte_identite = carte_identite + 1
    if succesIdentiteCard[carte_identite] ~= nil then
        --PlayUrl("SUCCES", "https://www.youtube.com/watch?v=VpwqsYA44JI", 0.4, false)
        TriggerEvent("Ambiance:PlayUrl", token, "SUCCES", "https://www.youtube.com/watch?v=VulNgFlC1u4", 0.4, false )
        Wait(1000)
        SendNUIMessage({ 
            succes = true
        })
        Extasy.NotifSucces("~y~SUCCES!\n~w~"..succesIdentiteCard[carte_identite].texte)
        if succesIdentiteCard[carte_identite].suplementaire ~= nil then
            Extasy.NotifSucces("~y~SUCCES!\n~w~"..succesIdentiteCard[carte_identite].suplementaire)
        end
    end
    SetResourceKvpInt("IdentiteCard", carte_identite)
end

RegisterNetEvent("CheckSuccesIdentiteCard")
AddEventHandler("CheckSuccesIdentiteCard", function()
    CheckSuccesIdentiteCard()
end)