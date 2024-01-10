fx_version 'adamant'
games {'gta5'}

client_scripts {
  "cfg_inventory.lua",
  "utils.lua",
  "cl_menu.lua",
  "inventaire/client/*.lua",
  "weaponitem/cl_weapons.lua",
}

server_scripts {
  "@mysql-async/lib/MySQL.lua",
  "cfg_inventory.lua",
  "inventaire/server/*.lua",
  "weaponitem/sv_weapons.lua",
}

ui_page 'html/ui.html'

files {
  'html/*.html',
  'html/js/*.js',
  'html/css/*.css',
  'html/locales/*.js',
  'html/img/hud/*.png',
  'html/img/*.png',
  'html/img/items/*.png',
}

exports {
  "HotBarUse",
  "OpenInventory",
}