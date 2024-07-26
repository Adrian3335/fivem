fx_version 'cerulean'
game 'gta5'
author 'Noxon service'
lua54 'yes'

client_scripts {
    'client/*.*'
}

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'cfg.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.*'
}

escrow_ignore {
    'cfg.lua'
}

ui_page "web/index.html"
files {
	"web/**/*.*",
}