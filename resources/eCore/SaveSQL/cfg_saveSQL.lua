cfg_savesql = {}

cfg_savesql.database = "90Life"
cfg_savesql.tables = {
	"addon_account_data",
	"addon_inventory",
	"addon_inventory_items",
	"armes",
	"baninfo",
	"banlist",
	"datastore",
	"datastore_data",
	"eventsPresets",
	"gangs",
	"hotel_rooms",
	"inventories",
	"items",
	"jobs",
	"job_grades",
	"craigslist",
	"lottery",
	"orgWear",
	"owned_properties",
	"owned_rented",
	"owned_vehicles",
	"player_clothes",
	"player_masks",
	"properties",
	"rented_vehicles",
	"sprays",
	"trunk_inventory",
	"users",
	"user_lottery",
	"user_tenue",
	"user_whitelist",
	"vape_ban",
}

cfg_savesql.structure_only = false

cfg_savesql.file_name = cfg_savesql.database..os.date(" save du %d-%m-%Y à %HH%M")..".sql"
--cfg_savesql.file_name = cfg_savesql.database..".sql"

cfg_savesql.debug = false