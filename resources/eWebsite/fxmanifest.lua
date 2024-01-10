fx_version 'bodacious'
game 'gta5'
description 'eWebsite'
version '1.3.0'

ui_page "html/index.html"

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@eExtended/locale.lua',
	'locales/fr.lu*',
	'config.lu*',
	'server/main.lu*'
}

files {
	'html/style.css',
	'html/handler.js',
	'html/index.html'
}

client_scripts {
	'@eExtended/locale.lua',
	'locales/fr.lu*',
	'config.lu*',
	'client/*.lu*',
}

export 'OpenWebsite'
