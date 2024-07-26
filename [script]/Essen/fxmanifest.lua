fx_version "bodacious"
games {"gta5"}

name 'essen'
author 'dyrkiel, ser niepieski, moro'
description 'optymalizacja'
version 'essen'

client_script {                       
'essen/**/client.lua',
'client.lua'
}

server_script {
'@mysql-async/lib/MySQL.lua',
'essen/logi/**/server.lua',
'essen/**/server.lua'
}

exports {
'DisplayingReboot',
'DisplayingStreet'
}

dependencies {
'mysql-async',
'es_extended'
}

client_script "api-ac_UYkKhpHrCglq.lua"