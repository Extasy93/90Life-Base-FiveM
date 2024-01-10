fx_version 'bodacious'
game 'gta5'

client_scripts {
	'@eExtended/locale.lua'
}

server_scripts {
	'@eExtended/locale.lua'
}

-- ViceCity --

replace_level_meta 'update_data' -- Vice Old

files { -- Vice Old
    'update_data.meta',
    'images.meta',
	'water.xml',
	'popcycle.dat',
	'popzone.ipl',
	'popgroups.ymt',
	'zonebind.meta',
	'interiorproxies.meta',
}

data_file 'POPSCHED_FILE' 'popcycle.dat' -- Vice Old
data_file 'ZONEBIND_FILE' 'zonebind.meta' -- Vice Old
data_file 'FIVEM_LOVES_YOU_341B23A2F0E0F131' 'popgroups.ymt' -- Vice Old
data_file 'INTERIOR_PROXY_ORDER_FILE' 'interiorproxies.meta'


client_scripts {
	'vice_zone_names.lua',
  	'mapzoom.lua'
}

files {
  "minimap/int3232302352.gfx",
  "colorcayo/int3232302352.gfx",
  "vicecity/gtxd.meta",
}

data_file "SCALEFORM_DLC_FILE" "int3232302352.gfx"
data_file "SCALEFORM_DLC_FILE" "colorcayo/int3232302352.gfx"
data_file 'GTXD_PARENTING_DATA' 'vicecity/gtxd.meta'

-- Voiture Stream Import --

files {
	'data/vehicles.meta',
	'data/carcols.meta',
	'data/carvariations.meta',
	'data/handling.meta'
}

files {
	'stream/**/**/vehicles.meta',
	'stream/**/**/carvariations.meta',
	'stream/**/**/carcols.meta',
	'stream/**/**/handling.meta',
	'stream/**/**/vehiclelayouts.meta',
}
  
  data_file('CONTENT_UNLOCKING_META_FILE')('stream/**/**/data/contentunlocks.meta')
  data_file('HANDLING_FILE')('stream/**/**/data/handling.meta')
  data_file('VEHICLE_METADATA_FILE')('stream/**/**/data/vehicles.meta')
  data_file('CARCOLS_FILE')('stream/**/**/data/carcols.meta')
  data_file('VEHICLE_VARIATION_FILE')('stream/**/**/data/carvariations.meta')
  data_file('VEHICLE_LAYOUTS_FILE')('stream/**/**/data/vehiclelayouts.meta')

-- BarThings

files {
    'bar_thing/html/index.html',
    'bar_thing/html/style.css',
    'bar_thing/html/main.js',
}

client_scripts {
    'bar_thing/client.lua'
}

ui_page 'bar_thing/html/index.html'

export "drawBar"

-- CAYO PERICO
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_terrain_metadata_004.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_terrain_metadata_001.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_terrain_metadata_003_strm.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_terrain_metadata_002.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_terrain_metadata_005.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_terrain_lod.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_terrain_metadata_001_strm.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_terrain_metadata_003.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_terrain_metadata_006.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_terrain_metadata_002_strm.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_int_mp_h_props.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_int_mp_doors.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mp_apa_yacht_jacuzzi.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mp_apa_yacht.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_props_h4_mines.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_props_sub_int_h4.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_prop_h4_accs_01.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_prop_h4_accs_02.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_prop_h4_casino.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_prop_h4_coke_01.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_prop_h4_des_gate.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_prop_h4_des_gate_end.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_prop_h4_dj.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_prop_h4_ground_cover.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_prop_h4_hatches_01.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_prop_h4_island_01.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_prop_h4_island_02.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_prop_h4_island_03.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_prop_h4_lights.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_prop_h4_lights_02.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_prop_h4_lights_03.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_prop_h4_lights_04.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_prop_h4_lights_05.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_prop_h4_lights_content.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_prop_h4_money_01.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_prop_h4_office_01.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_prop_h4_potted.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_prop_h4_rock.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_prop_h4_sam.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_prop_h4_sub.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_prop_h4_tables.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_prop_h4_trees.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_prop_h4_weed_01.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_yacht_metadata_001_strm.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_yacht_metadata_001.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_island_combine_metadata_002.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_island_combine_metadata_009.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_airstrip_interior_0_airstrip_hanger.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_island_combine_metadata_003_strm.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_island_combine_metadata_007.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_island_combine_metadata_001_strm.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_island_combine_metadata_005_strm.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_island_combine_metadata_003.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_island_combine_metadata_010.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_island_combine_metadata_002_strm.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_island_combine_metadata_006.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_island_combine_metadata_004.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_island_combine_metadata_005.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_island_combine_metadata_008.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_island_combine_metadata_001.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_island_lod.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_island_combine_metadata_011.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_island_combine_metadata_004_strm.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_island_strm.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_mph4_island.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_dlc_int_01_h4.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_dlc_int_02_h4.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_int_mp_yacht.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_dlc_int_05_h4.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_dlc_int_04_h4.ytyp"
data_file "DLC_ITYP_REQUEST" "stream/[Map]/cayoperico/stream/h4_dlc_int_03_h4.ytyp"

data_file "GTXD_PARENTING_DATA" "stream/[Map]/cayoperico/client/mph4_gtxd.meta"

data_file "SCALEFORM_DLC_FILE" "stream/[Map]/cayoperico/int3232302352.gfx"

files {
	"stream/[Map]/cayoperico/client/mph4_gtxd.meta",
	"stream/[Map]/cayoperico/int3232302352.gfx",
}

files({
	"stream/[PEDS]/data/**/peds.meta"
})

data_file "PED_METADATA_FILE" "stream/[PEDS]/data/**/peds.meta"

client_scripts {
  	"stream/[Map]/cayoperico/client/client.lua",
	"stream/[Map]/cayoperico/client/main.lua",
}