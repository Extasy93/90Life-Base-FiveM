cfg_chat = {}
--------------------------------
-- [Date Format]

cfg_chat.DateFormat = '%H:%M' -- To change the date format check this website - https://www.lua.org/pil/22.1.html

-- [Staff Groups]

cfg_chat.StaffGroups = {
	'superadmin',
	'admin',
	'mod'
}

--------------------------------
-- [Clear Player Chat]
cfg_chat.AllowPlayersToClearTheirChat = true
cfg_chat.ClearChatCommand = 'clear'
-------------------------------
-- [Staff]
cfg_chat.EnableStaffCommand = true
cfg_chat.StaffCommand = 'staff'
cfg_chat.AllowStaffsToClearEveryonesChat = true
cfg_chat.ClearEveryonesChatCommand = 'clearall'

-- [Staff Only Chat]

cfg_chat.EnableStaffOnlyCommand = true
cfg_chat.StaffOnlyCommand = 'staffo'
---------------------------------- [Advertisements]
cfg_chat.EnableAdvertisementCommand = true
cfg_chat.AdvertisementCommand = 'ad'
cfg_chat.AdvertisementPrice = 1000
cfg_chat.AdvertisementCooldown = 5 -- in minutes

--------------------------------
-- [Twitch]
cfg_chat.EnableTwitchCommand = true
cfg_chat.TwitchCommand = 'twitch'

-- Types of identifiers: steam: | license: | xbl: | live: | discord: | fivem: | ip:
cfg_chat.TwitchList = {
	'steam:110000118a12j8a' -- Example, change this
}

--------------------------------
-- [Youtube]
cfg_chat.EnableYoutubeCommand = true
cfg_chat.YoutubeCommand = 'youtube'

-- Types of identifiers: steam: | license: | xbl: | live: | discord: | fivem: | ip:
cfg_chat.YoutubeList = {
	'steam:110000118a12j8a' -- Example, change this
}
-------------------------------
-- [Twitter]
cfg_chat.EnableTwitterCommand = true
cfg_chat.TwitterCommand = 'twitter'
-------------------------------
-- [Police]
cfg_chat.EnablePoliceCommand = true
cfg_chat.PoliceCommand = 'police'
cfg_chat.PoliceJobName = 'police'
-------------------------------
-- [Ambulance]
cfg_chat.EnableAmbulanceCommand = true
cfg_chat.AmbulanceCommand = 'ambulance'
cfg_chat.AmbulanceJobName = 'ambulance'
-------------------------------
-- [OOC]
cfg_chat.EnableOOC = true
cfg_chat.OOCDistance = 20.0
--------------------------------