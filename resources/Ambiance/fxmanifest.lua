fx_version 'adamant'
games { 'gta5' };

ui_page "client/html/index.html"

files {
    "client/html/index.html",
    "client/html/*.css",
	"client/html/scripts/listener.js",
	"client/html/scripts/SoundPlayer.js",
    "client/html/scripts/functions.js",
    "client/html/diplayLogo.js",
    "client/html/toastr.min.js",
    "client/html/img/*.png",
}

server_scripts {
	"server/exports/play.lua",
	"server/exports/manipulation.lua",
}

client_scripts {
    -- Audio
    "client/client/*.lua",
}

export 'openDialog'
