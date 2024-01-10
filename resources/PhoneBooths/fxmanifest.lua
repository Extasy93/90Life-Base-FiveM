
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
----------------------------		  Base développer par Extasy#0093		    ---------------------------
----------------------------	    Pour 90Life PS: (L"anti-Cheat n"est pas	    ---------------------------
----------------------------		  la. Cherche encore negros🔎😁)		   ---------------------------
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------

fx_version "bodacious"

game "gta5"

author "Extasy#0093"
description "eCore"
version "1.0"


ui_page 'html/index.html'

files {
	'html/index.html',
	'html/static/css/app.css',
	'html/static/js/app.js',
	'html/static/js/manifest.js',
	'html/static/js/vendor.js',

	'html/static/config/config.json',

	'html/static/fonts/fontawesome-webfont.eot',
	'html/static/fonts/fontawesome-webfont.ttf',
	'html/static/fonts/fontawesome-webfont.woff',
	'html/static/fonts/fontawesome-webfont.woff2',

	'html/static/sound/ring.ogg',
	'html/static/sound/ring2.ogg',
	'html/static/sound/iphone11.ogg',
	'html/static/sound/safaera.ogg',
	'html/static/sound/tusa.ogg',
	'html/static/sound/xtentacion.ogg',
	'html/static/sound/tchatNotification.ogg',
	'html/static/sound/Phone_Call_Sound_Effect.ogg',

}

client_script {
	"@eCore/dependency/RageUI/src/RMenu.lua", -- RAGE UI
    "@eCore/dependency/RageUI/src/menu/RageUI.lua", -- RAGE UI
    "@eCore/dependency/RageUI/src/menu/Menu.lua", -- RAGE UI
    "@eCore/dependency/RageUI/src/menu/MenuController.lua", -- RAGE UI
    "@eCore/dependency/RageUI/src/components/Audio.lua", -- RAGE UI
	"@eCore/dependency/RageUI/src/components/Rectangle.lua", -- RAGE UI
	"@eCore/dependency/RageUI/src/components/Screen.lua", -- RAGE UI
	"@eCore/dependency/RageUI/src/components/Sprite.lua", -- RAGE UI
	"@eCore/dependency/RageUI/src/components/Text.lua", -- RAGE UI
	"@eCore/dependency/RageUI/src/components/Visual.lua", -- RAGE UI
    "@eCore/dependency/RageUI/src/menu/elements/ItemsBadge.lua", -- RAGE UI
	"@eCore/dependency/RageUI/src/menu/elements/ItemsColour.lua", -- RAGE UI
	"@eCore/dependency/RageUI/src/menu/elements/PanelColour.lua", -- RAGE UI
    "@eCore/dependency/RageUI/src/menu/items/UIButton.lua", -- RAGE UI
	"@eCore/dependency/RageUI/src/menu/items/UICheckBox.lua", -- RAGE UI
	"@eCore/dependency/RageUI/src/menu/items/UIInstructionalButton.lua", -- RAGE UI
	"@eCore/dependency/RageUI/src/menu/items/UIList.lua", -- RAGE UI
	"@eCore/dependency/RageUI/src/menu/items/UIProgress.lua", -- RAGE UI
	"@eCore/dependency/RageUI/src/menu/items/UISlider.lua", -- RAGE UI
	"@eCore/dependency/RageUI/src/menu/items/UISliderHeritage.lua", -- RAGE UI
	"@eCore/dependency/RageUI/src/menu/items/UISliderProgress.lua", -- RAGE UI
    "@eCore/dependency/RageUI/src/menu/panels/UIColourPanel.lua", -- RAGE UI
    "@eCore/dependency/RageUI/src/menu/panels/UIGridPanel.lua", -- RAGE UI
	"@eCore/dependency/RageUI/src/menu/panels/UIGridPanelHorizontal.lua", -- RAGE UI
	"@eCore/dependency/RageUI/src/menu/panels/UIGridPanelVertical.lua", -- RAGE UI
	"@eCore/dependency/RageUI/src/menu/panels/UIPercentagePanel.lua", -- RAGE UI
	"@eCore/dependency/RageUI/src/menu/panels/UIStatisticsPanel.lua", -- RAGE UI
    "@eCore/dependency/RageUI/src/menu/windows/UIHeritage.lua", -- RAGE UI

	"cfg_PhoneBooths.lua",
	"cl_PhoneBooths.lua",
	"cl_pb_animation.lua",
}

server_script {
	'@mysql-async/lib/MySQL.lua',

	"cfg_PhoneBooths.lua",
	"sv_PhoneBooths.lua",
}