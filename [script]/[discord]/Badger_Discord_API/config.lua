Config = {
	Guild_ID = '1266030239415406726', -- Set to the ID of your guild (or your Primary guild if using Multiguild)
	Multiguild = false, -- Set to true if you want to use multiple guilds
	Guilds = {
		["pdrp"] = "1266030239415406726", -- Replace this with a name, like "main"
	},
	Bot_Token = 'OTYwMTU5NDYyOTM1NjI1NzQ4.GdCRO6.PjF4RRFeO9dN9na5DAu1ooriOGd-X_0OkdRQtY',
	RoleList = {
		["member"] = "1266044268267569257",
		["trialsupport"] = "1266043406862389441",
		["support"] = "1266043433542221915",
		["moderator"] = "1266043432955285594",
		["admin"] = "1266043432116293745",
		["superadmin"] = "1266043431201804449",
		["best"] = "1266043425975701695",
	},
	DebugScript = false,
	CacheDiscordRoles = true, -- true to cache player roles, false to make a new Discord Request every time
	CacheDiscordRolesTime = 60, -- if CacheDiscordRoles is true, how long to cache roles before clearing (in seconds)
}

Config.Splash = {
	Header_IMG = '',
	Enabled = false,
	Wait = 10, -- How many seconds should splash page be shown for? (Max is 12)
	Heading1 = "Welcome to [ServerName]",
	Heading2 = "Make sure to join our Discord and check out our website!",
	Discord_Link = 'https://discord.gg/9SwAzDPY',
	Website_Link = '',
}