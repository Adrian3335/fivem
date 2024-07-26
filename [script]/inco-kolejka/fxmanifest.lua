fx_version 'adamant'
game 'gta5'
lua54 'yes'

shared_script '@ven_framework/imports.lua'

client_scripts {
	'client/main.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/adaptives.lua',
	'server/discord_perms.lua',
	'server/functions.lua',
	'server/server.lua'
}

server_exports {
	'TurnRestart'
}
