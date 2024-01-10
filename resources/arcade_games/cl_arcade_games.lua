
Pacman = function()
    SendNUIMessage({
        type = "on",
        game = "http://xogos.robinko.eu/PACMAN/",
        gpu  = "ETX1050",
        cpu  = "U7_8700"
    })
    SetNuiFocus(true, true)
end

Tetris = function()
    SendNUIMessage({
        type = "on",
        game = "http://xogos.robinko.eu/TETRIS/",
        gpu  = "ETX1050",
        cpu  = "U7_8700"
    })
    SetNuiFocus(true, true)
end

PingPong = function()
    SendNUIMessage({
        type = "on",
        game = "http://xogos.robinko.eu/PONG/",
        gpu  = "ETX1050",
        cpu  = "U7_8700"
    })
    SetNuiFocus(true, true)
end

DOOM = function()
    SendNUIMessage({
        type = "on",
        game = string.format("nui://rcore_arcade/html/msdos.html?url=%s&params=%s", "https://www.retrogames.cz/dos/zip/Doom.zip", "./DOOM.EXE"),
        gpu  = "ETX1050",
        cpu  = "U7_8700"
    })
    SetNuiFocus(true, true)
end

DukeNukem3D = function()
    SendNUIMessage({
        type = "on",
        game = string.format("nui://rcore_arcade/html/msdos.html?url=%s&params=%s", "https://www.retrogames.cz/dos/zip/duke3d.zip", "./DUKE3D.EXE"),
        gpu  = "ETX1050",
        cpu  = "U7_8700"
    })
    SetNuiFocus(true, true)
end

Wolfenstein3D = function()
    SendNUIMessage({
        type = "on",
        game = string.format("nui://rcore_arcade/html/msdos.html?url=%s&params=%s", "https://www.retrogames.cz/dos/zip/Wolfenstein3D.zip", "./WOLF3D.EXE"),
        gpu  = "ETX1050",
        cpu  = "U7_8700"
    })
    SetNuiFocus(true, true)
end

RegisterNUICallback('exit', function()
    SendNUIMessage({
        type = "off",
        game = "",
    })
    SetNuiFocus(false, false)
end)

CloseNUI = function()
    SendNUIMessage({
        type = "off",
        game = "",
    })
    SetNuiFocus(false, false)
end