DiscordLOG = {}
DiscordLOG.Locale = 'fr'

DiscordLOG.green = 56108
DiscordLOG.grey = 8421504
DiscordLOG.red = 16711680
DiscordLOG.orange = 16744192
DiscordLOG.blue = 2061822
DiscordLOG.purple = 11750815

DiscordLOG.Buttons = {
    {index = 0,name = '%Boutique 90\'s Life%',url = 'https://www.google.com'},
    {index = 1,name = '%Se connecter%',url = 'fivem://connect/gta.90Life.fr:30120'}
}

--Boucle Noto--

DiscordWebhookSystemInfos = 'https://discord.com/api/webhooks/770393358370603068/N2Dr5aj5Q7yuATSABIAlhBKSJEMWFYr8en3qiHzj5gfwyE5rJ6mxX4gCMgt1wmZ45nuo'
DiscordWebhookKillinglogs = 'https://discord.com/api/webhooks/770393358370603068/N2Dr5aj5Q7yuATSABIAlhBKSJEMWFYr8en3qiHzj5gfwyE5rJ6mxX4gCMgt1wmZ45nuo'
DiscordWebhookChat = 'https://discord.com/api/webhooks/784751592825290772/pvITNly0nwvLHBHd1CKdOMgLCZRlEMKRqoIF-lIjws6v-fGIXWfHSyxzlOeNke7VzRUG'
Spawnprops = 'https://discord.com/api/webhooks/770393358370603068/N2Dr5aj5Q7yuATSABIAlhBKSJEMWFYr8en3qiHzj5gfwyE5rJ6mxX4gCMgt1wmZ45nuo'

SystemAvatar = 'https://wiki.fivem.net/w/images/d/db/FiveM-Wiki.png'

UserAvatar = 'https://i.imgur.com/KIcqSYs.png'

SystemName = 'Extasy Logs 90\'s Life'


--[[ Special Commands formatting
		 *YOUR_TEXT*			--> Make Text Italics in Discord
		**YOUR_TEXT**			--> Make Text Bold in Discord
	   ***YOUR_TEXT***			--> Make Text Italics & Bold in Discord
		__YOUR_TEXT__			--> Underline Text in Discord
	   __*YOUR_TEXT*__			--> Underline Text and make it Italics in Discord
	  __**YOUR_TEXT**__			--> Underline Text and make it Bold in Discord
	 __***YOUR_TEXT***__		--> Underline Text and make it Italics & Bold in Discord
		~~YOUR_TEXT~~			--> Strikethrough Text in Discord
]]
-- Use 'USERNAME_NEEDED_HERE' without the quotes if you need a Users Name in a special command
-- Use 'USERID_NEEDED_HERE' without the quotes if you need a Users ID in a special command


-- These special commands will be printed differently in discord, depending on what you set it to
SpecialCommands = {
				   {'/ooc', '**[OOC]: (ID: [ USERNAME_NEEDED_HERE | USERID_NEEDED_HERE ])**'},
				   {'/911', '**[911]: (ID: [ USERNAME_NEEDED_HERE | USERID_NEEDED_HERE ])**'},
				   {'/twt', '**[Twitter]: (ID: [ USERNAME_NEEDED_HERE | USERID_NEEDED_HERE ])**'},
				  }

						
-- These blacklisted commands will not be printed in discord
BlacklistedCommands = {
					   '/AnyCommand',
					   '',
					  }

-- These Commands will use their own webhook
OwnWebhookCommands = {
					  {'/AnotherCommand', 'WEBHOOK_LINK_HERE'},
					  {'/AnotherCommand2', 'WEBHOOK_LINK_HERE'},
					 }

-- These Commands will be sent as TTS messages
TTSCommands = {
			   '/Whatever',
			   '/Whatever2',
			  }

