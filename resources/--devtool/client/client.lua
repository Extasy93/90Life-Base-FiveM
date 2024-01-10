ESX = nil

local open = false
local RColor, GColor, BColor, Opacity = 60, 66, 207, 155
local RectRcolor, RectGcolor, RectBcolor, RectOpacity = 0, 0, 0, 160
local RotateX, RotateY, RotateZ = 0.0, 0.0, 0.0
CamFov = 45.0

CreateThread(function()
    while ESX == nil do
        TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
        Wait(1)
    end
end)

DevToolMenu = RageUI.CreateMenu("Dev Tool", "Outils de développement")
CoordsMenu = RageUI.CreateSubMenu(DevToolMenu, "Dev Tool", "Coordonées")
DrawMarkerMenu = RageUI.CreateSubMenu(DevToolMenu, "Dev Tool", "Draw Marker")
DrawRectMenu = RageUI.CreateSubMenu(DevToolMenu, "Dev Tool", "Draw Rect")
PropsMenu = RageUI.CreateSubMenu(DevToolMenu, "Dev Tool", "Props")
PropsListMenu = RageUI.CreateSubMenu(PropsMenu, "Dev Tool", "Props")
DrawRectMenu.EnableMouse = true

DevToolMenu.Closed = function()  
    RageUI.Visible(DevToolMenu, false) 
    open = false
end 

PropsListMenu.Closed = function()  
    ReturnOldPosition()
end 

