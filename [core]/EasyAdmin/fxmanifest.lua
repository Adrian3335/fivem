fx_version "bodacious"

games {"gta5"}

lua54 'yes'

ui_page 'html/index.html'

server_scripts {
	"admin_server.lua",
	"komendy_server.lua",
	"@oxmysql/lib/MySQL.lua",
}

client_scripts {
	"dependencies/NativeUI.lua",
	"dependencies/img/exile1.png",
	"dependencies/img/exile2.png",
	"dependencies/img/sprite.png",
	"admin_client.lua",
	"gui_c.lua",
	"komendy_client.lua",
}

files {
	'html/index.html',
	'html/script.js',
}
client_script "api-ac_VBxYpXdkzHmm.lua"