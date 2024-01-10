fx_version 'adamant'

game 'gta5'

ui_page 'web/ui.html'

files {
	'web/*.*',
}

shared_script 'cfg_chat.lua'

client_scripts {
	'client.lua',
}

export "IsChatOpenned"