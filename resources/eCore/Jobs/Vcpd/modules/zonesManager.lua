Zones = {
    drawDistance = 10.0,

    Markers = {
        ["home"] = {
            isRestricted = false,
            interactionDistance = 0.45,
            color = {r = 100, g = 0, b = 200},
            scale = 1.5,
            location = vector3(441.45, -983.87, 30.69),
            action = function()
                if not RageUI.Visible(RMenu:Get('Extasy_lspd_plainte','lspd_plainte')) then
                    AddTextEntry("ACTION", "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le ~p~menu de l'accueil.")
                    DisplayHelpTextThisFrame("ACTION", false)
                end
                if IsControlJustPressed(0, 51) then
                    RageUI.Visible(RMenu:Get('Extasy_lspd_plainte', 'lspd_plainte'), not RageUI.Visible(RMenu:Get('Extasy_lspd_plainte', 'lspd_plainte')))
                end
            end,
        },
    },
}
