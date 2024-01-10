fx_version 'adamant'
game 'gta5'

ui_page 'html/index.html'
files {
	'html/index.html',
	'html/jquery.js',
	'html/init.js',
}

shared_scripts {
    'shared/config.lua'
}

client_scripts {
    'RageUI/RMenu.lua',
    'RageUI/menu/RageUI.lua',
    'RageUI/menu/Menu.lua',
    'RageUI/menu/MenuController.lua',
    'RageUI/components/*.lua',
    'RageUI/menu/elements/*.lua',
    'RageUI/menu/items/*.lua',
    'RageUI/menu/panels/*.lua',
    'RageUI/menu/windows/*.lua',
    'client/*.lua',
    'shared/function.lua',
    'shared/props.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/*.lua',
}