function OpenDevToolMenu()
    if open then 
        open = false 
        RageUI.Visible(DevToolMenu,false)
    else
        open = true 
        RageUI.Visible(DevToolMenu, true)

        Citizen.CreateThread(function ()
            while open do 
                RageUI.IsVisible(DevToolMenu, function()
                    RageUI.Button("Coordonées", false , {RightLabel = "→"}, true , {}, CoordsMenu)
                    RageUI.Button("Draw Marker", false , {RightLabel = "→"}, true , {}, DrawMarkerMenu)
                    RageUI.Button("Draw Rect", false , {RightLabel = "→"}, true , {}, DrawRectMenu)
                    RageUI.Button("Props", false , {RightLabel = "→"}, true , {}, PropsMenu)
                    RageUI.Button("TP Marker", false , {RightLabel = "→"}, true , {
                        onSelected = function()
                            TeleportBlips()
                        end
                    })
                end)
                RageUI.IsVisible(CoordsMenu, function()
                    RageUI.List("Coordonnées", Config.CoordsList, Config.CoordsList.Index , nil, {}, true, {
                        onListChange = function(Index)
                            Config.CoordsList.Index = Index
                        end,
                        onSelected = function(Index)
                            if Index == 1 then
                                SendNUIMessage({
                                    tool = ""..GetEntityCoords(PlayerPedId())
                                })
                            elseif Index == 2 then
                                SendNUIMessage({
                                    tool = ""..GetEntityCoords(PlayerPedId()).x..", "..GetEntityCoords(PlayerPedId()).y..", "..GetEntityCoords(PlayerPedId()).z
                                })
                            elseif Index == 3 then
                                SendNUIMessage({
                                    tool = "{x = "..GetEntityCoords(PlayerPedId()).x..", y = "..GetEntityCoords(PlayerPedId()).y..", z = "..GetEntityCoords(PlayerPedId()).z.."}"
                                })
                            end
                        end
                    })
                    RageUI.Button("Heading", false , {RightLabel = "→"}, true , {
                        onSelected = function()
                            SendNUIMessage({
                                tool = GetEntityHeading(PlayerPedId())
                            })
                        end
                    })
                end)
                RageUI.IsVisible(DrawMarkerMenu, function()
                    local Pcoord = GetEntityCoords(PlayerPedId())
                    DrawMarker(Config.TypeMarker.Index, Pcoord.x, Pcoord.y+1.0, Pcoord.z - 1.0 + Config.HeightMarker.Index /10.0, 0.0, 0.0, 0.0, RotateX, RotateY, RotateZ, 1.0, 1.0, 1.0, RColor, GColor, BColor, Opacity)
                    RageUI.List("Type de Marker", Config.TypeMarker, Config.TypeMarker.Index , nil, {}, true, {
                        onListChange = function(Index)
                            Config.TypeMarker.Index = Index
                        end
                    })
                    RageUI.List("Hauteur du Marker", Config.HeightMarker, Config.HeightMarker.Index , nil, {}, true, {
                        onListChange = function(Index)
                            Config.HeightMarker.Index = Index
                        end
                    })
                    RageUI.List("Rotation du Marker [X]", Config.RotateMarker, Config.RotateMarker.IndexX , nil, {}, true, {
                        onListChange = function(Index)
                            Config.RotateMarker.IndexX = Index
                            if Index > 1 then
                                RotateX = Config.RotateMarker.IndexX * 45.0
                            end
                        end
                    })
                    RageUI.List("Rotation du Marker [Y]", Config.RotateMarker, Config.RotateMarker.IndexY , nil, {}, true, {
                        onListChange = function(Index)
                            Config.RotateMarker.IndexY = Index
                            if Index > 1 then
                                RotateY = Config.RotateMarker.IndexY * 45.0
                            end
                        end
                    })
                    RageUI.List("Rotation du Marker [Z]", Config.RotateMarker, Config.RotateMarker.IndexZ , nil, {}, true, {
                        onListChange = function(Index)
                            Config.RotateMarker.IndexZ = Index
                            if Index > 1 then
                                RotateZ = Config.RotateMarker.IndexZ * 45.0
                            end
                        end
                    })
                    RageUI.List("Couleur du Marker", Config.ListColor, Config.ListColor.IndexMarker , nil, {}, true, {
                        onListChange = function(Index)
                            Config.ListColor.IndexMarker = Index
                        end, 
                        onSelected = function(Index)
                            if Index == 1 then
                                local RedColor = KeyboardInput("Color", "Rouge / 255", "", 3)
                                if RedColor ~= nil then
                                    RedColor = tonumber(RedColor)
                                    if type(RedColor) == 'number' then
                                        RColor = RedColor
                                    end
                                end
                            elseif Index == 2 then
                                local GreenColor = KeyboardInput("Color", "Vert / 255", "", 3)
                                if GreenColor ~= nil then
                                    GreenColor = tonumber(GreenColor)
                                    if type(GreenColor) == 'number' then
                                        GColor = GreenColor
                                    end
                                end
                            elseif Index == 3 then
                                local BlueColor = KeyboardInput("Color", "Bleu / 255", "", 3)
                                if BlueColor ~= nil then
                                    BlueColor = tonumber(BlueColor)
                                    if type(BlueColor) == 'number' then
                                        BColor = BlueColor
                                    end
                                end
                            elseif Index == 4 then
                                local Alpha = KeyboardInput("Color", "Opacité / 255", "", 3)
                                if Alpha ~= nil then
                                    Alpha = tonumber(Alpha)
                                    if type(Alpha) == 'number' then
                                        Opacity = Alpha
                                    end
                                end
                            end
                        end
                    })
                    RageUI.Separator("Couleur du Marker: R: ~r~"..RColor.." ~s~G: ~g~"..GColor.." ~s~B: ~b~"..BColor)
                    RageUI.Button('Copier Marker', false, { RightLabel = "→", Color = {HightLightColor = {235, 18, 15, 150}, BackgroundColor = {38, 85, 150, 160 }}}, true, {
                        onSelected = function()
                            SendNUIMessage({
                                tool = "DrawMarker("..Config.TypeMarker.Index..", "..Pcoord.x..", "..(Pcoord.y + 1.0 *0.01)..", "..(Pcoord.z - 1.0 + Config.HeightMarker.Index /10.0)..", 0.0, 0.0, 0.0, "..RotateX..", "..RotateY..", "..RotateZ..", 1.0, 1.0, 1.0, "..RColor..", "..GColor..", "..BColor..", "..Opacity..")"
                            })
                        end
                    })
                end)

                RageUI.IsVisible(DrawRectMenu, function()
                    DrawRect(Config.DrawRectPostion.X, Config.DrawRectPostion.Y, Config.DrawRectWidth, Config.DrawRectHeight, RectRcolor, RectGcolor, RectBcolor, RectOpacity)
                    RageUI.Button("Changer position", false, {RightLabel = "→"}, true, {})
                    RageUI.Grid(Config.DrawRectPostion.X, Config.DrawRectPostion.Y, 'Haut', 'Bas', 'Gauche', 'Droite', {
                        onPositionChange = function(IndexX, IndexY, X, Y)
                            Config.DrawRectPostion.X = IndexX
                            Config.DrawRectPostion.Y = IndexY
                            DrawRectPostionX = IndexX
                            DrawRectPostionY = IndexY 
                        end
                    }, 1)
                    RageUI.Button("Changer largeur", false, {RightLabel = "→"}, true, {})
                    RageUI.GridHorizontal(Config.DrawRectWidth, 'Moins large', 'Plus large', {
                        onPositionChange = function(IndexX, IndexY, X, Y)
                            Config.DrawRectWidth = IndexX
                        end
                    }, 2)
                    RageUI.Button("Changer hauteur", false, {RightLabel = "→"}, true, {})
                    RageUI.GridVertical(Config.DrawRectHeight, 'Plus grand', 'Moins grand', {
                        onPositionChange = function(IndexX, IndexY, X, Y)
                            Config.DrawRectHeight = IndexY
                        end
                    }, 3)
                    RageUI.Separator("Couleur du Draw Rect: R: ~r~"..RectRcolor.." ~s~G: ~g~"..RectGcolor.." ~s~B: ~b~"..RectBcolor)
                    RageUI.List("Couleur du DrawRect", Config.ListColor, Config.ListColor.IndexRect , nil, {}, true, {
                        onListChange = function(Index)
                            Config.ListColor.IndexRect = Index
                        end, 
                        onSelected = function(Index)
                            if Index == 1 then
                                local RedColor = KeyboardInput("Color", "Rouge / 255", "", 3)
                                if RedColor ~= nil then
                                    RedColor = tonumber(RedColor)
                                    if type(RedColor) == 'number' then
                                        RectRcolor = RedColor
                                    end
                                end
                            elseif Index == 2 then
                                local GreenColor = KeyboardInput("Color", "Vert / 255", "", 3)
                                if GreenColor ~= nil then
                                    GreenColor = tonumber(GreenColor)
                                    if type(GreenColor) == 'number' then
                                        RectGcolor = GreenColor
                                    end
                                end
                            elseif Index == 3 then
                                local BlueColor = KeyboardInput("Color", "Bleu / 255", "", 3)
                                if BlueColor ~= nil then
                                    BlueColor = tonumber(BlueColor)
                                    if type(BlueColor) == 'number' then
                                        RectBcolor = BlueColor
                                    end
                                end
                            elseif Index == 4 then
                                local Alpha = KeyboardInput("Color", "Opacité / 255", "", 3)
                                if Alpha ~= nil then
                                    Alpha = tonumber(Alpha)
                                    if type(Alpha) == 'number' then
                                        RectOpacity = Alpha
                                    end
                                end
                            end
                        end
                    })
                    RageUI.Button('Copier Draw Rect', false, { RightLabel = "→", Color = {HightLightColor = {235, 18, 15, 150}, BackgroundColor = {38, 85, 150, 160 }}}, true, {
                        onSelected = function()
                            SendNUIMessage({
                                tool = "DrawRect("..Config.DrawRectPostion.X..", "..Config.DrawRectPostion.Y..", "..Config.DrawRectWidth..", "..Config.DrawRectHeight..", "..RectRcolor..", "..RectGcolor..", "..RectBcolor..","..RectOpacity..")"
                            })
                        end
                    })
                end)
                RageUI.IsVisible(PropsMenu, function()
                    RageUI.Button("Get closest props", "Retourne le ~y~hash~s~ du props se trouvant le plus proche de vous" , {RightLabel = "→"}, true , {
                        onSelected = function() 
                            SendNUIMessage({
                                tool = ""..GetEntityModel(ESX.Game.GetClosestObject())
                            })
                        end
                    })
                    RageUI.Button("Liste des props", false , {RightLabel = "→"}, true , {
                        onSelected = function()
                            TeleportIPLProps()
                        end
                    }, PropsListMenu)
                end)
                RageUI.IsVisible(PropsListMenu, function()
                    if IsControlJustReleased(0,  96) then
                        if CamFov > 0 then
                            CamFov = CamFov - 5.0
                            SetCamFov(camera, CamFov)
                        end
                    elseif IsControlJustReleased(0,  97) then
                        if CamFov < 130.0 then
                            CamFov = CamFov + 5.0
                            SetCamFov(camera, CamFov)
                        end
                    end
                    Visual.Subtitle("Appuyez sur [~b~+~s~] / [~b~-~s~] pour Zoom / Dézoom", 1000)
                    for k,v in pairs(ListOfProps) do
                        RageUI.Button(v.name, false , {RightLabel = "→"}, true , {
                            onSelected = function()
                                SendNUIMessage({
                                    tool = ""..v.name
                                })
                            end
                        })
                        PropsListMenu.onIndexChange = function(Index)
                            RequestModel(ListOfProps[Index].name)
                            while not HasModelLoaded(ListOfProps[Index].name) do
                                Wait(500)				
                            end
                            Wait(150)
                            DeleteEntity(SpawnProps)
                            SpawnProps = CreateObjectNoOffset(ListOfProps[Index].name, -1266.972, -3013.221, -48.49021, 1, 0, 1)
                            PlaceObjectOnGroundProperly(SpawnProps)
                            FreezeEntityPosition(SpawnProps, true)
                            SetModelAsNoLongerNeeded(SpawnProps)
                        end
                    end
                end)
                Wait(0)
            end
        end)
    end
end 


Keys.Register('F11','F11', 'Dev Tool ~p~[ADMIN]~s~', function()
    TriggerServerEvent("cxDevTool:GetGroups")
end)

RegisterNetEvent("cxDevTool:OpenDevToolMenu")
AddEventHandler("cxDevTool:OpenDevToolMenu", function(license)
    OpenDevToolMenu()
end)
