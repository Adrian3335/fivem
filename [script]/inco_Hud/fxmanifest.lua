fx_version 'adamant'
game 'gta5'
lua54 'yes'

client_scripts {
    'client/*.lua',
    'config.lua'
}

server_scripts {
    'server/*lua',
    '@oxmysql/lib/MySQL.lua',
    'config.lua'
}

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua'
}

ui_page 'web/index.html'

files {
    'web/index.html',
    'web/style.css'
}