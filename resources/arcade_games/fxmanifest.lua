fx_version 'adamant'
games { 'gta5' }

client_scripts {
	"cl_arcade_games.lua",
}

files {
	"html/css/style.css",
	"html/css/reset.css",
	
	"html/css/img/monitor.png",
	"html/css/img/table.png",
	
	"html/*.html",
	
	"html/scripts/listener.js",
}

ui_page "html/index.html"

exports {
    'Pacman',
    'Tetris',
    'PingPong',
    'DOOM',
    'DukeNukem3D',
    'Wolfenstein3D'
}